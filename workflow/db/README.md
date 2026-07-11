# PostgreSQL schema-per-env (mandatory)

**Policy status:** user-approved 2026-07-11 — **keep**  
**Instance:** shared PostgreSQL on this machine — port **5432** (do not reassign; listed under shared infra in ports registry).

Apps that use Postgres must have **one schema per environment**. Never share a schema across DEV / PREPROD / PROD.

| File | Role |
|------|------|
| [conventions.md](./conventions.md) | Naming, roles, search_path rules |
| [SCHEMA-REGISTRY.md](./SCHEMA-REGISTRY.md) | Human-readable reservations |
| [registry.json](./registry.json) | Machine-readable copy |

Standing order: `workflow/CONSCIOUS.md` · Cursor rule: `.cursor/rules/db-schema-per-env.mdc`

---

## How to proceed

```text
1. App needs Postgres → reserve DB + schemas here first
2. Create database + schemas + roles (only after user confirms DDL if destructive)
3. Point each env’s app config at its own schema only
4. Run migrations per env/schema — never once against a shared schema
5. Prod deploy may use prod schema only when user says prod
```

### Checklist

- [ ] `app-id` matches port registry / deploy wrapper
- [ ] Database + three schemas reserved in `SCHEMA-REGISTRY.md` + `registry.json`
- [ ] DEV app (E:) → schema `dev` only
- [ ] PREPROD app (F:) → schema `preprod` only
- [ ] PROD app (G:) → schema `prod` only
- [ ] Role `search_path` locked to that schema (no cross-env writes)
