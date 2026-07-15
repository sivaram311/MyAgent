# CSS classic-alignment wave — 2026-07-15

**Session:** `css-api-migrate-wave-2026-07-15`  
**Status:** **COMPLETE** (consumers on classic; css-next side fleet)  
**Password SoT:** env `CSS_ADMIN_PASSWORD` = live Postgres hash (admin)

## Results

| Lane | App / task | Result |
|------|------------|--------|
| A | Trading Portal PREPROD F | **DONE** — JWKS/cssUrl → `:4900`; redeploy F; smoke PASS; commit `cf5176d` (no push) |
| B | CSS DEV `:9000` | **GO** — already up on Postgres `app_css.dev`; JWKS+login PASS |
| C | QA login matrix | **PASS** — classic IdP + BFFs; evidence under `H:\releases\css-classic-align-2026-07-15\evidence\qa\` |
| — | Portal / AV F/G | Already classic — verified, no cutover |
| — | ProdDeck | Already 0.8.3 classic — no change |

## Out of wave

Waived: h-drive, stack-pilot. Optional: css-next SSO cutover (EM GO), IdP branding, trading-portal git push.

## Hard rules (applied)

Classic ≠ css-next. Kill only target PIDs. No secrets in commits/evidence.
