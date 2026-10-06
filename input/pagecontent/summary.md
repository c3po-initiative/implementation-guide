# Patient summary

Invoke `GET [base]/Patient/{id}/$summary`, where the mapper normally uses
`pat-{cpr}` as the patient ID. The operation returns a FHIR document Bundle directly,
with Composition as its first entry, a generated identifier, and a timestamp.
The guide publishes a local OperationDefinition to document this behavior.

The service removes `pat-` from the supplied ID and looks for matching demographics
in the person-selection response. All clinical calls still use the current upstream
session. The ID does not select or verify that clinical context. A missing demographic
match does not establish that the requested patient is authorized or that their data
was retrieved. Callers must not combine mismatched URL and session identities.

## Document contents

| Content | Source | Composition section code (LOINC) |
| --- | --- | --- |
| Patient | Person selection, plus CPR from URL ID | Referenced by Composition.subject |
| Condition | Diagnoses and e-journal courses | `11450-4` problems |
| MedicationStatement | Medicine-card entries; requires resolved eservices ID in this service | `10160-0` medications |
| Allergy information | No allergy source is fetched | `48765-2`, `emptyReason=unavailable` |
| Immunization | Effectuated vaccinations | `11369-6` immunizations |
| Observation | Laboratory results from the last twelve months | `30954-2` results, omitted when none |

Composition has status `final`, type LOINC `60591-5`, and author display
`sundhed.dk via dhroxy`. This is source provenance text, not evidence of clinical sign-off.

The mapper asserts IPS profile URLs on Composition, Patient, Condition,
MedicationStatement, Immunization, and laboratory Observation. Those assertions alone
do not prove IPS conformance. This guide uses base R4-derived summary profiles and
does not silently inherit IPS or DK Core requirements.

## Observed limitations

* Resource IDs are placed after `urn:uuid:` even when they are not UUIDs. The synthetic document example uses actual UUIDs to illustrate a valid envelope.
* The allergies section has `emptyReason` but no narrative or entry, conflicting with the R4 Composition section content invariant. The example adds narrative.
* Empty problems and medications produce “no known” coded entries. Lack of returned data does not justify a clinical assertion of absence, particularly when medication retrieval could not resolve an organization.
* Empty immunizations produce a “no information” Immunization without required occurrence. The guide's document example uses section narrative and unavailable reasons instead of inventing an administration event.
* Laboratory IDs in this separate mapper still use requisition alone; multiple analytes can collide, unlike the standalone lab mapper's composite IDs.
* Invalid dates can fall back to the current time, changing their clinical meaning.
* Summary mappings differ from standalone resources, including subject references, laboratory notes, and vaccination status fallbacks.

The document example is an explicitly corrected R4 illustration with a patient and
four sections indicating unavailable data. It is not a captured response and does not
claim IPS conformance. Validate actual summary output separately against the intended
IPS version before treating it as an interoperable IPS document.
