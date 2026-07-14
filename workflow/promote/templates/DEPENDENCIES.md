# Release dependencies — `<app-id>-<version>`

**Mandatory** for every promote pack under `H:\releases\<app-id>-<version>\`.  
Copy from `E:\MyAgent\workflow\promote\templates\DEPENDENCIES.md`.  
Update `E:\MyAgent\workflow\deps\DEPENDENCY-MATRIX.md` after GO + deploy.

## This release

| Field | Value |
|-------|-------|
| App ID | |
| App version | |
| App git tag | `vX.Y.Z` or _(none — use commit)_ |
| App git commit | |
| Release pack | `H:\releases\<app>-<ver>` |
| Gate | Q1 / Q2 |
| Session ID | |

## Upstream dependencies (runtime)

| Name | Version | Git tag | Release pack / artifact | clientId (if CSS) | Verified this gate? |
|------|---------|---------|-------------------------|-------------------|---------------------|
| css | 0.1.0 | `v0.1.0` | `H:\releases\css-0.1.0` | | yes / no / waived |

Add rows for other shared services (portal API, agentverse, etc.) when this app depends on them at runtime.

## Embedded / library pins (optional but required when used)

| Package | Version | Notes |
|---------|---------|-------|
| com.css:css-spring-boot-starter | | |

## Issuer / URLs used for this gate

| Env | CSS / auth base | Notes |
|-----|-----------------|-------|
| DEV | | |
| PREPROD | | |
| PROD | https://css.delena.buzz | |

## Matrix update

- [ ] `workflow/deps/DEPENDENCY-MATRIX.md` updated after successful deploy  
- [ ] `workflow/deps/DEPENDENCIES.json` updated in the same turn  
- [ ] ACTIVITY-LOG row names **git tag** + **dependency versions**
