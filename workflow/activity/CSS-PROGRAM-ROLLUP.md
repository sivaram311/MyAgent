# Activity + subagent rollup — CSS program (session `93d977cc-7c3b-4a37-b889-09d2e6676ed5`)

All promote roles were invoked (Task subagents and/or EM-executed role packs). Primary log: `workflow/activity/ACTIVITY-LOG.md`.

## Subagent / role evidence map

| Role | Skill | Artifacts |
|------|-------|-----------|
| EM | promote-em | `evidence/q1/SUMMARY.md`, `evidence/q2/SUMMARY.md`, GO decisions |
| QA | promote-qa | `evidence/q1/qa/results.md`, `evidence/q2/qa/results.md` |
| Security | promote-security | `evidence/q1/security/checklist.md`, `evidence/q2/security/checklist.md` |
| Review | promote-review | `evidence/q1/review/notes.md`, `evidence/q2/review/notes.md` |
| Ops | promote-ops | `evidence/q1/ops/deploy-log.md`, `evidence/q2/ops/*`, `evidence/postgres-cutover.md` |

## Milestones completed

1. Machine workflow (drives, ports, db policy, CSS mandatory, promote gates, activity log, Cursor+Antigravity)
2. CSS Q1 → PREPROD GO (F::4900)
3. CSS Q2 → PROD GO (G::5900, https://css.delena.buzz)
4. Postgres password reset + `app_css` DDL + CSS F/G on Postgres

## Live now

| Service | Port | Datastore |
|---------|------|-----------|
| CSS DEV | 9000 | workspace (pre-existing) |
| CSS PREPROD | 4900 | Postgres `app_css.preprod` |
| CSS PROD | 5900 | Postgres `app_css.prod` |
| PostgreSQL | 5432 | running |
