# Conformance and known gaps

## How to interpret the artifacts

Profiles derive from R4 4.0.1, with separate lab and home-measurement Observation
profiles, a summary Composition, and four Bundle profiles. They constrain established
mapper constants and document populated fields. They preserve base cardinalities and
do not assert that every server response conforms. The CapabilityStatement intentionally
does not claim these profiles as supported profiles before output validation is established.

Terminology and tooling dependencies are pinned for reproducible compilation. No
IPS, IPA, DK Core, or national certification is implied. The source's IPA test records
warnings and a Markdown report; it does not fail on conformance gaps.

## Implemented output gaps

| Area | Source evidence and consequence | Integration / correction target |
| --- | --- | --- |
| MedicationStatement and MedicationRequest | Standalone mappers omit required `subject`. | Resolve the session patient and populate subject before claiming R4 conformance. Examples explicitly add subject. |
| Encounter | Mapper omits required `class`. | Supply a supported class or a standard data-absent-reason extension; do not infer inpatient/outpatient status. Example supplies a synthetic class. |
| ImagingStudy | Missing required `subject` and instance `sopClass`; modality can also be absent. Source IDs are used as DICOM UIDs without verification. | Validate identifiers and populate mandatory clinical/DICOM elements; example adds synthetic subject, modality system, UID, and SOP class. |
| Condition | Required subject is only populated if e-journal CPR is present, including conditions from the separate diagnosis source. | Require a resolved patient context. |
| Immunization | Unknown active status can leave required status unset; missing effectuation time leaves required occurrence absent. | Represent unknown information explicitly without inventing an administration. `intended` is not an R4 Immunization status. |
| Appointment | Status is always booked; start/end and all participants depend on source availability. | Check required participant and appointment invariants before returning output. |
| Home Observation | Missing both source type and name can leave required code empty. Category alone does not satisfy the FHIR Vital Signs profile. | Retain available text and validate; do not claim Vital Signs profile support. |
| Resource identity | Several mappers truncate a slug to 64 characters then prepend a prefix; some never cap IDs. Random fallback IDs and always-random Appointment IDs prevent stable identity. | Enforce the total R4 ID length and preserve business keys. ReferralMapper already caps and hashes overflow. |
| Bundle identifiers | Several mappers and the summary prefix non-UUID resource IDs with `urn:uuid:`. Search providers rebuild bundles, but summary output retains this issue. | Use actual UUID URNs or valid absolute resource URLs. |
| Imaging references | DiagnosticReport provider drops ImagingStudy entries; mapper references point into the discarded bundle. | Include referenced studies with valid fullUrls or provide resolvable references. |
| Logical subject values | `current` is session-scoped; lab mapper can put an observation-ID hash under the CPR namespace when CPR is missing. | Do not interpret these as verified CPR numbers or join records globally by `current`. |
| Consent flags | Negative consent maps to medication stopped/not-taken and vaccination not-done. | These are observed mappings, not reliable clinical inferences about treatment or administration. Preserve provenance when interpreting. |
| Summary | Non-UUID URNs, collision-prone laboratory IDs, unsupported absence assertions, missing narrative and occurrence. | See the [summary page](summary.html); validate independently against a chosen IPS release. |
| Transactions | Outer headers are not forwarded; duplicate query keys collapse; no universal decoding. | Use direct searches for authenticated date ranges until dispatch is corrected. |
| Completeness and errors | Appointment errors can yield empty results; prescription errors can yield partial results. | Empty results must not be interpreted as clinical absence. |

## Stated, dormant, and unsupported resources

| Resource or feature | Evidence classification |
| --- | --- |
| Medication-overview Observation | Mapper and service exist, but no active FHIR provider branch invokes them. The `therapy` category uses the standard observation-category system with a code absent from that system. Do not copy this as valid terminology. |
| MedicationDispense | Mentioned in mapping notes; no provider/mapper implements it. |
| Schedule / Slot | Optional calendar ideas in mapping notes; not implemented. |
| AllergyIntolerance | Checked by the IPA report, but not exposed; summary has only an unavailable allergy section. |
| Medication | Checked by the IPA report, but not exposed; medications are inline CodeableConcepts. |
| Practitioner / PractitionerRole | Checked by the IPA report, but not exposed. Display-only references do not establish resources. |
| Composition | Implemented within `$summary`, not a searchable resource endpoint. |
| Bundle | Search/document/transaction envelopes, not a general Bundle resource endpoint. |
| OperationOutcome | Framework/error representation, not a resource provider. |
| Laboratory DiagnosticReport | Proposed in notes; current reports are imaging only. |
| Planned vaccinations | No implementation. `status=intended` yields an empty search; the proposed Immunization status is invalid in R4. |
| `_id`, `patient`, Observation `code`, DocumentReference `$docref`, resource reads | Requested by IPA-oriented tests or notes but absent from provider handlers. |
| HealthKit | Separate non-FHIR controller/model export; does not add FHIR resources or profiles. |

## Validation workflow

1. Compile with the pinned SUSHI version.
2. Run `scripts/check-guide.py` to verify artifact coverage, source provenance,
   example references, and advertised interactions.
3. Run the HL7 FHIR validator or IG Publisher for R4 invariants and profile validation.
4. Test actual dhroxy responses independently, using its synthetic stub and integration
   tests. Compilation and synthetic-example validation do not validate the live server.

See `validation-results.md` in the repository for checks performed while creating this
version. The examples are corrected target illustrations. All patient subject additions,
the Encounter class, imaging scaffolding corrections, and summary narrative/UUID changes
are intentional additions, not evidence that the source mapper emits those fields.

Reference requirements: [FHIR R4 resource definitions](https://hl7.org/fhir/R4/resourcelist.html),
[document bundles](https://hl7.org/fhir/R4/documents.html), and
[Immunization status](https://hl7.org/fhir/R4/valueset-immunization-status.html).

## Package dependencies

{% include dependency-table.xhtml %}

## Global profiles

{% include globals-table.xhtml %}

## Cross-version analysis

{% include cross-version-analysis.xhtml %}

## Intellectual property statements

{% include ip-statements.xhtml %}
