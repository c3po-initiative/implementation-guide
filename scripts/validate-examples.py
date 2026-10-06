#!/usr/bin/env python3
"""Validate IG-registered examples with the official HL7 FHIR validator."""
import argparse
from collections import Counter
import json
from pathlib import Path
import subprocess
import sys

root = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--validator', type=Path, required=True, help='validator_cli.jar path')
parser.add_argument('--tx', default='n/a', help='Terminology server URL, or n/a for local checks')
parser.add_argument('--java-user-home', type=Path, help='Optional isolated Java package-cache home')
parser.add_argument('--output', type=Path, default=root / 'validation-output/examples.json')
args = parser.parse_args()
resources = root / 'fsh-generated/resources'
ig_path = resources / 'ImplementationGuide-dk.dhroxy.fhir.json'
if not ig_path.exists():
    sys.exit('Run sushi . first.')
ig = json.loads(ig_path.read_text())
examples = []
for entry in ig['definition']['resource']:
    if entry.get('exampleBoolean') or entry.get('exampleCanonical'):
        kind, identifier = entry['reference']['reference'].split('/')
        path = resources / f'{kind}-{identifier}.json'
        if not path.is_file():
            sys.exit(f'Missing example: {path}')
        examples.append(str(path))
if not examples:
    sys.exit('No examples registered in the ImplementationGuide.')
args.output.parent.mkdir(parents=True, exist_ok=True)
command = ['java']
if args.java_user_home:
    command.append(f'-Duser.home={args.java_user_home.resolve()}')
command += ['-jar', str(args.validator.resolve()), *examples, '-version', '4.0.1']
# Local StructureDefinitions now inherit DK Core. Load the IG's pinned packages
# explicitly so standalone validation resolves the same parents as the Publisher.
for dependency in ig.get('dependsOn', []):
    package_id, version = dependency.get('packageId'), dependency.get('version')
    if not package_id or not version:
        sys.exit('Every validation dependency must have a packageId and pinned version.')
    command += ['-ig', f'{package_id}#{version}']
command += ['-ig', str(resources), '-allow-example-urls', 'true', '-tx', args.tx,
            '-output', str(args.output.resolve())]
# Never reuse a stale result if validation fails before writing output.
args.output.unlink(missing_ok=True)
result = subprocess.run(command, cwd=root)
if not args.output.exists():
    sys.exit(result.returncode or 'Validator produced no result file.')
report = json.loads(args.output.read_text())
outcomes = [report] if report['resourceType'] == 'OperationOutcome' else [
    entry['resource'] for entry in report.get('entry', [])]
counts = Counter(issue['severity'] for outcome in outcomes for issue in outcome.get('issue', []))
print(f'Validated {len(examples)} examples: {dict(counts)}. Report: {args.output}')
sys.exit(1 if counts['error'] or counts['fatal'] else result.returncode)
