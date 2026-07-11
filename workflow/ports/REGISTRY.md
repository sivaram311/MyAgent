# Port registry (source of truth)

**Mandatory:** update this file **before** binding a new port.  
Mirror every change in `registry.json`.

Status values: `active` | `reserved` | `legacy` | `retired`

---

## Shared infra

| Port | App ID | Env | Role | Status | Bind | Notes |
|------|--------|-----|------|--------|------|-------|
| 80 | nginx | shared | http | active | 0.0.0.0 | Reverse proxy |
| 443 | nginx | shared | https | reserved | — | TLS when enabled |
| 5432 | postgres | shared | db | active | :: | Shared PostgreSQL |
| 9000 | css | shared | http | active | :: | Centralized Security System (`E:\MyWorkspace\centralized-security-system`) |
| 3389 | rdp | shared | other | active | :: | Remote desktop |

---

## DEV (E:) — range 3000–3999

| Port | App ID | Role | Status | Path / process | Notes |
|------|--------|------|--------|----------------|-------|
| 3080 | agent-portal | http | reserved | E:\MyWorkspace\agent-portal | Preferred DEV API offset (migrate from legacy :8080) |

<!-- Add new DEV rows below -->

---

## PREPROD (F:) — range 4000–4999

| Port | App ID | Role | Status | Path / process | Notes |
|------|--------|------|--------|----------------|-------|
| 4080 | agent-portal | http | active | F:\apps\agent-portal | API; UI static via nginx; https://agent-portal-staging.delena.buzz |
| 4900 | css | http | active | F:\apps\css | Preprod CSS IdP (Q1 GO 2026-07-11); DEV shared remains :9000; host plan css-staging.delena.buzz |

---

## PROD (G:) — range 5000–5999

| Port | App ID | Role | Status | Path / process | Notes |
|------|--------|------|--------|----------------|-------|
| 5080 | agent-portal | http | active | G:\apps\agent-portal | API; UI static via nginx; https://agent-portal.delena.buzz; auth→prod CSS :5900 |
| 5900 | css | http | active | G:\apps\css | Prod CSS IdP Q2 GO 2026-07-11; https://css.delena.buzz; keep :4900 and :9000 live |

---

## Legacy outside scheme (migrate later)

| Port | App ID | Env | Role | Status | Process | Notes |
|------|--------|-----|------|--------|---------|-------|
| 4200 | agent-portal | dev | http | legacy | node/ng | DEV UI (ng serve); public delena.buzz / |
| 8080 | agent-portal | dev | http | legacy | java | DEV API; migrate toward :3080 |
| 8081 | legacy-java-8081 | unknown | http | legacy | java | Identify owner |
| 8082 | legacy-java-8082 | unknown | http | legacy | java | Identify owner |
| 8091 | legacy-java-8091 | unknown | http | legacy | java | Identify owner (likely Stack Pilot) |


---

## Template (copy a row)

```md
| 3010 | my-app-web | http | reserved | E:\Source\my-app | block 3010–3014 |
```
