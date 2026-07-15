# CSS consumer migrate — PENDING tracker

**Session SoT:** `css-api-migrate-wave-2026-07-15`  
**Wave doc:** [`E:\MyWorkspace\centralized-security-system\docs\css-consumer-migrate-wave.md`](E:/MyWorkspace/centralized-security-system/docs/css-consumer-migrate-wave.md)  
**Prove:** [`css-api-prove-working.md`](E:/MyWorkspace/centralized-security-system/docs/css-api-prove-working.md)  
**ProdDeck:** live **0.8.2** on css-next hybrid · `v0.8.2` · `H:\releases\proddeck-0.8.2`

Last updated: **2026-07-15**

---

## Done

| Item | Notes |
|------|--------|
| CONSCIOUS #17 Reviewer before push | MyAgent + global rules |
| CSS API prove (JWKS / OAuth surface) | H:`css-next-0.2.0\evidence\api-prove` |
| ProdDeck-only EM GO | Portal/AV deferred |
| ProdDeck hybrid login DEV | Deck form → css-next; SSO optional |
| `home-dev.delena.buzz` CF + nginx → `:3320` | Public 200 |
| URLs in env (`src/lib/cssEnv.ts`) | `.env.local` / `.env.example` |
| CONSCIOUS **#18** DEV domain login E2E | SoT `workflow/testing/DEV-HOST-E2E.md` |
| Skill **`css-migrate`** | `E:\MyAgent\.cursor\skills\css-migrate\` |
| `mig-pd-merge-tag` | Merged to `main` · tag `v0.8.2` @ `2c57914` · Reviewer GO |
| `mig-phase6` (ProdDeck) | Q1 F:4320 + Q2 G:5320 **0.8.2** css-next hybrid; matrix updated |

---

## PENDING (do not lose)

| ID | Task | Owner cue | Blocked by |
|----|------|-----------|------------|
| `mig-portal` | Agent Portal DEV → css-next | implement | PD pilot stable (done) |
| `mig-av` | AgentVerse DEV → css-next | implement | Portal contract + shared `agent-portal` clientId |
| `mig-css-dev9000` | CSS DEV `:9000` Postgres up | ops | start-dev / seeds |
| `mig-idp-brand` | Brand css-next `/oauth/login` | CSS UI | Optional |

**Out of wave (do not start unbidden):** Library auth, grok-dev, erpnext-bridge, h-drive/stack-pilot waived, agentverse-upgrade issuer flip.

---

## ProdDeck env checklist (live F/G)

| Variable | Purpose | F/G value |
|----------|---------|-----------|
| `CSS_AUTH_URL` | BFF / JWKS upstream | `http://127.0.0.1:5910` |
| `NEXT_PUBLIC_CSS_ISSUER` | JWT `iss` | `https://css-next.delena.buzz` |
| `NEXT_PUBLIC_CSS_AUTH_MODE` | `password` \| `hybrid` | `hybrid` |
| `NEXT_PUBLIC_APP_URL` | Public app base | home-staging / home |
| `OS_EVENTS_FORWARD` | OS event soft-forward | `1` |

Rollback: `H:\releases\proddeck-0.8.0` + classic issuer `https://css.delena.buzz` / `:5900`.

---

## Resume one-liner

> ProdDeck **0.8.2** live on css-next (F+G). Next migrate IDs: Portal DEV (`mig-portal`), then AV (`mig-av`). Hire skill `css-migrate`.
