# CSS consumer migrate — PENDING tracker

**Session SoT:** `css-api-migrate-wave-2026-07-15`  
**ProdDeck live:** **0.8.3** on **classic CSS** `v0.1.0` (Postgres) · all envs DEV/F/G · pack `H:\releases\proddeck-0.8.3`

Last updated: **2026-07-15**

---

## Done

| Item | Notes |
|------|--------|
| ProdDeck → classic CSS all envs | 0.8.3 · issuer `https://css.delena.buzz` · BFF `:5900` · mode `password` |
| Login validated DEV+F+G | `admin`/`admin123` · iss classic · catalog 200 |
| Skill `css-migrate` | Still available for future consumer waves |

**Historical:** 0.8.2 briefly cut ProdDeck to css-next hybrid; **rolled back** to stable classic by user ask 2026-07-15.

---

## PENDING (do not lose)

| ID | Task | Owner cue | Blocked by |
|----|------|-----------|------------|
| `mig-portal` | Agent Portal DEV → css-next | implement | EM GO |
| `mig-av` | AgentVerse DEV → css-next | implement | Portal contract |
| `mig-css-dev9000` | CSS DEV `:9000` Postgres up | ops | start-dev / seeds |
| `mig-idp-brand` | Brand css-next `/oauth/login` | CSS UI | Optional |
| `mig-pd-css-next-retry` | Re-cut ProdDeck to css-next | EM GO | Only if password/seed + OAuth prove ready |

**Out of wave:** Library auth, grok-dev, erpnext-bridge, waived public-read apps.

---

## ProdDeck env (live all envs)

| Variable | Value |
|----------|--------|
| `CSS_AUTH_URL` | `http://127.0.0.1:5900` |
| `NEXT_PUBLIC_CSS_ISSUER` | `https://css.delena.buzz` |
| `NEXT_PUBLIC_CSS_AUTH_MODE` | `password` |

---

## Resume one-liner

> ProdDeck **0.8.3** lives on **classic CSS** Postgres for DEV/F/G. css-next remains side fleet only.
