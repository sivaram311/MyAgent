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
| [`workflow/testing/`](workflow/testing/) | **E2E hire** (#14) · Playwright slot (#15) · DEV E2E before tag (#16) · **DEV domain login** (#18) |
| [`workflow/review/`](workflow/review/) | **Reviewer SIGN-OFF before push** (#17) |
| [`GIT-RELEASE-MANAGEMENT.md`](GIT-RELEASE-MANAGEMENT.md) | Git tagging / no env branches — hire skill `git-release` |
| [`.cursor/skills/css-migrate/`](.cursor/skills/css-migrate/) | **CSS consumer migrate** orchestrator (prove→DEV→E2E→tag→Q1/Q2) — hire when aligning apps to css-next / `MIGRATE-PENDING.md` |
| [`workflow/promote/`](workflow/promote/) | DEV→PREPROD→PROD evidence gates |
| [`workflow/promote/field-lessons.md`](workflow/promote/field-lessons.md) | Promote crew field lessons (bind race, CF cache, PS traps) |
| [`workflow/prod-deploy.md`](workflow/prod-deploy.md) | Prod DNS + nginx wrapper |
| [`workflow/cloudflare-workers-ai.md`](workflow/cloudflare-workers-ai.md) | **Workers AI** env (`CLOUDFLARE_ACCOUNT_ID` / `CLOUDFLARE_WORKERS_AI_TOKEN`) — CONSCIOUS #19 |
| [`workflow/repos/`](workflow/repos/) | **Repository visibility inventory** — CONSCIOUS #20 |

## Before any work

1. Read `workflow/CONSCIOUS.md`.
2. Log meaningful actions to `workflow/activity/ACTIVITY-LOG.md` (session id, role, action, result).
3. Honor drive purposes: **E:** DEV · **F:** PREPROD · **G:** PROD · **H:** RELEASES.
4. Do not delete or partition without explicit user confirmation.
5. Phone UI/UX: use **`workflow/devices/`** (Realme P2 Pro SoT + `PRIMARY.json`). Do **not** web-search device specs.
6. After meaningful changes: **update docs** (app OPS/README, registries, DEPLOY.md) — CONSCIOUS rule **12**. Chat + activity log alone are not enough.
7. On promotes: hire **`promote-field-ops`** with em/qa/ops (`workflow/promote/field-lessons.md`).
8. On promotes: record **app git tag** + **dependency versions/tags** (`workflow/deps/`) — CONSCIOUS rule **13**; missing → NO-GO.
9. When an application is **built** or a UI/API surface materially changes: **hire E2E testing subagents** (`workflow/testing/E2E-HIRE.md`) — CONSCIOUS rule **14**. Visual apps must cover **Realme P2 Pro (360×780)**, **desktop (1280×800)**, and **tablet (800×1280)**. Missing hired E2E → incomplete.
10. Before **running** Playwright / browser E2E: **claim** the machine slot; after tests **release** with pass/fail — CONSCIOUS rule **15** (`workflow/testing/PLAYWRIGHT-SLOT.md`). Never run multiple Playwright instances at once. Spec authoring may be parallel; execution is serialized.
11. **DEV E2E before tag** — CONSCIOUS rule **16**: run Device Lab against DEV URL, then hire **`git-release`** for annotated `v*` tags per `GIT-RELEASE-MANAGEMENT.md`. Do not tag/pack UI apps on staging-only browser runs. Tag ≠ live (matrix is live). When a DEV public hostname exists, login E2E on that domain is required (#18).
12. **Reviewer before push** — CONSCIOUS rule **17**: before any `git push` (branch or tag), hire a readonly Reviewer and get **GO** in `SIGN-OFF.md` (`workflow/review/REVIEWER-SIGNOFF.md`). Local commit allowed; push without GO → NO-GO.
13. **Login E2E on DEV domain** — CONSCIOUS rule **18**: Playwright login/SSO must use the app’s DEV public hostname when it exists (e.g. `https://home-dev.delena.buzz`), not only `127.0.0.1` — SoT `workflow/testing/DEV-HOST-E2E.md`.
14. **Cloudflare Workers AI** — CONSCIOUS rule **19**: use User env / `workflow/secrets/cloudflare-workers-ai.env` for `CLOUDFLARE_ACCOUNT_ID` + `CLOUDFLARE_WORKERS_AI_TOKEN`; never commit; keep separate from Zone Edit DNS token. Fetch models via `ai/models/search`; check neuron quota per `workflow/cloudflare-workers-ai.md` (header / GraphQL / dashboard).
15. **Repository inventory** — CONSCIOUS rule **20**: refresh `workflow/repos/` whenever repository visibility, lifecycle, ownership, or default branch changes.

## Antigravity

When Agent Portal prefixes rules/skills into the Antigravity prompt, still treat this file and `CONSCIOUS.md` as binding. Write the same evidence packs and activity log entries as Cursor agents. Do not skip documentation because the provider differs.

Also load **`GEMINI.md`** in this folder (Antigravity/Gemini entry). Global copies:

- Cursor user rule: `C:\Users\Administrator\.cursor\rules\myagent-machine.mdc` (`alwaysApply`)
- Antigravity knowledge: `C:\Users\Administrator\.gemini\antigravity-cli\knowledge\myagent-standing-orders.md`
- Antigravity `settings.json` → `toolPermission: always-proceed` + trusted workspaces include MyAgent / MyWorkspace / portal apps

