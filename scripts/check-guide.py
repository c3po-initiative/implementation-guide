#!/usr/bin/env python3
"""Check source coverage and artifact consistency; not a FHIR validator."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--source', type=Path, help='Optional dhroxy checkout to verify')
args = parser.parse_args()
errors = []


def check(condition, message):
    if not condition:
        errors.append(message)


manifest = json.loads((ROOT / 'source-manifest.json').read_text())
files = sorted((ROOT / 'fsh-generated/resources').glob('*.json'))
if not files:
    sys.exit('No compiled resources. Run sushi . first.')
artifacts = [json.loads(p.read_text()) for p in files]
by_type_id = {(r['resourceType'], r['id']): r for r in artifacts}
check(len(by_type_id) == len(artifacts), 'Duplicate resource type/id')
canonical = [r['url'] for r in artifacts if 'url' in r]
check(len(set(canonical)) == len(canonical), 'Duplicate canonical URL')
cap = by_type_id.get(('CapabilityStatement', 'DhroxyServer'), {})
rest = cap.get('rest', [{}])[0]
actual = {r['type']: r for r in rest.get('resource', [])}
check(set(actual) == set(manifest['providers']), 'Provider coverage mismatch')
for kind, params in manifest['providers'].items():
    resource = actual.get(kind, {})
    check({i['code'] for i in resource.get('interaction', [])} == {'search-type'},
          f'{kind}: unexpected interactions')
    check({(p['name'], p['type']) for p in resource.get('searchParam', [])} ==
          {tuple(p) for p in params}, f'{kind}: search parameter mismatch')
    check(('StructureDefinition', f'dhroxy-{kind.lower()}') in by_type_id,
          f'{kind}: missing profile')
    check(any(r['resourceType'] == kind for r in artifacts),
          f'{kind}: missing standalone example')


def walk(value):
    if isinstance(value, dict):
        yield value
        for child in value.values():
            yield from walk(child)
    elif isinstance(value, list):
        for child in value:
            yield from walk(child)


for resource in artifacts:
    check(re.fullmatch(r'[A-Za-z0-9.\-]{1,64}', resource['id']),
          f"Invalid id: {resource['id']}")
    if resource['resourceType'] == 'Bundle' and resource.get('type') == 'document':
        entries = resource.get('entry', [])
        check(entries and entries[0].get('resource', {}).get('resourceType') == 'Composition',
              f"{resource['id']}: document must start with Composition")
        urls = [entry.get('fullUrl') for entry in entries]
        check(len(set(urls)) == len(urls), f"{resource['id']}: duplicate fullUrls")
        for item in walk(resource):
            ref = item.get('reference', '')
            if ref.startswith('urn:uuid:'):
                check(ref in urls, f"{resource['id']}: unresolved document reference {ref}")
    if resource['resourceType'] not in {'ImplementationGuide', 'StructureDefinition',
                                      'CapabilityStatement', 'OperationDefinition', 'SearchParameter'}:
        for item in walk(resource):
            ref = item.get('reference', '')
            if re.fullmatch(r'[A-Z][A-Za-z]+/[A-Za-z0-9.\-]+', ref):
                check(tuple(ref.split('/')) in by_type_id, f'Unresolved example reference {ref}')
    for profile in resource.get('meta', {}).get('profile', []):
        if profile.startswith('https://example.org/fhir/dhroxy/'):
            check(profile in canonical, f'Unknown local profile {profile}')

pages = list((ROOT / 'input/pagecontent').glob('*.md'))
page_names = {p.stem for p in pages}
for page in pages:
    for link in re.findall(r'\]\(([^)]+)\)', page.read_text()):
        if re.fullmatch(r'[a-z-]+\.html', link):
            check(link == 'artifacts.html' or link.removesuffix('.html') in page_names,
                  f'{page.name}: broken local page link {link}')

if args.source:
    for name, digest in manifest['files'].items():
        path = args.source / name
        check(path.is_file() and hashlib.sha256(path.read_bytes()).hexdigest() == digest,
              f'Source changed or missing: {name}')
    provider_dir = args.source / 'src/main/kotlin/dhroxy/controller'
    observed = set()
    for path in provider_dir.glob('*Provider.kt'):
        content = path.read_text()
        if 'IResourceProvider' in content:
            observed.add(path.stem.removesuffix('Provider'))
    check(observed == set(manifest['providers']), 'New or removed source providers')

if errors:
    print('\n'.join('ERROR: ' + error for error in errors), file=sys.stderr)
    sys.exit(1)
print(f'PASS: {len(artifacts)} artifacts; {len(actual)} providers; {len(pages)} pages; '
      'example references and capability inventory consistent.' +
      (' Source hashes match.' if args.source else ''))
