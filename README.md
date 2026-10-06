# Dhroxy FHIR implementation guide

FHIR R4 (4.0.1) guide derived from `dhroxy` commit
`d1d4c2fe0651bb576fa9246cae85674d0b8cddf8` plus the local mapping corrections
recorded in `source-manifest.json`, reviewed on 2026-10-06.

Start with [the guide](input/pagecontent/index.md), [API behavior](input/pagecontent/api.md),
[resource mappings](input/pagecontent/mappings.md), and [known gaps](input/pagecontent/conformance.md).
The guide covers all 14 registered resource providers, the patient summary document,
read-only transactions, and resources mentioned only in design notes.

## Build

Requires Node.js, Python 3.9+, and SUSHI 3.20.1.

```sh
npm install
npm test
```

With SUSHI already installed, run `sushi .` and `python3 scripts/check-guide.py`.
Compiled FHIR JSON is written to `fsh-generated/resources/`. SUSHI compilation
does not replace FHIR instance validation.

To generate the full HTML guide and FHIR package, use the HL7 IG Publisher:

```sh
java -jar /path/to/publisher.jar -ig ig.ini
```

The Publisher requires Java, Jekyll, and network access for packages and terminology.
Inspect `output/qa.html` before publication. To validate examples independently:

```sh
python3 scripts/validate-examples.py --validator /path/to/validator_cli.jar
```

This selects the examples registered in the IG, validates them against the local profiles,
and writes `validation-output/examples.json`. It defaults to local terminology checks;
pass `--tx https://tx.fhir.org/r4` to request external terminology validation, or
`--java-user-home /path/to/isolated/cache-home` to isolate the Java tools' package cache.

The rendered guide is `output/en/index.html`; the distributable FHIR package is
`output/package.tgz`. These generated files are ignored by Git. This project uses
the local `dhroxy-template`, based on `fhir2.base.template#0.1.0`; use a recent Publisher (tested with 2.3.4) and validator
(tested with 6.9.5). `input/ignoreWarnings.txt` contains no suppression rules: no validation
messages are suppressed. Offline builds can use `-tx n/a`, with incomplete terminology
verification reported in the QA output.

See [validation results](validation-results.md) for the checks performed on this draft.

## Visual theme

`dhroxy-template/` contains persistent header, footer, CSS, and icon customizations.
Its blue/green palette and three selected SVG icons come from the requested
[EPF Patient Empowerment reference](https://www.eu-patient.eu/policy/Policy/patient-empowerment/).
See [visual asset attribution](THIRD-PARTY-NOTICES.md). The assets are served locally;
the rendered guide does not fetch styles or icons from the reference site.
The theme also bundles `dnk.svg`, required by the upstream template when online
terminology resolves the Denmark jurisdiction to a flag. This avoids a CI-only
missing-image error that offline builds did not expose.
Edit the local theme, not the Publisher-generated `template/` or `output/` folders.
The local `fragment-pagebegin.html` overrides the header status markup from the pinned
base template so the title, release label, version, and jurisdiction form a centred
block. Keep this override in sync when upgrading `fhir2.base.template`.

## Scope and maintenance

`input/fsh/` contains profiles, examples, a CapabilityStatement, an OperationDefinition,
and custom SearchParameters. `input/pagecontent/` contains the human-readable guide.
`source-manifest.json` records source hashes; `scripts/check-guide.py --source ../dhroxy`
also checks that source files have not drifted since the review.

Profiles are draft conformance targets grounded in the mappers. Seven resource profiles inherit DK Core 3.7.0; see the conformance page for scope and deferred mappings. They preserve R4
requirements even where current mapper output violates them. Synthetic examples
illustrate those targets and are **not captured server responses**. This guide does
not assert conformance to IPS, IPA, DK Core, or to its own profiles for all server output.

The canonical `https://example.org/fhir/dhroxy` is deliberately a placeholder.
Choose an owned publication URL and replace it in `sushi-config.yaml` and the
canonical URLs in `input/fsh/capabilities.fsh` before publishing a release.
No publication or deployment is performed by this project.

Specification references: [FHIR R4 ImplementationGuide](https://hl7.org/fhir/R4/implementationguide.html),
[FHIR Shorthand and SUSHI](https://fshschool.org/docs/), and
[HL7 IG Publisher](https://github.com/HL7/fhir-ig-publisher).

