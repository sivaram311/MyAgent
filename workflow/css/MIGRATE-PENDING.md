# CSS consumer migrate — PENDING tracker

**Session SoT:** `css-api-migrate-wave-2026-07-15`  
**Wave doc:** [`E:\MyWorkspace\centralized-security-system\docs\css-consumer-migrate-wave.md`](E:/MyWorkspace/centralized-security-system/docs/css-consumer-migrate-wave.md)  
**Prove:** [`css-api-prove-working.md`](E:/MyWorkspace/centralized-security-system/docs/css-api-prove-working.md)  
**ProdDeck pilot branch:** `feature/css-next-oauth-pilot` · host `https://home-dev.delena.buzz`

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

---

## PENDING (do not lose)

| ID | Task | Owner cue | Blocked by |
|----|------|-----------|------------|
| `mig-portal` | Agent Portal DEV → css-next | implement | PD pilot stable |
| `mig-av` | AgentVerse DEV → css-next | implement | Portal contract + shared `agent-portal` clientId |
| `mig-css-dev9000` | CSS DEV `:9000` Postgres up | ops | start-dev / seeds |
| `mig-pd-merge-tag` | ProdDeck merge hybrid → `main` + annotated tag/pack | git-release + Reviewer #17 | EM GO on ship |
| `mig-phase6` | F/G consumer cutover + **matrix** update | promote-em + field-ops | Explicit EM GO; DEV E2E first |
| `mig-idp-brand` | Brand css-next `/oauth/login` | CSS UI | Optional |

**Out of wave (do not start unbidden):** Library auth, grok-dev, erpnext-bridge, h-drive/stack-pilot waived, agentverse-upgrade issuer flip.

---

## ProdDeck env checklist (track in `.env.local`)

| Variable | Purpose | DEV pilot example |
|----------|---------|-------------------|
| `CSS_AUTH_URL` | BFF / JWKS upstream | `https://css-next.delena.buzz` |
| `NEXT_PUBLIC_CSS_ISSUER` | JWT `iss` | same as above |
| `NEXT_PUBLIC_CSS_AUTH_MODE` | `password` \| `hybrid` | `hybrid` |
| `NEXT_PUBLIC_APP_URL` | Public app base | `https://home-dev.delena.buzz` |
| `NEXT_PUBLIC_DEV_HOSTS` | DEV hostname list | `localhost,127.0.0.1,home-dev.delena.buzz` |
| `NEXT_PUBLIC_CSS_OAUTH_REDIRECT_URI` | Optional SSO override | blank → browser origin |
| `PLATFORM_APPS_URL` | Portal catalog | optional |
| `OS_EVENTS_FORWARD` | OS event soft-forward | optional / F/G `1` |

F/G bake stays classic: `.env.production` → `NEXT_PUBLIC_CSS_ISSUER=https://css.delena.buzz`, `CSS_AUTH_URL=http://127.0.0.1:5900`.

---

## Resume one-liner

> Continue CSS consumer migrate from `workflow/css/MIGRATE-PENDING.md`: ProdDeck DEV hybrid done; next = Portal DEV, then AV; Phase 6 F/G only after EM GO.
