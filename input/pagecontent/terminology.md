# Identifiers and terminology

These are the literal namespaces used by dhroxy. A URI in the source code is not
evidence that its owner publishes a corresponding CodeSystem, NamingSystem, or
StructureDefinition. This guide does not mint definitions under sundhed.dk's authority
or assert equivalence with national or international terminology.

| Namespace | Meaning in the source |
| --- | --- |
| `urn:dk:cpr` | Patient identifier and logical patient references. Preserve exactly; not a claim of DK Core CPR identifier conformance. |
| `urn:dk:cvr` | Organization CVR identifier. |
| `https://www.sundhed.dk/patient` | Literal value `current` for a session-scoped patient. |
| `https://www.sundhed.dk/labsvar/rekvisition` | Requisition key, shared by multiple results. |
| `https://www.sundhed.dk/labsvar/proevenummer` | Laboratory sample number. |
| `https://www.sundhed.dk/ejournal/forloeb` | E-journal course key. |
| `https://www.sundhed.dk/ejournal/kontaktperiode` | Contact-period key. |
| `https://www.sundhed.dk/ejournal/enhed` | Composite unit identifier. |
| `https://www.sundhed.dk/diagnoser` | Diagnosis-code-derived business identifier. |
| `https://www.sundhed.dk/medication/ordination` | MedicationStatement ordination identifier. |
| `https://www.sundhed.dk/medicinkort/ordination` | MedicationRequest / dormant overview ordination identifier; distinct from the preceding URI. |
| `https://www.sundhed.dk/medicinkort/drug-medication` | Drug-medication identifier. |
| `https://www.sundhed.dk/recept` | Prescription identifier. |
| `https://www.sundhed.dk/vaccination/id` | Effectuated vaccination identifier. |
| `https://www.sundhed.dk/imaging/report` | Imaging report ID. |
| `https://www.sundhed.dk/imaging/henvisning` | Imaging referral ID from a report. |
| `https://www.sundhed.dk/imaging/referral` | Referral response ID; top-level fields can be lost in service merging. |
| `https://www.sundhed.dk/imaging/undersoegelse` | Imaging examination ID. |
| `https://www.sundhed.dk/imaging/billed` | Image ID. |
| `https://www.sundhed.dk/appointments/documentId` | Appointment source document ID. |
| `https://www.sundhed.dk/henvisning` | Composite referral business key. |
| `https://www.sundhed.dk/fhir/ips` | Generated summary document identifier. |

## Coding systems

Source-local coding URIs include `https://www.sundhed.dk/codes/labsvar`,
`https://www.sundhed.dk/diagnosekode`, `https://www.sundhed.dk/diagnosetype`,
`https://www.sundhed.dk/medication/active-substance`,
`https://www.sundhed.dk/appointments/type`,
`https://www.sundhed.dk/organization/category`, and
`https://www.sundhed.dk/henvisning/type`. No complete enumerations are provided by
the reviewed code, so this guide does not invent required ValueSets for them.

ATC codes use `http://www.whocc.no/atc`. Standard HL7 systems are used for condition
clinical/verification status and observation categories. Lab and home quantities normally
contain a numeric value and human-readable `unit` without a UCUM `system` or `code`.
Do not relabel these values as UCUM or translate local lab/diagnosis codes to LOINC,
SNOMED CT, or ICD-10 without a verified mapping.

Summary document and section codes use `http://loinc.org`. The summary's absent-data
codes use `http://hl7.org/fhir/uv/ips/CodeSystem/absent-unknown-uv-ips`; their use and
the resulting resources require IPS validation and clinical review.

## Observed extension

PatientMapper emits `https://www.sundhed.dk/fhir/StructureDefinition/relationType`
with `valueCode` copied from the person-selection relation type. The reviewed source
does not define its values or publish its StructureDefinition. It remains an unresolved
external extension, documented here without claiming ownership or assigning fabricated
semantics. The Patient profile permits base extensions; examples omit this optional
extension. A publisher-owned definition and agreed terminology are needed before it
can be treated as a validated extension contract.
