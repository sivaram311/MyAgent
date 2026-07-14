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
| [`workflow/deps/`](workflow/deps/) | Inter-app dependency versions + git tags (SoT matrix) |
| [`workflow/devices/`](workflow/devices/) | **Primary phone SoT (Realme P2 Pro)** — do not web-search |
| [`workflow/testing/`](workflow/testing/) | **E2E hire mandate** (CONSCIOUS #14) — testing subagents when apps are built |
| [`workflow/promote/`](workflow/promote/) | DEV→PREPROD→PROD evidence gates |
| [`workflow/promote/field-lessons.md`](workflow/promote/field-lessons.md) | Promote crew field lessons (bind race, CF cache, PS traps) |
| [`workflow/prod-deploy.md`](workflow/prod-deploy.md) | Prod DNS + nginx wrapper |

## Before any work

1. Read `workflow/CONSCIOUS.md`.
2. Log meaningful actions to `workflow/activity/ACTIVITY-LOG.md` (session id, role, action, result).
3. Honor drive purposes: **E:** DEV · **F:** PREPROD · **G:** PROD · **H:** RELEASES.
4. Do not delete or partition without explicit user confirmation.
5. Phone UI/UX: use **`workflow/devices/`** (Realme P2 Pro SoT + `PRIMARY.json`). Do **not** web-search device specs.
6. After meaningful changes: **update docs** (app OPS/README, registries, DEPLOY.md) — CONSCIOUS rule **12**. Chat + activity log alone are not enough.
7. On promotes: hire **`promote-field-ops`** with em/qa/ops (`workflow/promote/field-lessons.md`).
8. On promotes: record **app git tag** + **dependency versions/tags** (`workflow/deps/`) — CONSCIOUS rule **13**; missing → NO-GO.
9. When an application is **built** or a UI/API surface materially changes: **hire E2E testing subagents** (`workflow/testing/E2E-HIRE.md`) — CONSCIOUS rule **14**. Visual apps must cover **Realme P2 Pro (360×780)**, **desktop (1280×800)**, and **tablet (800×1280)** — prefer parallel hires. Missing hired E2E → incomplete.

## Antigravity

When Agent Portal prefixes rules/skills into the Antigravity prompt, still treat this file and `CONSCIOUS.md` as binding. Write the same evidence packs and activity log entries as Cursor agents. Do not skip documentation because the provider differs.

Also load **`GEMINI.md`** in this folder (Antigravity/Gemini entry). Global copies:

- Cursor user rule: `C:\Users\Administrator\.cursor\rules\myagent-machine.mdc` (`alwaysApply`)
- Antigravity knowledge: `C:\Users\Administrator\.gemini\antigravity-cli\knowledge\myagent-standing-orders.md`
- Antigravity `settings.json` → `toolPermission: always-proceed` + trusted workspaces include MyAgent / MyWorkspace / portal apps

