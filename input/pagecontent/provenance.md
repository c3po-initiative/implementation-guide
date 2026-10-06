# Source evidence

Repository: `dhroxy`. Base commit:
`3fe51bef5c4e31527dd0445745e12acfaea9203e`. Review date: 2026-10-06.
The initial review used a clean checkout. This revision also documents the local mapping
corrections listed in `source-manifest.json` under `workingTreeChanges`, applied after
the base commit. File digests describe that reviewed working tree, not the unmodified
commit. No upstream patient records were accessed or changed.

`source-manifest.json` in the guide repository contains SHA-256 digests for the reviewed
Kotlin files and supporting documents, plus the resource/search inventory. Run
`python3 scripts/check-guide.py --source ../dhroxy` to detect later changes.

| Evidence | Source path relative to dhroxy |
| --- | --- |
| R4 context | `src/main/kotlin/dhroxy/config/FhirConfig.kt` |
| Servlet, provider registration, JSON default | `src/main/kotlin/dhroxy/config/FhirRestfulServerConfig.kt` |
| Search/operation signatures | `src/main/kotlin/dhroxy/controller/*Provider.kt` |
| Nested GET dispatch | `src/main/kotlin/dhroxy/controller/TransactionProvider.kt`, `src/main/kotlin/dhroxy/mcp/RequestBuilder.kt` |
| Exact upstream paths, date defaults, header behavior | `src/main/kotlin/dhroxy/client/SundhedClient.kt` |
| Selection, filtering, aggregation | `src/main/kotlin/dhroxy/service/*Service.kt` |
| Field/status/identifier mappings | `src/main/kotlin/dhroxy/mapper/*Mapper.kt` |
| Summary patient context and document | `src/main/kotlin/dhroxy/service/PatientSummaryService.kt`, `src/main/kotlin/dhroxy/mapper/PatientSummaryMapper.kt` |
| Source data shapes | `src/main/kotlin/dhroxy/model/*.kt` |
| IPA-oriented expectations, not certification | `src/test/kotlin/dhroxy/conformance/IpaConformanceTest.kt` |
| Earlier stated scope | `readme.md`, `docs/fhir-mapping-notes.md` |
| Synthetic test harness | `src/test/kotlin/dhroxy/stub/`, `src/test/resources/sundhed-stub/fixtures.json` |

## Evidence precedence

Provider registration and executable routing determine supported interactions. Services
determine which client/mapper paths are reachable. Mappers determine actual field
population. Older documentation supplies design intent only where code does not implement
it. No request was made to a live authenticated sundhed.dk session.

Examples in this guide were newly authored from these mappings. They use invented
values and explicitly repair required-field gaps to illustrate valid R4 targets.
They are not fixtures extracted from a production session or evidence of output parity.

## External specifications

* [DK Core 3.7.0](https://hl7.dk/fhir/core/)
* [FHIR R4 ImplementationGuide](https://hl7.org/fhir/R4/implementationguide.html)
* [FHIR R4 REST API](https://hl7.org/fhir/R4/http.html)
* [FHIR R4 documents](https://hl7.org/fhir/R4/documents.html)
* [FHIR R4 resource definitions](https://hl7.org/fhir/R4/resourcelist.html)
* [FHIR Shorthand and SUSHI](https://fshschool.org/docs/)

External specifications define the standard; the source files establish dhroxy behavior.
CPR and CVR systems are aligned with DK Core. Source-local clinical terminology remains unchanged until a verified mapping is available.
