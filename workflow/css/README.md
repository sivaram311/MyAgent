# Centralized Security System (CSS) — mandatory for apps

**Policy status:** user-directed 2026-07-11 — **keep / make use of**  
**Location:** `E:\MyWorkspace\centralized-security-system`  
**Port:** **9000** (shared infra — already proxied on delena.buzz as `/auth/` and `/.well-known/`)

New and migrated web applications on this machine **must authenticate via CSS**, not by inventing a separate login/JWT stack.

| File | Role |
|------|------|
| [integration.md](./integration.md) | How apps plug in (clientId, JWKS, starter) |
| [CLIENT-REGISTRY.md](./CLIENT-REGISTRY.md) | Reserved CSS `clientId` values |
| [../deps/](../deps/) | **CSS version + git tag** matrix (mandatory on promote) |

Upstream docs (source of truth for CSS internals):

- `E:\MyWorkspace\centralized-security-system\README.md`
- `E:\MyWorkspace\centralized-security-system\docs\application-integration.md`
- Starter: `E:\MyWorkspace\centralized-security-system\clients\spring-boot-starter\`
- Live prod tag: see `workflow/deps/DEPENDENCY-MATRIX.md` (currently CSS `v0.1.0`)

---

## Why

One identity store, one login, application-scoped RS256 JWTs validated via JWKS — no per-app password DBs or shared HS256 secrets.

## Agent rules

1. Before building auth for an app, **register a `clientId`** in `CLIENT-REGISTRY.md`.
2. Prefer **css-spring-boot-starter** for Spring Boot resource servers.
3. Frontends login against CSS (`/auth/login`) with that `clientId`; APIs validate Bearer JWT via JWKS.
4. Public edge: prefer `https://delena.buzz/auth/...` (nginx → `:9000`) over raw IP.
5. Do not stand up a second IdP without explicit user confirmation.
6. CORS: add new public origins to CSS allowed origins when deploying a new subdomain (user confirm for prod CORS changes).
7. On every promote: record **CSS version + git tag** (e.g. `0.1.0` / `v0.1.0`) in `DEPENDENCIES.md` + ACTIVITY-LOG — `clientId` alone is not enough (`workflow/deps/`).
8. **DEV uses Postgres** (`app_css.dev`) like PREPROD/PROD — start with `scripts/start-dev.ps1` / profile `dev`. H2 is for `test`/`h2` only.
9. Prefer **OAuth SSO** (`/oauth/*`) for browser apps; keep `/auth/login` for API clients.
