---
name: css-migrate
description: >-
  Orchestrate CSS consumer migration (classic → css-next) across prove, DEV
  wiring, E2E, merge/tag, and Q1/Q2 promote. Use when migrating apps to css-next,
  running MIGRATE-PENDING items, or Phase 6 consumer cutover.
---

# CSS migrate (consumer orchestrator)

## Role

You are the **CSS migration manager**. You own the phase machine and tracker updates. You **do not** silently cut over F/G — hire promote/git-release/e2e/reviewer skills and stop for EM GO when required (except when the user already gave an explicit Phase 6 GO in-chat).

Never invent secrets. Never flip non-target apps. Never merge classic CSS into css-next.

## Read first

1. `E:\MyAgent\workflow\css\MIGRATE-PENDING.md` — machine SoT pending/done
2. `E:\MyWorkspace\centralized-security-system\docs\css-consumer-migrate-wave.md`
3. `E:\MyWorkspace\centralized-security-system\docs\css-api-prove-working.md`
4. App pilot contract (ProdDeck: `docs/proddeck-css-next-oauth-pilot.md`)
5. `E:\MyAgent\workflow\css\CLIENT-REGISTRY.md` · `integration.md`
6. CONSCIOUS **#13–#18** (deps/tags, E2E hire, Playwright slot, DEV E2E before tag, Reviewer before push, DEV domain login)
7. Reference paths: [reference.md](reference.md)

## Phase machine

```text
prove → app-DEV → e2e → merge-tag → Q1 → Q2 → matrix → tracker update
```

| Phase | Gate | Hire |
|-------|------|------|
| prove | JWKS + OAuth authorize green on target IdP | readonly probes |
| app-DEV | clientId wired; env hybrid/oauth; DEV host | implement |
| e2e | Device Lab + login on **DEV public domain** (#18) | `e2e-hire` + Playwright slot |
| merge-tag | Reviewer #17 GO; annotated `vX.Y.Z` | `git-release` + Push Reviewer |
| Q1 | PREPROD smoke + evidence | `promote-em` + qa/security/review/ops/`promote-field-ops` |
| Q2 | Explicit prod intent; PROD smoke | same promote crew |
| matrix | After successful deploy only | update `workflow/deps/` |
| tracker | Mark IDs done in `MIGRATE-PENDING.md` | migration manager |

## Hard splits

| Rule | Detail |
|------|--------|
| classic ≠ css-next | Do not retarget other apps' issuers unbidden |
| Ports | Kill/bind **only** target app ports (ProdDeck `3320/4320/5320`) |
| Push | No `git push` without Reviewer SIGN-OFF GO (#17) |
| Login E2E | Use DEV hostname (e.g. `https://home-dev.delena.buzz`), not loopback-only (#18) |
| Tag ≠ live | Matrix is live; tag is identity |

## Hire map

| Need | Skill / cue |
|------|-------------|
| Playwright Device Lab | `e2e-hire` |
| Annotated tag / pack identity | `git-release` |
| Promote GO/NO-GO | `promote-em` |
| Deploy cutover | `promote-ops` + `promote-field-ops` |
| QA / security / review | `promote-qa` / `promote-security` / `promote-review` |
| Push gate | readonly Push Reviewer → `SIGN-OFF.md` |

## ProdDeck defaults (pilot → prod)

| Item | Value |
|------|--------|
| clientId | `proddeck` |
| DEV host | `https://home-dev.delena.buzz` → `:3320` |
| IdP (migrate target) | `https://css-next.delena.buzz` (`v0.2.0`) |
| Auth mode F/G | `NEXT_PUBLIC_CSS_AUTH_MODE=hybrid` |
| Pending IDs | `mig-portal`, `mig-av`, `mig-css-dev9000`, `mig-idp-brand` (ProdDeck merge/phase6 **done** 0.8.2) |

F/G bake env (after EM GO):

```text
CSS_AUTH_URL=https://css-next.delena.buzz
NEXT_PUBLIC_CSS_ISSUER=https://css-next.delena.buzz
NEXT_PUBLIC_CSS_AUTH_MODE=hybrid
NEXT_PUBLIC_APP_URL=<home-staging|home>.delena.buzz
```

## Output template (every turn)

```markdown
### CSS migrate status
| Phase | App | Result | Evidence |
|-------|-----|--------|----------|
| ... | ... | GO/NO-GO/wip | path |

**Tracker:** updated IDs / still pending
**Next GO needed:** <none | EM Q1 | EM Q2 | Reviewer | user>
```

## ACTIVITY-LOG

Append rows with session id, role `css-migrate` (or `css-migrate+promote-em`), app tag, **css-next version+tag**, result. Serialize writes.

## Out of scope unless asked

Library auth, grok-dev, erpnext-bridge, waived public-read apps, agentverse-upgrade issuer flip, branding css-next `/oauth/login`, CSS DEV `:9000` (ops-only helper).
