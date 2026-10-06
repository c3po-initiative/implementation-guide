Profile: DhroxyPatient
Parent: Patient
Id: dhroxy-patient
Title: "Dhroxy Patient"
Description: "Draft Patient conformance target based on dhroxy mappings. Current output limitations are documented in the conformance page."
* ^status = #draft
* id 1..1
* identifier ^short = "CPR uses urn:dk:cpr when present."
* name ^short = "Source name split at its last space; no inferred birth date or gender."

Profile: DhroxyObservation
Parent: Observation
Id: dhroxy-observation
Title: "Dhroxy Observation"
Description: "Draft Observation conformance target based on dhroxy mappings. Current output limitations are documented in the conformance page."
* ^status = #draft
* id 1..1
* code ^short = "Source test code/text; no terminology equivalence is inferred."
* subject ^short = "May be a logical identifier reference; see mapping gaps."
* value[x] ^short = "Numeric quantity or textual result."

Profile: DhroxyCondition
Parent: Condition
Id: dhroxy-condition
Title: "Dhroxy Condition"
Description: "Draft Condition conformance target based on dhroxy mappings. Current output limitations are documented in the conformance page."
* ^status = #draft
* id 1..1
* code ^short = "Source diagnosis text and local diagnosis code."
* subject ^short = "CPR logical reference when available."
* clinicalStatus ^short = "Active without an end date; resolved otherwise."

Profile: DhroxyEncounter
Parent: Encounter
Id: dhroxy-encounter
Title: "Dhroxy Encounter"
Description: "Draft Encounter conformance target based on dhroxy mappings. Current output limitations are documented in the conformance page."
* ^status = #draft
* id 1..1
* identifier ^short = "Contact-period and course keys."
* class ^short = "Class unknown: represented with a data-absent-reason extension."
* serviceProvider ^short = "Logical unit identifier and display."

Profile: DhroxyDocumentReference
Parent: DocumentReference
Id: dhroxy-documentreference
Title: "Dhroxy DocumentReference"
Description: "Draft DocumentReference conformance target based on dhroxy mappings. Current output limitations are documented in the conformance page."
* ^status = #draft
* id 1..1
* content.attachment ^short = "UTF-8 source HTML serialized as base64 data."
* subject ^short = "Logical CPR identifier reference."
* status = #current
* content.attachment.contentType = #text/html

Profile: DhroxyMedicationStatement
Parent: MedicationStatement
Id: dhroxy-medicationstatement
Title: "Dhroxy MedicationStatement"
Description: "Draft MedicationStatement conformance target based on dhroxy mappings. Current output limitations are documented in the conformance page."
* ^status = #draft
* id 1..1
* medication[x] ^short = "Medication text, optionally ATC and active-substance coding."
* subject ^short = "Session-scoped current patient logical reference."
* dosage ^short = "Source dosage and administration text."
* medication[x] only CodeableConcept

Profile: DhroxyMedicationRequest
Parent: MedicationRequest
Id: dhroxy-medicationrequest
Title: "Dhroxy MedicationRequest"
Description: "Draft MedicationRequest conformance target based on dhroxy mappings. Current output limitations are documented in the conformance page."
* ^status = #draft
* id 1..1
* medication[x] ^short = "Ordination medication or prescription product description."
* subject ^short = "Session-scoped current patient logical reference."
* identifier ^short = "Ordination, drug-medication, or prescription identifiers."
* intent = #order
* medication[x] only CodeableConcept

Profile: DhroxyImmunization
Parent: Immunization
Id: dhroxy-immunization
Title: "Dhroxy Immunization"
Description: "Draft Immunization conformance target based on dhroxy mappings. Current output limitations are documented in the conformance page."
* ^status = #draft
* id 1..1
* vaccineCode ^short = "Source vaccine text."
* patient ^short = "Session-scoped current patient logical reference."
* occurrence[x] ^short = "Effectuated date; required by R4 even if upstream omits it."

Profile: DhroxyImagingStudy
Parent: ImagingStudy
Id: dhroxy-imagingstudy
Title: "Dhroxy ImagingStudy"
Description: "Draft ImagingStudy conformance target based on dhroxy mappings. Current output limitations are documented in the conformance page."
* ^status = #draft
* id 1..1
* subject ^short = "Session-scoped current patient logical reference."
* series.instance.sopClass ^short = "Required by R4 when an instance is present; mapper omits it."
* status = #available

Profile: DhroxyDiagnosticReport
Parent: DiagnosticReport
Id: dhroxy-diagnosticreport
Title: "Dhroxy DiagnosticReport"
Description: "Draft DiagnosticReport conformance target based on dhroxy mappings. Current output limitations are documented in the conformance page."
* ^status = #draft
* id 1..1
* code ^short = "Report name/type or Billedbeskrivelse."
* imagingStudy ^short = "Current provider drops included studies; references can be unresolved."
* status = #final

Profile: DhroxyAppointment
Parent: Appointment
Id: dhroxy-appointment
Title: "Dhroxy Appointment"
Description: "Draft Appointment conformance target based on dhroxy mappings. Current output limitations are documented in the conformance page."
* ^status = #draft
* id 1..1
* identifier ^short = "Source document identifier; stable UUID-based resource ID when present."
* participant ^short = "Patient, performer, and location represented as participants."
* status = #booked

Profile: DhroxyOrganization
Parent: Organization
Id: dhroxy-organization
Title: "Dhroxy Organization"
Description: "Draft Organization conformance target based on dhroxy mappings. Current output limitations are documented in the conformance page."
* ^status = #draft
* id 1..1
* identifier ^short = "CVR identifier uses urn:dk:cvr."
* name ^short = "Display name, name, or generated fallback."

Profile: DhroxyCarePlan
Parent: CarePlan
Id: dhroxy-careplan
Title: "Dhroxy CarePlan"
Description: "Draft CarePlan conformance target based on dhroxy mappings. Current output limitations are documented in the conformance page."
* ^status = #draft
* id 1..1
* subject ^short = "Session-scoped current patient logical reference."
* title ^short = "Source title or name; untitled plans are skipped."
* intent = #plan
* title 1..1

Profile: DhroxyServiceRequest
Parent: ServiceRequest
Id: dhroxy-servicerequest
Title: "Dhroxy ServiceRequest"
Description: "Draft ServiceRequest conformance target based on dhroxy mappings. Current output limitations are documented in the conformance page."
* ^status = #draft
* id 1..1
* identifier ^short = "Lossless composite of referral date, specialty, and referring clinic."
* subject ^short = "Session-scoped current patient logical reference."
* intent = #order

Profile: DhroxyLabObservation
Parent: DhroxyObservation
Id: dhroxy-lab-observation
Title: "Dhroxy Laboratory Observation"
Description: "Laboratory results, including pathology and microbiology text, from proevesvarportal."
* category 1..*
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains laboratory 1..1
* category[laboratory] = http://terminology.hl7.org/CodeSystem/observation-category#laboratory
* value[x] only Quantity or string
* effective[x] only dateTime

Profile: DhroxyHomeObservation
Parent: DhroxyObservation
Id: dhroxy-home-observation
Title: "Dhroxy Home Measurement"
Description: "Home measurement tagged vital-signs by dhroxy; this is not a claim of conformance to the base Vital Signs profile."
* status = #final
* subject 1..1
* category 1..*
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains home 1..1
* category[home] = http://terminology.hl7.org/CodeSystem/observation-category#vital-signs
* value[x] only Quantity or string
* effective[x] only dateTime

Profile: DhroxySummaryComposition
Parent: Composition
Id: dhroxy-summary-composition
Title: "Dhroxy Patient Summary Composition"
Description: "Draft R4 summary structure; does not derive from or certify IPS."
* status = #final
* type = http://loinc.org#60591-5
* subject 1..1
* section 4..*
* section.code 1..1

Profile: DhroxySummaryBundle
Parent: Bundle
Id: dhroxy-summary-bundle
Title: "Dhroxy Patient Summary Document"
Description: "Document envelope with a Composition first; full R4 document rules still apply."
* type = #document
* identifier 1..1
* identifier.system 1..1
* identifier.value 1..1
* timestamp 1..1
* entry 2..*
* entry.fullUrl 1..1
* entry.resource 1..1

Profile: DhroxySearchBundle
Parent: Bundle
Id: dhroxy-search-bundle
Title: "Dhroxy Search Result"
Description: "Searchset envelope generated by HAPI from provider resources."
* type = #searchset

Profile: DhroxyTransaction
Parent: Bundle
Id: dhroxy-transaction
Title: "Dhroxy GET-only Transaction"
Description: "Transaction request accepting only GET entries. Nested authentication and query limitations are documented in the API page."
* type = #transaction
* entry.request 1..1
* entry.request.method = #GET
* entry.request.url 1..1

Profile: DhroxyTransactionResponse
Parent: Bundle
Id: dhroxy-transaction-response
Title: "Dhroxy Transaction Response"
Description: "Response bundle for a successful sequence of nested GET requests."
* type = #transaction-response
* entry.response 1..1
* entry.response.status 1..1
* entry.resource 1..1
