These are the literal namespaces used by dhroxy. A URI in the source code is not
evidence that its owner publishes a corresponding CodeSystem, NamingSystem, or
StructureDefinition. This guide does not mint definitions under sundhed.dk's authority
or assert equivalence with national or international terminology.

| Namespace | Meaning in the source |
| --- | --- |
| `urn:oid:1.2.208.176.1.2` | DK Core CPR system; normalized ten-digit CPR and official use in Kotlin output. |
| `http://cvr.dk` | DK Core CVR identifier system. |
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
| `https://www.sundhed.dk/imaging/referral` | Referral response ID; aggregation preserves top-level referral metadata. |
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
clinical/verification status and observation categories. Lab, home, and summary quantities use UCUM `http://unitsofmeasure.org` for the explicit known-unit set: `kg`, `g`, `mg`, `mmol/L`, `mol/L`, `mg/L`, `g/L`, `mg/dL`, `cm`, `m`, `%`, `mmHg`/`mm[Hg]`, and `°C`/`Cel`. Source unit text is retained; unfamiliar units receive no inferred code. Numbers without units are preserved as strings in lab and summary observations.
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

## DK Core alignment and migration

The guide depends on [DK Core 3.7.0](https://hl7.dk/fhir/core/). New output replaces
`urn:dk:cpr` and `urn:dk:cvr` with the standard systems above. Patient and Organization
searches still accept their respective legacy namespace as a transition alias; unknown
explicit namespaces do not match merely because the value looks like CPR or CVR.
Stored identifiers and client searches should migrate together. An omitted search
system remains supported. The old session identifier `current` is no longer emitted.

CPR format checking does not prove identity and does not apply a modulus-11 rule.
DK Core Organization requires a SOR, KOMBIT, or CVR identifier; an upstream record
without one cannot satisfy that target profile. No SOR value is fabricated. CVR values
are preserved from source and remain subject to DK Core's length and checksum validation.
