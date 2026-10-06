# API and search behavior

Use `[base] = http://localhost:8080/fhir` for a default local deployment. JSON is the
configured default; request `Accept: application/fhir+json`. HAPI generates server
metadata at `[base]/metadata`. The guide's CapabilityStatement is a separate,
source-derived description; it is not a captured metadata response.

## Supported interactions

All 14 resource providers declare `@Search`. None declares `@Read`. A generated
resource ID or reference does not imply that `GET [base]/Resource/id` is supported.
There are no resource create, update, patch, delete, history, or `$docref` handlers.

| Resource | Declared search parameters | Actual behavior |
| --- | --- | --- |
| Patient | `name` (string), `identifier` (token) | Case-insensitive name substring and normalized CPR value; accepts the DK Core CPR system or legacy `urn:dk:cpr`, and system-less searches. Other explicit systems return no matches. Searches the person-selection list, which can include delegates. |
| Observation | `date` (date), `category` (token) | Category routes to labs or home measurements; only the first category is used. See below. No `code` or `patient` filter. |
| Condition | None | Combines diagnoses and e-journal course diagnoses. |
| Encounter | None | Retrieves contact periods for the available e-journal courses. |
| DocumentReference | None | Retrieves discharge summaries and notes per course. |
| MedicationStatement | `status` (token), `_sourceId` (string), `identifier` (token) | Identifier value directly selects ordination details, bypassing status filtering. Otherwise loads medicine card using source override, configuration, or GP organization ID; empty source is allowed. Status filters active/completed/stopped; other values leave entries unfiltered. |
| MedicationRequest | `identifier` (token) | Identifier selects an **ordination**, even if a prescription namespace is supplied. Without it, ordination details and prescriptions are combined. Prescription fetch failures can return ordinations only. No `status` filter. |
| Immunization | `status` (token) | Effectuated records only. `completed` and `not-done` filter flags; `intended` returns empty. Unknown status leaves records unfiltered. |
| ImagingStudy | `identifier` (token), `study` (token) | Values select referral and study upstream; otherwise list and expand referrals. Token systems ignored. |
| DiagnosticReport | `identifier` (token), `study` (token) | Same upstream selectors as ImagingStudy. Only reports survive provider filtering. |
| Appointment | `date` (date) | Upstream date window followed by local filtering on appointment start. |
| Organization | `identifier` (token) | CVR when system is `http://cvr.dk` or legacy `urn:dk:cvr`; a system-less eight-character value also means CVR, otherwise an integer organization ID. Unsupported explicit systems do not match. CVR alone filters the resolved GP organization, not a national directory search. |
| CarePlan | None | All plans returned by the session-scoped upstream source. |
| ServiceRequest | None | Active and earlier referrals. |

Immunization additionally reads raw `history=true` to fetch history notes. It is not
an annotated search parameter and may not appear in generated metadata. No FHIR
SearchParameter is published for this enrichment switch. Custom `_sourceId` and
`study` SearchParameters describe upstream selection, so have no FHIRPath expression.

Parameters outside this table have no application-level implementation. HAPI may
handle framework parameters, but this guide does not promise `_include`, sorting,
pagination controls, token AND/OR semantics, or ignored-parameter behavior.

## Observation routing and dates

* `vital-signs`, `vitalsigns`, or a value containing `hjemmemåling` routes to home measurements. The `date` parameter is ignored on this branch.
* Values containing `mikro` select laboratory area `Mikrobiologi`.
* Values containing `patologi` select `Patologi`.
* Values containing `klinisk` or `biokemi` select `KliniskBiokemi`.
* Other values, including plain `laboratory`, absent category, and `therapy`, select laboratory area `Alle`.

The medication-overview service and mapper exist, but the current provider does not
call them. `category=therapy` does **not** expose medication overview observations.

Laboratory calls use `/app/proevesvarportal/api/v1/svaroversigt` with
`source=RegionaleProevesvar`. An omitted date range defaults to six months ago through
today. Summary laboratory retrieval instead uses twelve months.
The providers strip `ge`/`gt` to a start and `le`/`lt` to an end, and map `eq` to both.
Strict greater/less-than boundaries are not preserved. The client expands partial
year/month dates to range boundaries; full timestamps are retained for labs.

Appointment requests default to one year ago through one year ahead. Upstream calls
use **POST with a date-window body**, despite the read-only FHIR search surface.
Local filtering includes both endpoints and compares appointment start, with partial
date bounds expanded in UTC. Do not assume full FHIR date-search semantics.

## Authentication and patient context

Dhroxy forwards allowed incoming headers and supplements missing ones with configured
fallback headers. Incoming values take precedence. Typical session headers include
`cookie`, `x-xsrf-token`, and `conversation-uuid`. The allowlist also covers `accept`,
`referer`, `user-agent`, `accept-language`, `page-app-id`, `dnt`, and
`x-queueit-ajaxpageurl`. Configuration can change this behavior.

Patient search filters do not switch the upstream clinical session. There is no general
`patient` search parameter. Clinical-session services resolve CPR through the journal overview using the same forwarded headers; unavailable identity becomes a Patient reference with data-absent-reason `unknown`. No `current` identifier is emitted. Keep the session stable throughout a request and never merge unidentified resources across patients.
Use a trusted deployment boundary with transport protection; this guide does not
declare an OAuth or SMART flow that the implementation does not have.

```sh
curl --get 'http://localhost:8080/fhir/Observation' \
  --data-urlencode 'category=laboratory' \
  --data-urlencode 'date=ge2026-01-01' \
  --data-urlencode 'date=le2026-10-06' \
  -H 'Accept: application/fhir+json' \
  -H "Cookie: ${SUNDHED_COOKIE}" \
  -H "x-xsrf-token: ${SUNDHED_XSRF_TOKEN}" \
  -H "conversation-uuid: ${SUNDHED_CONVERSATION_UUID}"
```

The environment variables above are caller-supplied placeholders, not credentials
included in this guide.

## Bundles, transactions, and errors

Search providers extract matching resource types from mapper bundles and hand them to
`SimpleBundleProvider`. HAPI constructs the wire searchset. Mapper `fullUrl`, `total`,
and links are not necessarily preserved. In particular, the DiagnosticReport provider
discards ImagingStudy entries that its mapper included, leaving report references unresolved.

`POST [base]` accepts only `Bundle.type=transaction` with GET entries and returns a
`transaction-response` on success. Use relative search URLs such as `Patient` and
`Observation?category=laboratory`. The implementation dispatches nested requests through
an internal servlet request builder. It does **not** copy the outer session headers,
so authenticated upstream calls may require configured fallback headers. Repeated query
keys collapse into a map, and values are not explicitly URL-decoded. Two `date` keys in
one transaction entry therefore do not preserve an ordinary date-range search.

No read handler becomes available through transactions. Operation paths are not
reliably dispatched by this parser; invoke `$summary` directly. A non-GET entry,
non-transaction bundle, or failed nested request causes an invalid-request exception;
the implementation does not return a successful envelope with individual failed entries.

Upstream errors are not uniformly translated. Some calls throw response exceptions;
appointment failures can become empty results, and prescription failures can produce
partial results. HAPI may serialize exceptions as OperationOutcome, but no universal
upstream-status preservation or completeness indicator is implemented. A generic
OperationOutcome example in this guide illustrates the R4 structure only.

The MCP bridge advertises generic read, search, and transaction tools. Those tools
dispatch into this same FHIR server and do not add resource interactions.
