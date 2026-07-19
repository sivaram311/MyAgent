# Development Workflow

Machine-local process for managing MyAgent development activity across **Cursor, Antigravity, and other AI agents**.

## Goals

- Keep every active chat session identifiable and recoverable
- Apply the same standing orders to **all providers** (`AGENTS.md` + `workflow/CONSCIOUS.md`)
- Move work from idea → plan → build → verify in a consistent order
- Leave a short trail so the next session can resume without re-discovery

## Folder map

| Path | Purpose |
|------|---------|
| `workflow/CONSCIOUS.md` | Standing orders / machine safety (read first) — **all providers** |
| `AGENTS.md` | Provider-agnostic entry (Cursor + Antigravity) |
| `workflow/ports/` | **Mandatory** port reservations (DEV/PREPROD/PROD) |
| `workflow/db/` | **Mandatory** Postgres schema-per-env registry |
| `workflow/css/` | **Mandatory** CSS (centralized auth) for apps |
| `workflow/deps/` | **Mandatory** inter-app dependency versions + git tags |
| `workflow/promote/` | **Mandatory** qualify/promote with evidence packs |
| `workflow/activity/` | **Mandatory** agent/subagent activity log |
| `workflow/prod-deploy.md` | Prod deploy wrapper (Cloudflare + nginx) |
| `workflow/cloudflare-workers-ai.md` | **Workers AI** env + verify/sample (`CLOUDFLARE_*`) — CONSCIOUS #19 |
| `workflow/cloudflare-workers-ai.env.example` | Placeholder for Workers AI secrets (real values in `secrets/`) |
| `ideas/README.md` | Capture and prioritize implementation ideas |
| `workflow/sessions.md` | Log session IDs (Cursor/Antigravity) and outcomes |
| `workflow/README.md` | This workflow definition |
| `.cursor/rules/machine-safety.mdc` | Always-on: no delete/partition without confirmation |
| `.cursor/rules/drive-purposes.mdc` | Always-on: E/F/G/H purpose map |
| `.cursor/rules/port-reservation.mdc` | Always-on: reserve ports before bind |
| `.cursor/rules/db-schema-per-env.mdc` | Always-on: schema per env on shared Postgres |
| `.cursor/rules/css-mandatory.mdc` | Always-on: use Centralized Security System |
| `.cursor/rules/dependency-versions.mdc` | Always-on: record git tags + dependency versions on promote |
| `.cursor/rules/promote-evidence.mdc` | Always-on: promote needs evidence + EM GO |
| `.cursor/rules/activity-documentation.mdc` | Always-on: document all agent activity (all providers) |
| `.cursor/rules/all-providers.mdc` | Always-on: Cursor + Antigravity share CONSCIOUS |
| `.cursor/skills/promote-*` | EM / QA / Security / Review / Ops skills |

## Hard rule

**Never delete or partition/format disks without explicit user confirmation.** Details: `workflow/CONSCIOUS.md`.

## Session rules

1. At the **start** of a session, add or update an entry in `workflow/sessions.md` with the session ID.
2. Record the **focus** (one line) and link any idea being worked.
3. At the **end** (or before switching focus), append outcomes: done, blocked, next.
4. Prefer one primary focus per session; park extras back in `ideas/`.

## Activity loop

```text
Idea (ideas/) → Pick → Session log → Implement → Verify → Update session + idea status
```

1. **Capture** — New thoughts go in `ideas/README.md` (Backlog).
2. **Select** — Choose one high/medium idea; move it to In progress.
3. **Open session** — Log session ID in `workflow/sessions.md`.
4. **Build** — Implement only that focus; keep notes in the session entry.
5. **Verify** — Run checks relevant to the change; note results in the session log.
6. **Close** — Mark idea Done/Parked; write **Next** for the following session.

## Status vocabulary

Use the same statuses everywhere:

- `backlog` — not started
- `in_progress` — active this session or carried over
- `blocked` — waiting on decision, dependency, or machine setup
- `done` — finished and verified
- `parked` — deferred on purpose

## Machine notes

- Workspace root: `E:\MyAgent`
- Agent transcripts (Cursor): `C:\Users\Administrator\.cursor\projects\E-MyAgent\agent-transcripts\<session-id>\`
- Session ID = transcript folder / `.jsonl` basename (UUID)

## Conventions

- Keep logs short; link files instead of pasting large dumps.
- Do not commit secrets; keep credentials out of these markdown files.
- When resuming, read the latest session entry first, then the In progress idea.
