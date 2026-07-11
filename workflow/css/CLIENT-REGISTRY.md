# CSS clientId registry

**Mandatory:** reserve a `clientId` here before wiring a new app to CSS.  
Align with `app-id` used in ports / DB / deploy wrapper when possible.

Status: `planned` | `registered` | `active` | `retired`

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
| — | — | — | — | Add before first CSS login from the app |

### Template

```md
| my-shop | my-shop | planned | G:\apps\my-shop / https://my-shop.delena.buzz | Reserve before starter wiring |
```
