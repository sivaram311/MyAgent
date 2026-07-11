# CSS for all application builds

**Status:** approved direction 2026-07-11  
**Path:** `E:\MyWorkspace\centralized-security-system`  
**Workflow:** `workflow/css/`

When applications are built on this machine, they **reuse CSS** (SSO + RS256 JWT + JWKS) instead of per-app auth. Port **9000**; integrate via `clientId` + resource-server validation.
