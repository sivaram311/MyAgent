# CSS admin password SoT

**User SoT:** `admin` password = value in `CSS_ADMIN_PASSWORD` on F/G css + css-next `.env` files.

## Root cause (2026-07-15)

| Layer | Issue |
|-------|-------|
| `.env` | Already aligned on F/G — no drift |
| **Postgres** | `users.admin.password_hash` still encoded legacy seed (`admin123`) after env change |
| **DataSeeder** | Sets password **only when admin row is missing** — env changes do not rotate existing hash |

Classic and css-next share the same Postgres schema per tier (`dev` / `preprod` / `prod`).

## Fix

1. Reset BCrypt hash for `admin` in all three schemas (same method as ACTIVITY-LOG 11:55).
2. `scripts/start-dev.ps1` loads `CSS_ADMIN_PASSWORD` from `G:\apps\css\.env` (fallback `F:\`) so fresh DEV seeds match.

## Verify (no secrets in evidence)

Evidence: `H:\releases\css-0.1.0\evidence\password-align\SMOKE.md`

Loopback IdP `:9000` `:4900` `:5900` `:4910` `:5910` + domain BFF logins — env password **PASS**, legacy seed **FAIL**.

## Do not

- Commit `CSS_ADMIN_PASSWORD` to git.
- Expect env-only changes to update live login without Postgres hash reset or admin row recreate.

## PROD browser login (2026-07-15)

Evidence: `H:\releases\css-0.1.0\evidence\prod-browser-login\`

After issuer bake/nginx fixes, Playwright Chromium PROD password login **PASS** for: home, home-staging, agent-portal, agentverse[-upgrade], trading-portal (iss=css-next), css-next IdP page.

Fixes applied same day:
1. ProdDeck F/G rebuild — baked NEXT_PUBLIC still classic until clean rebuild (shell env override).
2. trading-portal.delena.buzz nginx `/auth`+JWKS → css-next `:5910`.