Instance: PatientExample
InstanceOf: DhroxyPatient
Title: "Patient — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "pat-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* identifier[cpr].system = "urn:oid:1.2.208.176.1.2"
* identifier[cpr].value = "0101010000"
* name[0].family = "Eksempel"
* name[0].given[0] = "Test"

Instance: LabExample
InstanceOf: DhroxyLabObservation
Title: "Lab — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "lab-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* status = #final
* category[laboratory].coding[0].system = "http://terminology.hl7.org/CodeSystem/observation-category"
* category[laboratory].coding[0].code = #laboratory
* code.text = "Synthetic laboratory measurement"
* subject.reference = "Patient/pat-example"
* effectiveDateTime = "2026-10-01T09:00:00+02:00"
* valueQuantity.value = 5.2
* valueQuantity.unit = "mmol/L"
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #mmol/L
* referenceRange[0].text = "Synthetic reference interval"

Instance: HomeExample
InstanceOf: DhroxyHomeObservation
Title: "Home — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "hm-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* status = #final
* category[home].coding[0].system = "http://terminology.hl7.org/CodeSystem/observation-category"
* category[home].coding[0].code = #vital-signs
* code.text = "Body weight"
* subject.reference = "Patient/pat-example"
* effectiveDateTime = "2026-10-01T08:00:00+02:00"
* valueQuantity.value = 70
* valueQuantity.unit = "kg"
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #kg

Instance: ConditionExample
InstanceOf: DhroxyCondition
Title: "Condition — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "cond-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* clinicalStatus.coding[0].system = "http://terminology.hl7.org/CodeSystem/condition-clinical"
* clinicalStatus.coding[0].code = #active
* verificationStatus.coding[0].system = "http://terminology.hl7.org/CodeSystem/condition-ver-status"
* verificationStatus.coding[0].code = #confirmed
* code.text = "Synthetic diagnosis"
* subject.reference = "Patient/pat-example"

Instance: EncounterExample
InstanceOf: DhroxyEncounter
Title: "Encounter — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "enc-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* status = #finished
* class.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
* class.code = #AMB
* subject.reference = "Patient/pat-example"
* period.start = "2026-10-01T09:00:00+02:00"
* period.end = "2026-10-01T10:00:00+02:00"

Instance: DocumentExample
InstanceOf: DhroxyDocumentReference
Title: "Document — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "doc-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* status = #current
* type.text = "Synthetic discharge note"
* subject.reference = "Patient/pat-example"
* content[0].attachment.contentType = #text/html
* content[0].attachment.data = "PHA+U3ludGhldGljIG5vdGUuPC9wPg=="
* content[0].attachment.title = "Synthetic note"

Instance: MedicationStatementExample
InstanceOf: DhroxyMedicationStatement
Title: "MedicationStatement — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "medstmt-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* status = #active
* medicationCodeableConcept.text = "Synthetic medication"
* subject.reference = "Patient/pat-example"
* dosage[0].text = "Synthetic dosage instruction; not for clinical use."

Instance: MedicationRequestExample
InstanceOf: DhroxyMedicationRequest
Title: "MedicationRequest — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "medreq-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Synthetic medication"
* subject.reference = "Patient/pat-example"
* identifier[0].system = "https://www.sundhed.dk/medicinkort/ordination"
* identifier[0].value = "example-ordination"

Instance: PrescriptionExample
InstanceOf: DhroxyMedicationRequest
Title: "Prescription — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "presc-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* status = #completed
* intent = #order
* medicationCodeableConcept.text = "Synthetic prescription product"
* subject.reference = "Patient/pat-example"
* identifier[0].system = "https://www.sundhed.dk/recept"
* identifier[0].value = "example-prescription"
* dispenseRequest.validityPeriod.start = "2026-01-01"
* dispenseRequest.validityPeriod.end = "2026-09-30"

Instance: ImmunizationExample
InstanceOf: DhroxyImmunization
Title: "Immunization — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "imm-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* status = #completed
* vaccineCode.text = "Synthetic vaccine"
* patient.reference = "Patient/pat-example"
* occurrenceDateTime = "2026-09-01T10:00:00+02:00"
* identifier[0].system = "https://www.sundhed.dk/vaccination/id"
* identifier[0].value = "123"

Instance: ImagingExample
InstanceOf: DhroxyImagingStudy
Title: "Imaging — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "img-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* status = #available
* subject.reference = "Patient/pat-example"
* description = "Synthetic imaging study"
* series[0].uid = "1.2.826.0.1.3680043.10.999.1"
* series[0].modality.system = "http://dicom.nema.org/resources/ontology/DCM"
* series[0].modality.code = #CT
* series[0].instance[0].uid = "1.2.826.0.1.3680043.10.999.2"
* series[0].instance[0].sopClass.system = "urn:ietf:rfc:3986"
* series[0].instance[0].sopClass.code = #urn:oid:1.2.840.10008.5.1.4.1.1.2
* series[0].instance[0].title = "Synthetic image metadata"

Instance: ReportExample
InstanceOf: DhroxyDiagnosticReport
Title: "Report — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "dr-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* status = #final
* code.text = "Synthetic imaging report"
* imagingStudy[0].reference = "ImagingStudy/img-example"
* conclusion = "Synthetic report; no clinical findings asserted."

* subject.reference = "Patient/pat-example"

Instance: AppointmentExample
InstanceOf: DhroxyAppointment
Title: "Appointment — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "apt-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* status = #booked
* description = "Synthetic appointment"
* start = "2026-10-07T09:00:00+02:00"
* end = "2026-10-07T09:30:00+02:00"
* participant[0].actor.reference = "Patient/pat-example"
* participant[0].status = #accepted

Instance: OrganizationExample
InstanceOf: DhroxyOrganization
Title: "Organization — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "org-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* identifier[CVR-ID].system = "http://cvr.dk"
* identifier[CVR-ID].value = "00000000"
* name = "Synthetic Clinic"
* address[0].city = "Example City"
* address[0].country = "DK"

Instance: CarePlanExample
InstanceOf: DhroxyCarePlan
Title: "CarePlan — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "cp-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* status = #active
* intent = #plan
* title = "Synthetic follow-up plan"
* subject.reference = "Patient/pat-example"

Instance: ReferralExample
InstanceOf: DhroxyServiceRequest
Title: "Referral — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "ref-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* status = #active
* intent = #order
* subject.reference = "Patient/pat-example"
* code.text = "Synthetic specialty referral"
* identifier[0].system = "https://www.sundhed.dk/henvisning"
* identifier[0].value = "2026-10-01-example-specialty-example-clinic"

Instance: OutcomeExample
InstanceOf: OperationOutcome
Title: "Outcome — synthetic example"
Description: "Invented target illustration, not a captured server response. See the conformance page for fields added to repair current mapper gaps."
Usage: #example
* id = "outcome-example"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic example. Not for clinical use.</div>"
* issue[0].severity = #error
* issue[0].code = #invalid
* issue[0].diagnostics = "Illustrative error only; actual upstream error translation varies."

Instance: SummaryPatient
InstanceOf: DhroxyPatient
Usage: #inline
* id = "11111111-1111-4111-8111-111111111111"
* identifier[cpr].value = "0101010000"
* name.text = "Synthetic Patient"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic patient.</div>"

Instance: SummaryComposition
InstanceOf: DhroxySummaryComposition
Usage: #inline
* id = "22222222-2222-4222-8222-222222222222"
* status = #final
* type = http://loinc.org#60591-5
* subject.reference = "urn:uuid:11111111-1111-4111-8111-111111111111"
* date = "2026-10-06T12:00:00+02:00"
* author.display = "Synthetic document author"
* title = "Synthetic patient summary"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Synthetic summary. Information unavailable.</div>"
* section[0].title = "Problems"
* section[0].code = http://loinc.org#11450-4
* section[0].text.status = #generated
* section[0].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Information unavailable in this synthetic illustration.</div>"
* section[0].emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#unavailable
* section[1].title = "Medications"
* section[1].code = http://loinc.org#10160-0
* section[1].text.status = #generated
* section[1].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Information unavailable in this synthetic illustration.</div>"
* section[1].emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#unavailable
* section[2].title = "Allergies"
* section[2].code = http://loinc.org#48765-2
* section[2].text.status = #generated
* section[2].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Information unavailable in this synthetic illustration.</div>"
* section[2].emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#unavailable
* section[3].title = "Immunizations"
* section[3].code = http://loinc.org#11369-6
* section[3].text.status = #generated
* section[3].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Information unavailable in this synthetic illustration.</div>"
* section[3].emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#unavailable

Instance: SummaryExample
InstanceOf: DhroxySummaryBundle
Title: "Synthetic R4 summary document"
Description: "Corrected R4 envelope, UUIDs and section narratives. Unavailable sections replace unsupported absence assertions. Does not claim IPS conformance."
Usage: #example
* id = "summary-example"
* type = #document
* identifier.system = "https://example.org/fhir/dhroxy/documents"
* identifier.value = "synthetic-summary-1"
* timestamp = "2026-10-06T12:00:00+02:00"
* entry[0].fullUrl = "urn:uuid:22222222-2222-4222-8222-222222222222"
* entry[0].resource = SummaryComposition
* entry[1].fullUrl = "urn:uuid:11111111-1111-4111-8111-111111111111"
* entry[1].resource = SummaryPatient

Instance: SearchExample
InstanceOf: DhroxySearchBundle
Title: "Synthetic Patient search result"
Description: "Illustrative HAPI-style searchset containing one invented Patient. It does not demonstrate read-by-ID support."
Usage: #example
* id = "search-example"
* type = #searchset
* total = 1
* link.relation = "self"
* link.url = "https://example.org/fhir/Patient"
* entry.fullUrl = "https://example.org/fhir/Patient/pat-example"
* entry.resource = PatientExample
* entry.search.mode = #match

Instance: TransactionExample
InstanceOf: DhroxyTransaction
Title: "Synthetic GET-only transaction"
Description: "Search Patient and laboratory Observation. Authentication forwarding and repeated query key limitations are documented on the API page."
Usage: #example
* id = "transaction-example"
* type = #transaction
* entry[0].request.method = #GET
* entry[0].request.url = "Patient"
* entry[1].request.method = #GET
* entry[1].request.url = "Observation?category=laboratory"

Instance: TransactionResponseExample
InstanceOf: DhroxyTransactionResponse
Title: "Synthetic transaction response entry"
Description: "Illustrates one successful Patient search response. A response to a transaction with multiple entries contains one response entry per request."
Usage: #example
* id = "transaction-response-example"
* type = #transaction-response
* entry.response.status = "200"
* entry.resource = SearchExample
