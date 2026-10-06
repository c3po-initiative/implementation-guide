<div class="dhroxy-hero">
  <p class="dhroxy-eyebrow">Danish health data · FHIR R4</p>
  <h1>Dhroxy FHIR implementation guide</h1>
  <p>Resource definitions, mappings, and examples for bringing authenticated sundhed.dk responses into FHIR R4.</p>
</div>

The FHIR servlet is mounted at `/fhir`. Clinical access is scoped by the upstream
session; the proxy has no local clinical persistence or built-in authentication.

This draft documents source commit `d1d4c2fe0651bb576fa9246cae85674d0b8cddf8`
as reviewed on 2026-10-06. Code takes precedence over older README and planning notes.
The canonical URL is a publication placeholder, not a deployed endpoint or an official
sundhed.dk, HL7 Denmark, or national implementation guide.

## Using the guide

<div class="dhroxy-guide-grid">
  <a class="dhroxy-card" href="api.html"><img src="assets/images/epf-search.svg" alt="" aria-hidden="true"/><strong>API behavior</strong><span>Search parameters, authentication, and transactions.</span></a>
  <a class="dhroxy-card" href="mappings.html"><img src="assets/images/epf-arrow.svg" alt="" aria-hidden="true"/><strong>Resource mappings</strong><span>From sundhed.dk source fields to FHIR resources.</span></a>
  <a class="dhroxy-card" href="terminology.html"><img src="assets/images/epf-search.svg" alt="" aria-hidden="true"/><strong>Identifiers &amp; terminology</strong><span>Code systems and identifier namespaces used by the implementation.</span></a>
  <a class="dhroxy-card" href="summary.html"><img src="assets/images/epf-help.svg" alt="" aria-hidden="true"/><strong>Patient summary</strong><span>The summary operation and its document structure.</span></a>
  <a class="dhroxy-card" href="conformance.html"><img src="assets/images/epf-help.svg" alt="" aria-hidden="true"/><strong>Conformance &amp; gaps</strong><span>Profile requirements, limitations, and validation.</span></a>
  <a class="dhroxy-card" href="artifacts.html"><img src="assets/images/epf-search.svg" alt="" aria-hidden="true"/><strong>Explore the artifacts</strong><span>Browse profiles, capabilities, and synthetic examples.</span></a>
</div>

[Source evidence](provenance.html) records the reviewed files and reproducible source baseline.

## Conformance language

The CapabilityStatement describes **implemented interaction support**. Profiles describe
**draft resource conformance targets** based on populated fields, retaining mandatory
FHIR R4 elements. They do not certify current server output. Optional mapped fields
remain optional; the profiles do not introduce a blanket Must Support obligation.
An element required by base R4 remains required even if an upstream field is missing.
The gap register identifies those cases rather than weakening the standard.

Examples use invented names, identifiers, and clinical values. They add explicitly
identified required elements where the mapper currently omits them. Never infer
clinical absence from an empty result or from missing source information.
