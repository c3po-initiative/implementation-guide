Instance: DhroxyServer
InstanceOf: CapabilityStatement
Usage: #definition
* url = "https://example.org/fhir/dhroxy/CapabilityStatement/DhroxyServer"
* name = "DhroxyServer"
* title = "Dhroxy Source-derived Server Capabilities"
* status = #draft
* experimental = true
* date = "2026-10-06"
* publisher = "Dhroxy contributors"
* kind = #instance
* implementation.description = "Source-derived capability description; deployment URL is not assigned."
* fhirVersion = #4.0.1
* format = #json
* description = "Search interactions observed in source. Resource profiles are draft targets, not certified server conformance. No read handlers, patient search filters, SMART authorization, or write interactions are declared."
* rest.mode = #server
* rest.security.description = "No built-in authentication. Forward upstream session headers through a trusted deployment. No SMART-on-FHIR support is implemented."
* rest.interaction.code = #transaction
* rest.resource[0].type = #Patient
* rest.resource[0].interaction.code = #search-type
* rest.resource[0].documentation = "See the API page for implemented filtering and mapper limitations. No read-by-ID handler exists."
* rest.resource[0].searchParam[0].name = "name"
* rest.resource[0].searchParam[0].type = #string
* rest.resource[0].searchParam[1].name = "identifier"
* rest.resource[0].searchParam[1].type = #token
* rest.resource[1].type = #Observation
* rest.resource[1].interaction.code = #search-type
* rest.resource[1].documentation = "See the API page for implemented filtering and mapper limitations. No read-by-ID handler exists."
* rest.resource[1].searchParam[0].name = "date"
* rest.resource[1].searchParam[0].type = #date
* rest.resource[1].searchParam[1].name = "category"
* rest.resource[1].searchParam[1].type = #token
* rest.resource[2].type = #Condition
* rest.resource[2].interaction.code = #search-type
* rest.resource[2].documentation = "See the API page for implemented filtering and mapper limitations. No read-by-ID handler exists."
* rest.resource[3].type = #Encounter
* rest.resource[3].interaction.code = #search-type
* rest.resource[3].documentation = "See the API page for implemented filtering and mapper limitations. No read-by-ID handler exists."
* rest.resource[4].type = #DocumentReference
* rest.resource[4].interaction.code = #search-type
* rest.resource[4].documentation = "See the API page for implemented filtering and mapper limitations. No read-by-ID handler exists."
* rest.resource[5].type = #MedicationStatement
* rest.resource[5].interaction.code = #search-type
* rest.resource[5].documentation = "See the API page for implemented filtering and mapper limitations. No read-by-ID handler exists."
* rest.resource[5].searchParam[0].name = "status"
* rest.resource[5].searchParam[0].type = #token
* rest.resource[5].searchParam[1].name = "_sourceId"
* rest.resource[5].searchParam[1].type = #string
* rest.resource[5].searchParam[1].definition = Canonical(DhroxyMedicationSource)
* rest.resource[5].searchParam[2].name = "identifier"
* rest.resource[5].searchParam[2].type = #token
* rest.resource[6].type = #MedicationRequest
* rest.resource[6].interaction.code = #search-type
* rest.resource[6].documentation = "See the API page for implemented filtering and mapper limitations. No read-by-ID handler exists."
* rest.resource[6].searchParam[0].name = "identifier"
* rest.resource[6].searchParam[0].type = #token
* rest.resource[7].type = #Immunization
* rest.resource[7].interaction.code = #search-type
* rest.resource[7].documentation = "See the API page for implemented filtering and mapper limitations. No read-by-ID handler exists."
* rest.resource[7].searchParam[0].name = "status"
* rest.resource[7].searchParam[0].type = #token
* rest.resource[8].type = #ImagingStudy
* rest.resource[8].interaction.code = #search-type
* rest.resource[8].documentation = "See the API page for implemented filtering and mapper limitations. No read-by-ID handler exists."
* rest.resource[8].searchParam[0].name = "identifier"
* rest.resource[8].searchParam[0].type = #token
* rest.resource[8].searchParam[1].name = "study"
* rest.resource[8].searchParam[1].type = #token
* rest.resource[8].searchParam[1].definition = Canonical(DhroxyImagingStudyStudy)
* rest.resource[9].type = #DiagnosticReport
* rest.resource[9].interaction.code = #search-type
* rest.resource[9].documentation = "See the API page for implemented filtering and mapper limitations. No read-by-ID handler exists."
* rest.resource[9].searchParam[0].name = "identifier"
* rest.resource[9].searchParam[0].type = #token
* rest.resource[9].searchParam[1].name = "study"
* rest.resource[9].searchParam[1].type = #token
* rest.resource[9].searchParam[1].definition = Canonical(DhroxyDiagnosticReportStudy)
* rest.resource[10].type = #Appointment
* rest.resource[10].interaction.code = #search-type
* rest.resource[10].documentation = "See the API page for implemented filtering and mapper limitations. No read-by-ID handler exists."
* rest.resource[10].searchParam[0].name = "date"
* rest.resource[10].searchParam[0].type = #date
* rest.resource[11].type = #Organization
* rest.resource[11].interaction.code = #search-type
* rest.resource[11].documentation = "See the API page for implemented filtering and mapper limitations. No read-by-ID handler exists."
* rest.resource[11].searchParam[0].name = "identifier"
* rest.resource[11].searchParam[0].type = #token
* rest.resource[12].type = #CarePlan
* rest.resource[12].interaction.code = #search-type
* rest.resource[12].documentation = "See the API page for implemented filtering and mapper limitations. No read-by-ID handler exists."
* rest.resource[13].type = #ServiceRequest
* rest.resource[13].interaction.code = #search-type
* rest.resource[13].documentation = "See the API page for implemented filtering and mapper limitations. No read-by-ID handler exists."
* rest.resource[0].operation.name = "summary"
* rest.resource[0].operation.definition = Canonical(DhroxyPatientSummary)

Instance: DhroxyPatientSummary
InstanceOf: OperationDefinition
Usage: #definition
* url = "https://example.org/fhir/dhroxy/OperationDefinition/DhroxyPatientSummary"
* name = "DhroxyPatientSummary"
* title = "Dhroxy Patient Summary"
* status = #draft
* kind = #operation
* date = "2026-10-06"
* code = #summary
* resource = #Patient
* system = false
* type = false
* instance = true
* affectsState = false
* description = "GET [base]/Patient/{id}/$summary. Uses the URL ID for demographics and upstream session for clinical data; caller must ensure they refer to the same person. Output carries IPS claims that have not been established by this guide."
* parameter.name = #return
* parameter.use = #out
* parameter.min = 1
* parameter.max = "1"
* parameter.type = #Bundle

Instance: DhroxyMedicationSource
InstanceOf: SearchParameter
Usage: #definition
* url = "https://example.org/fhir/dhroxy/SearchParameter/DhroxyMedicationSource"
* name = "DhroxyMedicationSource"
* status = #draft
* description = "Upstream medication-card eservices source override; not a filter over resource content."
* code = #_sourceId
* base = #MedicationStatement
* type = #string
// No FHIRPath expression: this parameter selects an upstream request.

Instance: DhroxyImagingStudyStudy
InstanceOf: SearchParameter
Usage: #definition
* url = "https://example.org/fhir/dhroxy/SearchParameter/DhroxyImagingStudyStudy"
* name = "DhroxyImagingStudyStudy"
* status = #draft
* description = "Upstream study selector passed with identifier to the imaging referral endpoint; token system is ignored."
* code = #study
* base = #ImagingStudy
* type = #token
// No FHIRPath expression: this parameter selects an upstream request.

Instance: DhroxyDiagnosticReportStudy
InstanceOf: SearchParameter
Usage: #definition
* url = "https://example.org/fhir/dhroxy/SearchParameter/DhroxyDiagnosticReportStudy"
* name = "DhroxyDiagnosticReportStudy"
* status = #draft
* description = "Upstream study selector passed with identifier to the imaging referral endpoint; token system is ignored."
* code = #study
* base = #DiagnosticReport
* type = #token
// No FHIRPath expression: this parameter selects an upstream request.
