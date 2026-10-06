Invoke `GET [base]/Patient/{id}/$summary`, where the mapper normally uses
`pat-{cpr}` as the patient ID. The operation returns a FHIR document Bundle directly,
with Composition as its first entry, a generated identifier, and a timestamp.
The guide publishes a local OperationDefinition to document this behavior.

The service obtains the clinical-session CPR from the journal overview before collecting
other sources. The requested ID must equal `pat-{normalized clinical CPR}`; a mismatch
or unavailable clinical CPR yields an invalid-request error. The URL cannot select a
different patient. Demographics are matched by that clinical CPR in the person-selection
response. All other calls continue to use the same upstream session headers.

## Document contents

| Content | Source | Composition section code (LOINC) |
| --- | --- | --- |
| Patient | Person selection matched to clinical-session CPR | Referenced by Composition.subject |
| Condition | Diagnoses and e-journal courses | `11450-4` problems |
| MedicationStatement | Medicine-card entries; requires resolved eservices ID in this service | `10160-0` medications |
| Allergy information | No allergy source is fetched | `48765-2`, `emptyReason=unavailable` |
| Immunization | Effectuated vaccinations | `11369-6` immunizations |
| Observation | Laboratory results from the last twelve months | `30954-2` results, omitted when none |

Composition has status `final`, type LOINC `60591-5`, and author display
`sundhed.dk via dhroxy`. This is source provenance text, not evidence of clinical sign-off.

The mapper asserts IPS profile URLs on Composition, Patient, Condition,
MedicationStatement, Immunization, and laboratory Observation. Those assertions alone
do not prove IPS conformance. The Composition and document Bundle targets remain R4-derived; the embedded Patient target derives from DK Core. This is not an IPS conformance claim.

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
