# CSS application integration (machine workflow)

## Runtime

| Env | Profile | Port | Database | Issuer |
|-----|---------|------|----------|--------|
| DEV | `dev` | **9000** | Postgres `app_css.dev` (`app_css_dev`) | `http://127.0.0.1:9000` |
| PREPROD | `preprod` | **4900** | Postgres `app_css.preprod` | `http://127.0.0.1:4900` |
| PROD | `prod` | **5900** | Postgres `app_css.prod` | `https://css.delena.buzz` |
| Tests / CI | `test` | random | H2 in-memory | fixed test issuer |
| Optional demo | `h2` | 9000 | H2 in-memory | local |

**DEV start (aligned with F/G Postgres):** `scripts/start-dev.ps1` (loads `E:\MyAgent\workflow\db\secrets\postgres.env`).

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
