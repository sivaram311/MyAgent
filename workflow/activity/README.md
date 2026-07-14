# Agent activity documentation (mandatory)

**Policy status:** user-directed 2026-07-11 — **keep**  
**Providers:** Cursor, **Antigravity**, and any other AI agent on this machine.

Every agent / subagent action that changes state, decides a gate, or runs a promote step **must** be written down. Chat alone is not enough. The provider name does not change this duty.

## Where to write

| Activity type | Primary log | Also update |
|---------------|-------------|-------------|
| Session-level work | `workflow/sessions.md` (outcomes + next) | — |
| Day-to-day agent steps | `workflow/activity/ACTIVITY-LOG.md` | session outcomes if milestone |
| Promote / QA / Security / Review / Ops | `H:\releases\<app>-<ver>\evidence\<gate>\` role folders | ACTIVITY-LOG + EM SUMMARY |
| Port / DB / CSS reservations | respective registries under `workflow/` | ACTIVITY-LOG one-liner |
| Dependency matrix / version pins | `workflow/deps/DEPENDENCY-MATRIX.md` (+ JSON) | ACTIVITY-LOG + release `DEPENDENCIES.md` |
| Prod deploy wrapper runs | `G:\apps\<app>\DEPLOY.md` + evidence `ops/` | ACTIVITY-LOG |
| Behavior / topology / auth / ops changes | App `docs/` (e.g. OPS.md), README, platform guides | ACTIVITY-LOG + CONSCIOUS #12 |

## What each entry must include

```text
- When (ISO date/time)
- Session ID
- Provider (cursor | antigravity | other)
- Agent / skill role (em | qa | security | review | ops | general)
- Action (what was done)
- Target (app, env, path, port)
- Result (ok | fail | blocked | skipped)
- Evidence path (if any)
- Notes (short)
```

**Promote rows additionally must include:** app **git tag** (or commit) and **dependency versions/tags** (e.g. `css v0.1.0 / 0.1.0`) in Target or Evidence/notes. Incomplete → treat as incomplete promote documentation (CONSCIOUS #13).

Template row: see [ACTIVITY-LOG.md](./ACTIVITY-LOG.md).

## Rules

1. **Document as you go** — not only at session end.
2. **Subagents document their own folder** under evidence; EM records delegation in ACTIVITY-LOG.
3. **No silent work** on F:/G:/H:, DNS, nginx, Postgres DDL, or registries.
4. **Redact secrets** — never paste tokens/passwords into logs.
5. Prefer append-only logs; deleting log history requires user confirmation.
6. **Update docs after action** (CONSCIOUS #12) — product/ops how-to docs in the same turn when behavior or topology changes; activity log alone is not enough.
7. **Serialize ACTIVITY-LOG appends when crew runs in parallel** — concurrent edits can scramble the markdown table header. EM (or one logger) should batch-write or append one-at-a-time, then spot-check the top of `ACTIVITY-LOG.md`. Details: `workflow/promote/field-lessons.md`.
8. **Dependency versions on promote** (CONSCIOUS #13) — every promote ACTIVITY-LOG entry names git tag + dependent versions; also update `workflow/deps/` after deploy.

## Agent checklist (every turn that matters)

- [ ] Appended ACTIVITY-LOG (or evidence artifact)
- [ ] Updated session outcomes if milestone completed
- [ ] Linked evidence path when promote-related
- [ ] Promote: named **git tag** + **dependency versions** in the log row
- [ ] Updated app/ops docs (OPS, README, DEPLOY, platform) when the change affects how others operate
- [ ] If parallel promote crew: ACTIVITY-LOG table still valid (header separator intact)
