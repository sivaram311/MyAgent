# CSS application integration (machine workflow)

## Runtime

| Env | Profile | Port | Database | Issuer |
|-----|---------|------|----------|--------|
| DEV | `dev` | **9000** | Postgres `app_css.dev` (`app_css_dev`) | `http://127.0.0.1:9000` |
| PREPROD classic | `preprod` | **4900** | Postgres `app_css.preprod` | (classic IdP — keep) |
| PROD classic | `prod` | **5900** | Postgres `app_css.prod` | `https://css.delena.buzz` |
| PREPROD side-fleet | `preprod` + `CSS_PORT=4910` | **4910** | same `app_css.preprod` | `https://css-next-staging.delena.buzz` |
| PROD side-fleet | `prod` + `CSS_PORT=5910` | **5910** | same `app_css.prod` | `https://css-next.delena.buzz` |
| Tests / CI | `test` | random | H2 in-memory | fixed test issuer |
| Optional demo | `h2` | 9000 | H2 in-memory | local |

**Classic vs next:** Fleets stay split. Live after 2026-07-15 consumer wave: Portal / AgentVerse-upgrade / ProdDeck → **css-next** (`0.2.1` / `v0.2.1`). Trading-portal → **classic** (`css` 0.1.0 / `v0.1.0`). Matrix: `../deps/DEPENDENCY-MATRIX.md`.

**DEV start (aligned with F/G Postgres):** `scripts/start-dev.ps1` (loads `postgres.env` + `CSS_ADMIN_PASSWORD` from `G:\apps\css\.env`).

**Admin password SoT:** [`PASSWORD-SOT.md`](./PASSWORD-SOT.md) — env `CSS_ADMIN_PASSWORD` must match Postgres `users.admin` hash; DataSeeder does not rotate existing admin.

| Item | Value |
|------|-------|
| Project | `E:\MyWorkspace\centralized-security-system` |
| Password login (legacy / API) | `POST /auth/login` `{ username, password, clientId }` |
| SSO (Phase 2) | `GET /oauth/authorize` → CSS login → `code` → `POST /oauth/token` (PKCE) |
| JWKS | `GET /.well-known/jwks.json` |
| Public (via nginx) | `https://delena.buzz/auth/` → `:9000` (DEV); prod `https://css.delena.buzz` |

## Pattern (every new app) — preferred SSO

```text
Browser  --authorize-->  CSS /oauth/authorize?client_id&redirect_uri&code_challenge...
Browser  --login once--> CSS /oauth/login  (SSO cookie CSS_SSO)
Browser  --redirect----> App?code=...
App      --token-------> CSS /oauth/token  (code + code_verifier) → app-scoped JWT
Browser  --API-------->  App backend   [validates JWT via JWKS, aud/clientId match]
```

Second app: repeat authorize with SSO cookie — **no password re-prompt** while session valid.

**API prove (working):** [`css-api-prove-working.md`](E:/MyWorkspace/centralized-security-system/docs/css-api-prove-working.md)  
Evidence: `H:\releases\css-next-0.2.0\evidence\api-prove\` · brand prove `H:\releases\css-next-0.2.1\evidence\idp-brand\` · session `css-api-migrate-wave-2026-07-15`.

**ProdDeck:** Live **0.8.4** hybrid on css-next (pilot contract archived at `proddeck-css-next-oauth-pilot.md`). Pack `H:\releases\proddeck-0.8.4`.

**Migration manager skill:** [`css-migrate`](E:/MyAgent/.cursor/skills/css-migrate/SKILL.md). Tracker: [`MIGRATE-PENDING.md`](./MIGRATE-PENDING.md) (wave **COMPLETE**). Wave log: [`CSS-NEXT-CONSUMER-WAVE.md`](./CSS-NEXT-CONSUMER-WAVE.md).

## Pattern — legacy password login (still supported)

```text
Browser  --login-->  CSS /auth/login   [clientId = <app-id>]
Browser  --API---->  App backend   [JWKS]
```

1. Reserve ports + DB schemas (`workflow/ports`, `workflow/db`).
2. Reserve **CSS clientId** in `CLIENT-REGISTRY.md`.
3. Register client in CSS seed/config.
4. Wire resource server (starter / JWKS).
5. Prefer OAuth redirect gate over embedding password forms.
6. Prod subdomain: CSS CORS allows `https://<app>.delena.buzz`.
7. Promote: record CSS **version + git tag** (`workflow/deps/`).

## Example config (Spring resource server)

```yaml
css:
  resource-server:
    enabled: true
    issuer: http://127.0.0.1:9000
    jwks-uri: http://127.0.0.1:9000/.well-known/jwks.json
    client-id: my-shop
```

## Do not

- Add a second JWT issuer per app
- Share CSS private signing keys with apps
- Skip `clientId` / `client_id` on login or token exchange
- Point DEV processes at `preprod`/`prod` schemas
- Use H2 for DEV runtime (use profile `dev` + Postgres; H2 is `test`/`h2` only)
