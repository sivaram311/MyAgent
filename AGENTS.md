# AGENTS.md — machine standing orders (all providers)

**Applies to every AI agent on this machine**, including:

- **Cursor** agents
- **Antigravity** agents
- Any other provider spawned via Agent Portal or local automation

Provider-specific folders (`.cursor/rules`, skills) are conveniences. The **source of truth** is:

| Document | Purpose |
|----------|---------|
| [`workflow/CONSCIOUS.md`](workflow/CONSCIOUS.md) | Non-negotiable standing orders |
| [`workflow/activity/ACTIVITY-LOG.md`](workflow/activity/ACTIVITY-LOG.md) | Mandatory activity log |
| [`workflow/ports/`](workflow/ports/) | Port reservation |
| [`workflow/db/`](workflow/db/) | Postgres schema-per-env |
| [`workflow/css/`](workflow/css/) | Centralized Security System |
| [`workflow/promote/`](workflow/promote/) | DEV→PREPROD→PROD evidence gates |
| [`workflow/prod-deploy.md`](workflow/prod-deploy.md) | Prod DNS + nginx wrapper |

## Before any work

1. Read `workflow/CONSCIOUS.md`.
2. Log meaningful actions to `workflow/activity/ACTIVITY-LOG.md` (session id, role, action, result).
3. Honor drive purposes: **E:** DEV · **F:** PREPROD · **G:** PROD · **H:** RELEASES.
4. Do not delete or partition without explicit user confirmation.
5. After meaningful changes: **update docs** (app OPS/README, registries, DEPLOY.md) — CONSCIOUS rule **12**. Chat + activity log alone are not enough.

## Antigravity

When Agent Portal prefixes rules/skills into the Antigravity prompt, still treat this file and `CONSCIOUS.md` as binding. Write the same evidence packs and activity log entries as Cursor agents. Do not skip documentation because the provider differs.
