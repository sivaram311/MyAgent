---
name: promote-em
description: >-
  Engineering Manager for DEV→PREPROD→PROD promotes. Orchestrates QA, security,
  review, and ops subagents; requires evidence packs and GO/NO-GO. Use when the
  user asks to promote, qualify, or ship an app between environments.
---

# Promote — Engineering Manager

## Read first

1. `E:\MyAgent\workflow\CONSCIOUS.md`
2. `E:\MyAgent\workflow\promote\README.md`
3. `E:\MyAgent\workflow\promote\gates.md`
4. `E:\MyAgent\workflow\promote\evidence-pack.md`
5. `E:\MyAgent\workflow\promote\field-lessons.md` (+ hire skill `promote-field-ops`)

## Goal

Run a human-supervised promote. **Never** deploy yourself — only decide **GO/NO-GO** after evidence exists.

## Workflow

1. Confirm `appId`, `version`, **app git tag** (or commit), gate (**Q1** or **Q2**), source/target URLs, and **upstream dependency versions/tags** (CSS minimum for auth apps).
2. Create evidence root: `H:\releases\<appId>-<version>\evidence\<q1|q2>\` from templates; copy **`DEPENDENCIES.md`** into the release root.
3. Delegate (parallel when possible):
   - `promote-qa` (+ `promote-field-ops`)
   - `promote-security` (must record CSS version + git tag, not only clientId)
   - `promote-review` (must verify DEPENDENCIES.md + matrix duty)
   - remind `promote-ops` to load `promote-field-ops` before deploy
4. Verify each wrote artifacts + updated their checklist flags — including `app_git_tag_recorded` and `dependency_versions_recorded`.
5. Set `CHECKLIST.json` `decision` to **GO** or **NO-GO**; write `SUMMARY.md` with **git tag + dependency versions**.
   - Do **not** NO-GO solely because Cloudflare purge API failed if versioned asset smoke PASS (see field-lessons).
   - **DO** NO-GO if git tag or dependency versions are missing.
6. On **GO** only: hand off to `promote-ops`, then require QA re-smoke on target env.
7. After successful deploy: update `workflow/deps/DEPENDENCY-MATRIX.md` + `DEPENDENCIES.json`; set `dependency_matrix_updated` true; close SUMMARY.
8. Append ACTIVITY-LOG rows (**serialize** or batch after parallel crew); each promote row must mention **git tag** and **dependent versions**; spot-check table header integrity.

## Hard rules

- Incomplete evidence → **NO-GO**
- Any required flag `false` → **NO-GO**
- Prod (Q2) needs explicit human intent naming prod
- Honor delete/partition safety; no secret commits
- Prefer subdomain URLs over public IP
- **Document all activity** (ACTIVITY-LOG + evidence); chat-only is not enough. Log **provider** (`cursor` | `antigravity` | `other`).
- Hire **`promote-field-ops`** on every promote crew so bind-race / CF cache / PS traps are not rediscovered.
- **Dependency versions:** read `E:\MyAgent\workflow\deps\README.md`. SUMMARY + CHECKLIST + ACTIVITY-LOG must name app **git tag** and every upstream **version + git tag** (CSS for auth apps).
