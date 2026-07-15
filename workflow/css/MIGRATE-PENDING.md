# CSS consumer migrate — PENDING tracker

**Session SoT:** `css-api-migrate-wave-2026-07-15`  
**Status:** **COMPLETE** (including optional follow-ons) — 2026-07-15

Last updated: **2026-07-15**

---

## Done

| Item | Notes |
|------|--------|
| css-next consumer wave | Portal/AV/ProdDeck on css-next · IdP brand 0.2.1 · docs pushed |
| `mig-portal-oauth` | Portal **0.1.10** hybrid OAuth/PKCE + password · tip `084e94a` (+ packs `95f740d`) · DEV/F/G SSO prove PASS |
| Trading-portal → css-next | tip `5ea7334` · F JWKS `:4910` · G JWKS `:5910` · smoke PASS · pushed |
| DataSeeder trading-portal | CSS `86315fb` seeds `trading-portal` client + roles |
| Registry cleanup | MyAgent ports/db trading-portal rows · `8a8f444` |

---

## PENDING

_None for this session._

---

## Live IdP map

| App | Version | IdP | Mode |
|-----|---------|-----|------|
| css-next | 0.2.1 | — | branded OAuth login |
| ProdDeck | 0.8.4 | css-next | hybrid |
| Agent Portal | **0.1.10** | css-next | **hybrid** (password + OAuth/PKCE) |
| AgentVerse-upgrade | 0.3.8 | css-next | password |
| Trading Portal | 0.1.0 tip `5ea7334` | **css-next** | JWKS F`:4910` / G`:5910` |

**Admin password:** env `CSS_ADMIN_PASSWORD` + Postgres hash aligned all schemas (`PASSWORD-SOT.md`). Legacy `admin123` rejected.

---

## Resume one-liner

> All active auth consumers pin **css-next**. Admin password SoT aligned (Postgres + env). Portal **0.1.10** hybrid. Trading-portal F/G css-next JWKS. No migrate pending IDs.
