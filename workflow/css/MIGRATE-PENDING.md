# CSS consumer migrate — PENDING tracker

**Session SoT:** `css-api-migrate-wave-2026-07-15`  
**Wave:** css-next consumer wave (locked defaults) — **COMPLETE** 2026-07-15

Last updated: **2026-07-15**

---

## Done

| Item | Notes |
|------|--------|
| `mig-tp-push` | trading-portal `cf5176d` pushed; repo https://github.com/sivaram311/trading-portal (created) |
| `mig-idp-brand` | css-next **0.2.1** / `v0.2.1` @ `75ae5ae` · Delena `/oauth/login` · F/G redeployed · domain brand prove PASS |
| `mig-pd-css-next-retry` | ProdDeck **0.8.4** / `v0.8.4` @ `0121b64` · hybrid css-next · DEV/F/G domain login PASS |
| `mig-portal` | agent-portal **0.1.9** @ `08b0b18` · password IdP → css-next · nginx `/auth`→`:5910` · domain login PASS · pushed |
| `mig-av` | agentverse-upgrade **0.3.8** @ `4786508` · lockstep css-next · F/G domain login PASS · pushed |
| `mig-css-dev9000` | Earlier classic-align: `:9000` Postgres GO |

**Out of wave (unchanged):** trading-portal stays on **classic** CSS; classic densify agentverse; waived apps; Portal OAuth/PKCE rewrite (future).

---

## PENDING (future)

| ID | Task | Notes |
|----|------|--------|
| `mig-portal-oauth` | Angular OAuth/PKCE (optional) | Password lane already on css-next |
| — | Classic CSS consumers only | trading-portal F/G |

---

## Live IdP map (post-wave)

| App | IdP | Mode |
|-----|-----|------|
| ProdDeck DEV/F/G | css-next | hybrid |
| Agent Portal DEV/F/G | css-next | password |
| AgentVerse-upgrade F/G | css-next | password (shared clientId) |
| Trading Portal F/G | classic | JWKS |
| css-next itself | — | branded `/oauth/login` |

---

## Resume one-liner

> Portal **0.1.9**, AgentVerse-upgrade **0.3.8**, ProdDeck **0.8.4** pin **css-next 0.2.1**. Trading-portal remains classic. Wave pending IDs closed.
