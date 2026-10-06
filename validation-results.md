# Validation results

Reviewed on 2026-10-06 against dhroxy base commit
`d1d4c2fe0651bb576fa9246cae85674d0b8cddf8` plus the mapping corrections recorded
under `workingTreeChanges` in `source-manifest.json`.

## Source and compilation

* SUSHI 3.20.1: **0 errors**. One environment warning: its online latest-version
  check could not reach the npm registry. The installed version is pinned in package.json.
* 48 generated FHIR artifacts: 21 profiles, 21 standalone examples, a CapabilityStatement,
  an OperationDefinition, three SearchParameters, and the ImplementationGuide.
  Two additional inline instances form the summary document.
* `python3 scripts/check-guide.py --source ../dhroxy`: **passed**. All 14 providers
  match the capability inventory, all seven content pages have valid internal page
  links, examples resolve their local references, and reviewed source hashes match.
* The initial guide review left dhroxy unchanged. This revision includes the requested
  source fixes; the manifest hashes identify the reviewed working tree.

## Mapping corrections

The complete dhroxy Gradle test suite passed in a temporary copy containing the exact
changes applied to the source checkout: **96 tests, 0 failures, 0 errors, 0 skipped**.
The focused mapper/service run also passed all 57 tests. Eleven new regression tests
cover medication and imaging subjects, absent lab CPR, stable appointment identity,
unknown measurement codes and Encounter class, and preservation of per-referral imaging
metadata. Patient references use the existing session-scoped `current` convention;
this does not resolve a portable patient identity or certify live-output conformance.

## Published QA review

The [published QA report](https://build.fhir.org/ig/c3po-initiative/implementation-guide/branches/main/qa.html)
generated at 13:37:29 UTC on 2026-10-06 reported **0 resource validation errors,
24 warnings, 33 informational messages, and 333 broken links**. Every broken-link
error referred to the same missing `assets/images/dnk.svg` image. The local theme now
supplies that asset. The earlier offline build did not resolve the jurisdiction to a
flag, so it did not expose this problem.

The remaining published warnings concern unresolved identifier namespaces, external
DICOM/RadLex definitions, optional Observation performers, old package versions,
ambiguous terminology versions, an experimental inherited binding, and a profile
without its own example. These are separate from the source-mapping corrections.

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

HL7 IG Publisher **2.3.4** completed the revised online build successfully:
**0 errors, 27 warnings, 33 informational messages, 0 broken links, and
0 invalid XHTML pages**. All 333 generated pages that reference `dnk.svg` resolve
to the bundled asset. The checker inspected 218,120 links.
The guide is in `output/en/index.html`, the FHIR package in `output/package.tgz`,
and the full QA report in `output/qa.html` (also `output/qa.txt` and `output/qa.json`).

The revised build used `-tx https://tx.fhir.org/r4`. Its three additional warnings
relative to the published CI report all concern the unavailable DICOM CID 29 ValueSet
(two profile bindings and one example check). Warnings remain visible for unresolved
source-local identifier namespaces, unavailable external terminology and DICOM
definitions, optional performers, and dependency versions. These are not a claim of
complete terminology validation. The earlier offline build (`-tx n/a`) had 0 errors,
60 warnings, 35 informational messages, and no broken links, but did not exercise
the flag reference.
The required warnings-file header is present, but no suppression rules are configured.

The final build includes the local `dhroxy-template` theme with the European Patients’
Forum blue/green palette and attributed arrow, search, and help SVG icons. Desktop
Safari visual checks confirmed the homepage, navigation cards, footer attribution,
and resource-mapping table layout. The small hero label uses dark blue for contrast
against the pale green background. The latest rebuild also verifies the locally
bundled Denmark flag under the online terminology conditions that exposed the CI issue.

## Build tools

The HTML build uses HL7 IG Publisher **2.3.4**, `fhir2.base.template#0.1.0`, Java 21,
and Jekyll. Java tools were run with isolated temporary package caches. An older
Publisher 1.8.25 was replaced after failing to generate its QA report with terminology
disabled; that failed run is not the final build result.

The canonical is still the documented `example.org` placeholder. Choose an owned
canonical and complete terminology and live-response validation before publication.
