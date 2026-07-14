# DEV public host E2E (CONSCIOUS #18)

**Status:** standing order · user-directed 2026-07-15  
**Why:** Login / OAuth / cookie / CORS / redirect_uri behave differently on `127.0.0.1` vs the app’s public DEV subdomain. Loopback-only green is **not** enough for auth.

Related: [E2E-HIRE.md](./E2E-HIRE.md) (#14) · [PLAYWRIGHT-SLOT.md](./PLAYWRIGHT-SLOT.md) (#15) · CONSCIOUS **#16** (tag gate) · **#18** (this rule)

---

## Rule

For any UI app with CSS / OAuth / session login:

1. Playwright **must** run login (and post-login landing) against the app’s **DEV public hostname** when one exists (e.g. `https://home-dev.delena.buzz`).
2. `http://127.0.0.1:3xxx` / `localhost` may be used for non-auth smokes or as a **second** project — they do **not** replace domain login E2E.
3. Set Playwright `baseURL` (or env override like `PRODDECK_URL` / `APP_E2E_BASE_URL`) to the **https://\<app\>-dev…** URL for the auth project/run that gates #16.
4. Evidence (`docs/E2E.md` / `H:\releases\...\evidence\e2e\`) must name the **domain** baseURL used for login.
5. If the app has **no** DEV subdomain yet → use loopback, and record **waive** + open a task to add the host before calling login E2E “done” for CSS consumers.

Staging/prod Playwright remains optional cutover checks — it does **not** replace DEV domain login.

---

## App → DEV host examples

| App | DEV public host (when live) | Loopback (complement) |
|-----|-----------------------------|------------------------|
| proddeck | `https://home-dev.delena.buzz` | `http://127.0.0.1:3320` |
| agent-portal | portal DEV host from ports/nginx SoT | `:3xxx` |
| library | `https://library-dev.delena.buzz` | `http://127.0.0.1:3330` |
| agentverse | AV DEV host from ports/nginx SoT | `:3xxx` |

Update this table when new DEV subdomains ship (ports + nginx + CORS).

---

## Tester mandate (hire text)

> Run Device Lab against DEV. For **login / SSO / hybrid auth**, `baseURL` **must** be the public DEV domain, not only `127.0.0.1`. Claim Playwright slot (#15). Prove redirect stays on the domain origin.

---

## Tag / Reviewer gate

- CONSCIOUS **#16**: UI tag — DEV E2E includes **domain login** when a DEV host exists (#18).
- CONSCIOUS **#17**: Reviewer checks evidence names domain baseURL for auth apps (or explicit waive).
