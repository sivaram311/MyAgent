---
name: git-release
description: >-
  Handle git release identity for ships: verify DEV E2E green, create annotated
  vX.Y.Z tags, never env branches, never tag=live. Use when packing a release,
  tagging after DEV Device Lab, or following GIT-RELEASE-MANAGEMENT.md.
---

# Git release (`git-release`)

## SoT (read first)

- `E:\MyAgent\GIT-RELEASE-MANAGEMENT.md`
- CONSCIOUS **#13** (deps/tags) · **#14** (E2E hire) · **#15** (Playwright slot) · **#16** (DEV E2E before tag) · **#17** (Reviewer SIGN-OFF before push) · **#18** (DEV domain login E2E)
- Live pins: `E:\MyAgent\workflow\deps/` (mutable — updated **after** deploy, not by this skill alone)
- Reviewer SoT: `E:\MyAgent\workflow\review\REVIEWER-SIGNOFF.md`

## Owns / does not own

| Owns | Does **not** own |
|------|------------------|
| Branch hygiene for cut (`feature/*` → `main`) | F/G cutover (promote-ops + EM GO) |
| Annotated tag `vX.Y.Z` (+ fleet-qualified when needed) | Secrets / `.env` |
| Tag SHA recorded for H: pack `DEPENDENCIES.md` | Moving/retagging; env branches |
| Pushing tag to origin when asked | Claiming tag means “live on prod” |

## Gate before any tag

1. App tip is what will be packed (prefer `main` tip, or document exception).
2. Working tree clean for release commit (or only intentional release bump).
3. **DEV E2E green** this session (or cited evidence):
   - Visual apps: Device Lab Realme **360×780** + desktop **1280×800** + tablet **800×1280** against **DEV** URL (`:3xxx` / local), not “staging-first.”
   - Playwright run used CONSCIOUS **#15** claim → run → release.
   - Evidence under app `e2e/` and/or prep notes for `H:\releases\...\evidence\e2e\`.
4. Version in pack/`package.json` matches intended tag.
5. **Reviewer SIGN-OFF GO** (CONSCIOUS **#17**) for the tip SHA — written before any `git push` of branch or tag.

If DEV E2E missing → **NO-GO for tag**. Hire `e2e-hire` / Device Lab first.  
If Reviewer is **NO-GO** or absent → **do not push**.

## Checklist (per ship)

```text
[ ] On intended tip (main or documented line)
[ ] DEV build + smoke OK
[ ] DEV E2E Device Lab green (+ Playwright slot released)
[ ] git status clean / release commit done
[ ] Reviewer SIGN-OFF.md = GO (CONSCIOUS #17)
[ ] git tag -a vX.Y.Z -m "<app> X.Y.Z — <why>"
[ ] git push origin <branch> && git push origin vX.Y.Z
[ ] Record tag + commit SHA for DEPENDENCIES.md / ACTIVITY-LOG
[ ] Do NOT update DEPENDENCY-MATRIX until after successful F/G deploy
```

### Tag commands

```powershell
git tag -a vX.Y.Z -m "<app-id> X.Y.Z — short why"
git push origin HEAD
git push origin vX.Y.Z
git rev-parse HEAD
git rev-parse vX.Y.Z^{}
```

### Side fleets

Same skill. Prefer pack ids `app-0.2.0` vs `app-next-0.2.0`. If one repo diverges long-term, use fleet-qualified tags (`css/v0.1.0`, `css-next/v0.2.0`) and always name **app id + tag** in matrix/DEPENDENCIES.

## Hard no

1. Env branches (`prod` / `preprod` / `f` / `g`) as promote path  
2. Lightweight tags for promotes  
3. Moving / deleting tags to “match G:”  
4. Tag = live (matrix is live)  
5. Secrets in git  
6. Tagging before DEV E2E for UI apps  
7. Force-push `main` to match production filesystem  

## Handoff to promote

After tag: pack `H:\releases\<app>-<ver>\` from that SHA → hire `promote-em` (+ field-ops) for Q1/Q2. Destination smoke on F/G complements DEV E2E; it does not replace it.

## ACTIVITY-LOG

Log role `release-git` or `git-release`: app id, tag, SHA, DEV E2E result, provider.
