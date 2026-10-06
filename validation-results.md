# Validation results

Reviewed on 2026-10-06 against dhroxy commit
`d1d4c2fe0651bb576fa9246cae85674d0b8cddf8`.

## Source and compilation

* SUSHI 3.20.1: **0 errors**. One environment warning: its online latest-version
  check could not reach the npm registry. The installed version is pinned in package.json.
* 48 generated FHIR artifacts: 21 profiles, 21 standalone examples, a CapabilityStatement,
  an OperationDefinition, three SearchParameters, and the ImplementationGuide.
  Two additional inline instances form the summary document.
* `python3 scripts/check-guide.py --source ../dhroxy`: **passed**. All 14 providers
  match the capability inventory, all seven content pages have valid internal page
  links, examples resolve their local references, and reviewed source hashes match.
* The dhroxy source working tree was unchanged after this work.

## Example validation

HL7 FHIR Validator **6.9.5**, FHIR **4.0.1**, local profiles, example URLs explicitly
allowed, and `-tx n/a`: **21 examples, 0 errors, 4 warnings, 19 informational messages**.
Executed through `scripts/validate-examples.py`; full results are in
`validation-output/examples.json` after a local build.

The four warnings are two recommendations to provide Observation.performer and two
unavailable external DICOM ValueSets. Informational messages include terminology checks
that cannot be completed without a terminology server. No warning messages were suppressed.

An online terminology run with an older validator was stopped after it ceased making
progress; it is not counted as a passed terminology check. Validation of synthetic
examples does not establish conformance of live dhroxy output, nor IPS/IPA/DK Core
conformance. Current source defects remain documented in the guide.

## HTML guide and package

HL7 IG Publisher **2.3.4** completed successfully: **0 errors, 60 warnings,
35 informational messages, 0 broken links, and 0 invalid XHTML pages**.
The guide is in `output/en/index.html`, the FHIR package in `output/package.tgz`,
and the full QA report in `output/qa.html` (also `output/qa.txt` and `output/qa.json`).

The build used `-tx n/a`. Warnings remain visible for unresolved source-local identifier
namespaces, unavailable external terminology and DICOM definitions, optional performers,
and newer dependency versions. These are not a claim of complete terminology validation.
The required warnings-file header is present, but no suppression rules are configured.

The final build includes the local `dhroxy-template` theme with the European Patients’
Forum blue/green palette and attributed arrow, search, and help SVG icons. Desktop
Safari visual checks confirmed the homepage, navigation cards, footer attribution,
and resource-mapping table layout. The small hero label uses dark blue for contrast
against the pale green background. The themed rebuild retained the QA counts above.

## Build tools

The HTML build uses HL7 IG Publisher **2.3.4**, `fhir2.base.template#0.1.0`, Java 21,
and Jekyll. Java tools were run with isolated temporary package caches. An older
Publisher 1.8.25 was replaced after failing to generate its QA report with terminology
disabled; that failed run is not the final build result.

The canonical is still the documented `example.org` placeholder. Choose an owned
canonical and complete terminology and live-response validation before publication.
