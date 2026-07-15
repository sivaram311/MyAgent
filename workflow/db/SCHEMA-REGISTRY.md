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
| css | app_css | dev, preprod, prod | app_css_dev, app_css_preprod, app_css_prod | **active** | DDL 2026-07-11; **all envs on Postgres**: DEV `:9000`→`dev` (profile `dev` / `scripts/start-dev.ps1`), F::4900→`preprod`, G::5900→`prod`. H2 only for `test`/`h2` profiles. |
| agent-portal | app_agent_portal | dev, preprod, prod | app_agent_portal_dev, app_agent_portal_preprod, app_agent_portal_prod | **active** | DDL applied 2026-07-11; F::4080→preprod, G::5080→prod; auth via prod CSS |
| trading-portal | app_trading_portal | dev, preprod, prod | app_trading_portal_dev, app_trading_portal_preprod, app_trading_portal_prod | **reserved** | GROK-DECISION-001 2026-07-15; Flyway V1 + 6 tables live in app_trading_portal.dev (2026-07-15); |

### Template

```md
| my-shop | app_my_shop | dev, preprod, prod | app_my_shop_dev, app_my_shop_preprod, app_my_shop_prod | reserved | Created after user confirms DDL |
```
