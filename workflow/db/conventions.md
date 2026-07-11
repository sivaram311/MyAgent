# PostgreSQL conventions (recommendation — approved)

## Shared instance

| Item | Value |
|------|-------|
| Host | `127.0.0.1` (or localhost) |
| Port | **5432** (shared infra — reserved) |
| Engine | PostgreSQL (installed on this machine) |

One server for all envs. Isolation is by **database + schema + role**, not by separate Postgres installs.

---

## Layout (required)

For each `app-id` that needs a DB:

| Object | Name | Purpose |
|--------|------|---------|
| Database | `app_<appid>` | One DB per app (`-` → `_`, e.g. `my-shop` → `app_my_shop`) |
| Schema | `dev` | DEV (E:) only |
| Schema | `preprod` | PREPROD (F:) only |
| Schema | `prod` | PROD (G:) only |
| Role | `app_<appid>_dev` | Login for DEV; `search_path = dev` |
| Role | `app_<appid>_preprod` | Login for PREPROD; `search_path = preprod` |
| Role | `app_<appid>_prod` | Login for PROD; `search_path = prod` |

### Example — app-id `billing-api`

```text
Database:  app_billing_api
Schemas:   dev | preprod | prod
Roles:     app_billing_api_dev | app_billing_api_preprod | app_billing_api_prod
```

Connection sketch (PROD):

```text
jdbc:postgresql://127.0.0.1:5432/app_billing_api?currentSchema=prod
# user: app_billing_api_prod
```

---

## Hard rules

1. **Schema follows env** — process on E: never uses `prod` / `preprod`; F: never uses `prod` or `dev`; G: uses `prod` only.
2. **No shared app schema** across envs.
3. **Reserve before create** — register in `SCHEMA-REGISTRY.md` before DDL / app config.
4. **Migrations are per schema** — run three times (or once per env) with the matching role.
5. **Passwords** stay in env files / secrets — never in MyAgent markdown registries.
6. **Drop schema / role / database** requires explicit user confirmation (machine safety).

---

## Mapping to drives & ports

| Env | Drive | Port range | DB schema | DB role suffix |
|-----|-------|------------|-----------|----------------|
| dev | E: | 3000–3999 | `dev` | `_dev` |
| preprod | F: | 4000–4999 | `preprod` | `_preprod` |
| prod | G: | 5000–5999 | `prod` | `_prod` |

Promote data deliberately (export/import or migration jobs). Do **not** point a lower env at a higher schema “just to test”.
