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
| agent-portal | Agent Portal (+ AgentVerse reuse) | active | Portal live **0.1.9** on css-next; AV-upgrade **0.3.8** reuses clientId |
| erpnext-bridge | ERPNext SSO bridge | planned | future |

---

## New applications

| clientId | App ID | Status | Drive / URL | Notes |
|----------|--------|--------|-------------|-------|
| h-drive-server | h-drive-server | waived-public-read | G:\apps\h-drive-server / https://hdrive.delena.buzz | No login; open CORS file expose by user design 2026-07-11 |
| stack-pilot | stack-pilot | waived-public-read | G:\apps\stack-pilot / https://control.delena.buzz | Auth disabled (`stackpilot.auth.enabled: false`); optional API key path remains in code; CSS IdP not used by design 2026-07-11 |
| proddeck | proddeck | active | E:\wt\proddeck-main-081 · F:\apps\proddeck · G:\apps\proddeck · https://home.delena.buzz | Live **0.8.4** / `v0.8.4` · **css-next hybrid**; home-staging :4320; home-dev :3320; BFF `:5910` |
| trading-portal | trading-portal | active | E:\MyWorkspace\trading-portal · F/G:\apps\trading-portal | Live **0.1.0** tip `cf5176d` (repo sivaram311/trading-portal); F JWKS classic `:4900`; G JWKS classic `:5900`; paper-only |

### Template

```md
| my-shop | my-shop | planned | G:\apps\my-shop / https://my-shop.delena.buzz | Reserve before starter wiring |
```
