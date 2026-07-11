# Schema registry (source of truth)

**Mandatory:** reserve here **before** creating schemas or wiring app datasource config.  
Mirror every change in `registry.json`.

Status: `reserved` | `active` | `retired`

Shared instance: `127.0.0.1:5432`

---

## Platform / shared

| Database | Schema | App ID | Env | Status | Notes |
|----------|--------|--------|-----|--------|-------|
| (server) | — | postgres | shared | active | Engine only — port 5432; superuser password reset 2026-07-11 (see `secrets/postgres.env`) |

---

## Applications

| App ID | Database | Schemas | Roles | Status | Notes |
|--------|----------|---------|-------|--------|-------|
| css | app_css | dev, preprod, prod | app_css_dev, app_css_preprod, app_css_prod | **active** | DDL applied 2026-07-11; CSS F::4900→preprod, G::5900→prod (PgConnection verified) |
| agent-portal | app_agent_portal | dev, preprod, prod | app_agent_portal_dev, app_agent_portal_preprod, app_agent_portal_prod | **active** | DDL applied 2026-07-11; F::4080→preprod, G::5080→prod; auth via prod CSS |

### Template

```md
| my-shop | app_my_shop | dev, preprod, prod | app_my_shop_dev, app_my_shop_preprod, app_my_shop_prod | reserved | Created after user confirms DDL |
```
