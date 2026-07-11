# Promote gates — qualification bar

## Q1 — DEV → PREPROD

| Check | Required |
|-------|----------|
| App packaged / identifiable build for promote | yes |
| Target uses **F:** and ports **4000–4999** | yes |
| DB schema **`preprod`** only (if app uses Postgres) | yes |
| CSS `clientId` registered; login + API JWT path works | yes |
| Smoke: health + login + one core user flow | yes |
| Security + review evidence present | yes |
| Staging hostname plan (`<app>-staging.delena.buzz` or agreed URL) | yes |
| Full regression suite | recommended |

Destination smoke after Ops: repeat health + login + core flow on **PREPROD**.

## Q2 — PREPROD → PROD

| Check | Required |
|-------|----------|
| Q1 evidence exists for same version (or documented exception by human) | yes |
| Target uses **G:** and ports **5000–5999** | yes |
| DB schema **`prod`** only | yes |
| Release folder on **H:** is the prod source | yes |
| CSS CORS includes `https://<app>.delena.buzz` | yes |
| Smoke + **regression** on PREPROD URL | yes |
| Security + review evidence for Q2 | yes |
| Prod deploy dry-run reviewed (`deploy-prod-app.ps1`) | yes |
| Human / EM explicit GO for prod | yes |

Ops for Q2: `deploy-prod-app.ps1` dry-run first, then `-Execute` only after GO.

## Decision rule

```text
if any required CHECKLIST flag == false → NO-GO
if evidence folders incomplete → NO-GO
else EM may set GO → Ops may proceed
```
