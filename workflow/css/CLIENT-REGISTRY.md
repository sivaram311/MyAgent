# CSS clientId registry

**Mandatory:** reserve a `clientId` here before wiring a new app to CSS.  
Align with `app-id` used in ports / DB / deploy wrapper when possible.

**Versions:** this file is for `clientId` identity only. Live CSS release/tag and consumer→CSS pins live in  
`../deps/DEPENDENCY-MATRIX.md` (update on every promote — CONSCIOUS #13).

Status: `planned` | `registered` | `active` | `retired` | `waived-public-read`

---

## Known clients (from CSS README)

| clientId | App | Status | Notes |
|----------|-----|--------|-------|
| grok-dev | Grok Dev | registered | `E:\Source\grok_dev` |
| agent-platform | Persistent Agent Platform | active | `E:\MyWorkspace\persistent-agent-platform` |
| agent-portal | Agent Portal | active | `E:\MyWorkspace\agent-portal` |
| erpnext-bridge | ERPNext SSO bridge | planned | future |

---

## New applications

| clientId | App ID | Status | Drive / URL | Notes |
|----------|--------|--------|-------------|-------|
| h-drive-server | h-drive-server | waived-public-read | G:\apps\h-drive-server / https://hdrive.delena.buzz | No login; open CORS file expose by user design 2026-07-11 |
| stack-pilot | stack-pilot | waived-public-read | G:\apps\stack-pilot / https://control.delena.buzz | Auth disabled (`stackpilot.auth.enabled: false`); optional API key path remains in code; CSS IdP not used by design 2026-07-11 |
| agent-portal | agentverse | active | E:\MyWorkspace\agentverse-project | Intentional reuse: AgentVerse uses agent-portal clientId |
| proddeck | proddeck | active | E:\wt\proddeck-integrate · F:\apps\proddeck · G:\apps\proddeck · https://home.delena.buzz | Live **0.8.3** classic CSS Postgres; home-staging :4320; home-dev :3320; tag `v0.8.3` |
| trading-portal | trading-portal | active | E:\MyWorkspace\trading-portal · F/G:\apps\trading-portal | Live **0.1.0** `v0.1.0`; DEV `:3340/:3341` CSS `:9000`; F `:4340/:4341` JWKS css-next `:4910`; G `:5340/:5341` JWKS classic `:5900`; paper-only; no grok-dev clientId reuse |

### Template

```md
| my-shop | my-shop | planned | G:\apps\my-shop / https://my-shop.delena.buzz | Reserve before starter wiring |
```
