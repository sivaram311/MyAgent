# Promote gates — qualification bar

## Q1 — DEV → PREPROD

| Check | Required |
|-------|----------|
| App packaged / identifiable build for promote | yes |
| Target uses **F:** and ports **4000–4999** | yes |
| DB schema **`preprod`** only (if app uses Postgres) | yes |
| CSS `clientId` registered; login + API JWT path works | yes |
| **App git tag** (or commit) recorded in CHECKLIST + DEPENDENCIES.md | yes |
| **Dependency versions** recorded (CSS version + **git tag** + release id; other upstreams as applicable) | yes |
| Smoke: health + login + one core user flow | yes |
| Security + review evidence present | yes |
| Staging hostname **live** (`<app>-staging.delena.buzz` or agreed URL) + nginx → F: port | yes |
| Destination smoke on that **public staging URL** (not only `127.0.0.1`) | yes |
| Full regression suite | recommended |

**Stack Pilot exception (names):** PREPROD = `control-staging.delena.buzz` → `:4091`; PROD = `control.delena.buzz` → `:5091`. Do **not** close Q1 on localhost-only smoke.

Destination smoke after Ops: repeat health + login + core flow on **PREPROD public URL**.

## Q2 — PREPROD → PROD

| Check | Required |
|-------|----------|
| Q1 evidence exists for same version (or documented exception by human) | yes |
| Target uses **G:** and ports **5000–5999** | yes |
| DB schema **`prod`** only | yes |
| Release folder on **H:** is the prod source | yes |
| CSS CORS includes prod public URL (or waived-public-read documented) | yes |
| **App git tag** + **dependency versions/tags** recorded (same bar as Q1; must match what PROD will run against) | yes |
| After GO + deploy: **DEPENDENCY-MATRIX.md** (+ JSON) updated to live G: pins | yes |
| Smoke + **regression** on **PREPROD public URL** | yes |
| Security + review evidence for Q2 | yes |
| Prod hostname live (`<app>.delena.buzz` or agreed; Stack Pilot = `control.delena.buzz`) | yes |
| Prod deploy dry-run reviewed (`deploy-prod-app.ps1`) — or documented wrapper exception | yes |
| Human / EM explicit GO for prod | yes |

Ops for Q2: `deploy-prod-app.ps1` dry-run first, then `-Execute` only after GO.  
**Stack Pilot:** wrapper **blocks** subdomain `control` — DNS via `cloudflare-dns.ps1 -Upsert -Name control -Proxied`; nginx conf `control.delena.buzz.conf` → `:5091`.

## Decision rule

```text
if any required CHECKLIST flag == false → NO-GO
if evidence folders incomplete → NO-GO
if app git tag/commit missing → NO-GO
if dependency versions/tags missing (or CSS cited without version+tag) → NO-GO
else EM may set GO → Ops may proceed
```

## Dependency versions (mandatory)

See `workflow/deps/README.md`. Every gate must name:

- This app’s **git tag** (preferred) or commit SHA
- Each upstream dependency’s **version + git tag** (CSS minimum for auth apps)
- Release pack ids under `H:\releases\`

Waived-public-read apps still document the waiver in `DEPENDENCIES.md` — do not omit the row.
