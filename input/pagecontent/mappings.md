# Resource mappings

Paths below are the literals in `SundhedClient.kt`. Most use upstream GET; appointment
search uses upstream POST. Mapper output is described separately from the HAPI-generated
wire envelope. Fields not populated by these mappings retain base FHIR optionality and
are not implied to be available.

## Patient

Source: `/app/personvaelgerportal/api/v1/GetPersonSelection`, `personDelegationData`.
ID is `pat-` plus CPR, source ID, or a random UUID. CPR maps to `identifier` under
`urn:dk:cpr`. The last word of `name` becomes family, preceding words become given.
`relationType` becomes the external extension documented on the terminology page.
Birth date, administrative gender, address, and active status are not inferred.

## Observation: laboratory

Source: `/app/proevesvarportal/api/v1/svaroversigt`, laboratory results joined to
requisitions by requisition ID. The old `/api/labsvar/svaroversigt` path in the README
is not the current client path.

| Source | FHIR element / rule |
| --- | --- |
| Requisition ID (or sample number) + analysis type ID | `id = lab-{sanitized composite}`; missing composite falls back to UUID. |
| Requisition ID, laboratory sample number | Separate business `identifier` entries; neither alone uniquely identifies an analyte. |
| Status code, otherwise status text | `SvarEndeligt` / `KompletSvar` → final; `Foreloebigt` → preliminary; `Annulleret` → cancelled; otherwise unknown. |
| First examination's name and analysis code | `code.text`, local `code.coding`; fallback text is analysis type, result type, then value type. |
| Quantitative findings row 1, columns 9 and 10 | Decimal `valueQuantity.value` and optional unit; failed numeric conversion falls through to text. |
| Conclusion, diagnosis, microscopy, macroscopy HTML, then raw value | First available cleaned value becomes `valueString`. |
| Reference interval text | `referenceRange.text`. |
| Result date, otherwise collection time | `effectiveDateTime`; result date also becomes `issued`. |
| Requisition organization, otherwise examiner | `performer.display`. |
| Requisition CPR and patient name | `subject.identifier` and display; missing CPR can become an observation-ID hash under the CPR namespace, a known defect. |
| Analysis guidance and pathology text | `note`; HTML is stripped with limited entity decoding. |

All lab observations use category `laboratory`, including microbiology and pathology.
There is no laboratory DiagnosticReport mapper and no guaranteed UCUM encoding.

## Observation: home measurements

Source: `/app/hjemmemaalingerborger/api/v1/maalinger`, documents collection.
ID is `hm-` plus sanitized date and type/name. Status is final and category vital-signs.
Type or name becomes code text; date becomes effectiveDateTime. A numeric value with
a unit becomes Quantity; otherwise value and unit are joined as a string. Source is
preserved in a note. Subject is the `current` logical patient. Missing measurement names
can violate required `Observation.code`; this is not a validated Vital Signs profile.

## Condition

Sources: `/app/ejournalportalborger/api/ejournal/forloebsoversigt` and
`/app/diagnoserborger/api/v1/diagnoser`. Entries lacking both diagnosis name and code are
skipped. Course IDs use `cond-{key}`; diagnosis IDs use `cond-diag-{code}`. Same-code
diagnoses can collide. Code uses local diagnosis coding plus text. Clinical status is
active without end date and resolved otherwise; verification is always confirmed.
Start/end map to onset/abatement dateTime, course update time to recordedDate, and
diagnosis type to local category coding. Subject comes from the course response CPR
with hyphens removed, including for separately fetched diagnoses.

## Encounter

Sources: course overview, then `/app/ejournalportalborger/api/ejournal/kontaktperioder`
per course key. ID is `enc-{contact key}`, with contact and course identifiers.
Status is finished if source status contains Finished or an end date exists, planned
if status contains planned, otherwise in-progress. Dates map to period. Unit details
map to serviceProvider display and a composite identifier. Subject is a logical CPR
reference. Required class is not populated by the mapper.

## DocumentReference

Sources: course overview, then `/app/ejournalportalborger/api/ejournal/epikriser` and
`/app/ejournalportalborger/api/ejournal/notater`. IDs combine document kind, course key,
and array index, so source ordering can change identity. Status is current; note type
becomes type text, heading becomes description, start date becomes date, and CPR becomes
subject. Body text, otherwise free text, becomes UTF-8 attachment data with
`contentType=text/html`; FHIR JSON serializes it as base64. No Binary endpoint or
document retrieval operation is implemented. Consumers displaying the HTML should
apply appropriate sanitization to source content.

## MedicationStatement

Sources: `/app/medicinkort2borger/api/v1/ordinations/` or
`/app/medicinkort2borger/api/v1/ordinations/{id}/details` when identifier is supplied.
ID is `medstmt-{ordination}`. Medication is inline text with active-substance coding;
details can also carry ATC. Dosage text, treatment cause, start/end, and dosage end
populate dosage, reasonCode, effectivePeriod, and dateAsserted.

Card status maps active/missing → active, completed → completed, stopped/ended → stopped,
entered-in-error → entered-in-error, otherwise unknown. Detail status instead maps
negative consent → not-taken, otherwise active. Neither standalone branch populates
required subject. Offsetless card dates are interpreted as UTC; unparsable dates are omitted.

## MedicationRequest

Sources: ordinations and details as above, plus `/app/medicinkort2borger/api/v1/prescriptions/`.
Ordination IDs use `medreq-`; prescriptions use `presc-`. Intent is order. Ordination
status maps negative consent → stopped, otherwise active. Medication text/ATC,
source identifiers, authored date, treatment-cause note, administration route text,
dosage text, and creator display are preserved.

Prescription status maps afsluttet → completed; aktiv, åben, open → active; otherwise
unknown. Product name, strength, and form are joined for medication text. Prescription
and ordination IDs are identifiers. Prescription/created date maps to authoredOn,
cause to note, dosage to dosageInstruction, and validity dates to dispenseRequest.validityPeriod.
The mapper omits required subject in both branches. Prescription retrieval is best effort.

## Immunization

Source: `/app/vaccination/api/v1/effectuatedvaccinations/`; optional history from
`/app/vaccination/api/v1/effectuatedvaccinations/{id}/history`.
ID is `imm-{vaccinationIdentifier}`; the same key is retained as an identifier.
Vaccine name maps to vaccineCode text. Effectuated timestamp populates occurrenceDateTime
and recorded; performer becomes actor display. Patient is the logical `current` value.
Coverage duration, self-created flag, negative consent, and optional history become notes.
Negative consent or inactive status → not-done; active → completed; unknown flags can
leave status unset. Planned vaccinations are not mapped.

## ImagingStudy and DiagnosticReport

Sources: `/app/billedbeskrivelserborger/api/v1/billedbeskrivelser/henvisninger/`
and `/app/billedbeskrivelserborger/api/v1/billedbeskrivelser/henvisning/`, with
referral/study selectors. The service combines response `svar` arrays, losing some
top-level referral, requester, producer, and additional-information fields.

ImagingStudy ID is `img-{examination ID or image ID}`; status is available. Examination
date/name populate started/description. A minimal series and instance use source IDs
as UIDs, optional modality code, body-site display, and image title. These are not
verified DICOM UIDs. Subject and SOP class are missing; modality may also be missing.

DiagnosticReport ID is `dr-{report ID or referral ID}`; status is final, category uses
the observation-category imaging code, and code is report name/type or Billedbeskrivelse.
Date maps to effectiveDateTime, publication/date to issued, description to conclusion,
producer to performer display, and requester to resultsInterpreter display when retained.
The mapper creates study references and included studies; the provider retains reports
only. No DICOM retrieval endpoint or image pixels are exposed.

## Appointment

Source: POST `/app/aftalerborger/api/v1/aftaler/cpr`. ID is a new random UUID with `apt-`
prefix on each mapping. Source document ID is the business identifier. Status is booked;
type/title populate serviceType and description; timestamps become start/end.
Patient, performer, and location are all represented as accepted participants, with
logical patient identifier or organization/address display. Participants are conditional
on source availability, so empty input can violate R4 requirements.

## Organization

Sources: `/api/minlaegeorganization/` to resolve the current GP organization and
`/api/core/organisation/{id}` for details. ID is `org-{organizationId}` or a UUID fallback.
CVR maps to identifier. Display name, name, or a generated fallback becomes name.
Category becomes text and a lowercase/hyphenated local code. Address joins street,
house number, floor, door, and maps city/postal code/municipality with country DK.
Homepage becomes URL telecom and lastUpdated becomes meta.lastUpdated.

## CarePlan

Source: `/app/planerportalborger/api/v1/plans/`. Entries without title/name are skipped.
ID is `cp-{title and start date}`. Status maps active/aktiv, completed/afsluttet,
draft/kladde, revoked/annulleret; otherwise unknown. Intent is plan. Description,
parseable start/end period, and organization as author display are retained. Subject
is the logical `current` patient. Unparseable period dates are silently omitted.

## ServiceRequest

Source: `/app/DenNationaleHenvisningsformidling/api/v1/henvisninger`.
Active referrals map to active; previous referrals map to completed; intent is order.
ID is `ref-` plus the sanitized referral-date/specialty/referring-clinic composite,
capped to 64 characters with a hash on overflow; the full composite is also an identifier.
Specialty becomes code text; referral type/code becomes category; referring clinic and
recipient name become requester/performer display. Referral date maps to authoredOn
and occurrencePeriod.start, expiry to occurrencePeriod.end. Diagnoses and cleaned clinical
text become notes. Subject is the logical `current` patient.

## Supporting and dormant mappings

Composition and document Bundle are described on the [summary page](summary.html).
Search and transaction envelopes are described on the [API page](api.html).
MedicationOverviewMapper can generate detail or count-component Observations from
ordination/prescription overviews, including local systems under
`https://www.sundhed.dk/medicinkort/`; its service is not routed by ObservationProvider.
Planning-only resources are inventoried in the [conformance register](conformance.html).
