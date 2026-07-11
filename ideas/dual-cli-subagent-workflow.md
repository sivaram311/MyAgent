# Dual-CLI subagent workflow (Cursor + Antigravity)

- **Status:** backlog (roadmap)
- **Priority:** high
- **Captured:** 2026-07-11
- **Session:** `93d977cc-7c3b-4a37-b889-09d2e6676ed5`

## Summary

Automate MyAgent standing orders (CONSCIOUS + promote EM→QA/Security/Review→Ops→Docs) as a **job pipeline** that spawns **Cursor CLI** (`agent`) and **Antigravity CLI** (`agy`) role workers. Configure later via **Agent Portal** predefined pipelines / platform tasks / role ACLs — same job contract for CLI and Portal.

## Why

Manual promote/troubleshoot works but is chat-dependent. Role skills already exist (`promote-*`, `ap-platform-*`). Need scheduling + hard exit criteria (evidence, ACTIVITY-LOG, docs-after-action) shared by both providers.

## Design sketch (do not implement until picked up)

```text
Human / Agent Portal pipeline
  → Orchestrator (job.json)
      → parallel: qa / security / review  (cursor and/or agy)
      → em: GO/NO-GO from CHECKLIST.json
      → ops: only if GO (+ human for Q2/prod)
      → docs: CONSCIOUS #12 mandatory
  → artifacts under H:\releases\<app>-<ver>\
```

### Role packs

Portable packs under MyAgent (proposed): `workflow/agents/<role>/` with prompt, allowed paths, forbidden actions, skill pointer. Both CLIs load the same pack.

### Human gates (never fully auto)

Deletes, partition, DNS delete, overwrite `G:\apps\<app>`, Q2 prod GO, secret resets.

### Agent Portal configuration (later thinking)

Wire to existing primitives without inventing a second control plane first:

| Portal piece | Use |
|--------------|-----|
| `/api/platform/pipelines` + `.../run` | Predefined `PROMOTE_Q1` / `PROMOTE_Q2` / `INCIDENT_JDBC` |
| `/api/platform/tasks` + roles | EM / QA / SECURITY / REVIEW / OPS / DOCS assignments |
| `/api/platform/swarm/tick` | Advance handoffs when role artifact lands |
| Session `platformRole` + ACL | Bound CLI sessions inherit tool/action limits |
| Agent API | External trigger of same job from scripts |

Prefer: Portal creates `job.json` → host runner shells `agent`/`agy` with role packs → workers write evidence → swarm/tick advances.

## First slice when built

PowerShell (or Portal pipeline) **Promote bot v0**: scaffold evidence → parallel QA/Security/Review → EM decision → Ops on GO → Docs role. Success = reproducible agent-portal-style promote in one command.

## References

- `E:\MyAgent\workflow\CONSCIOUS.md` (#9–12)
- `E:\MyAgent\workflow\promote\`
- `E:\MyAgent\.cursor\skills\promote-*`
- Agent Portal: `docs/platform/SUBAGENTS-ROADMAP.md`, `WORKFLOW.md`, `FUTURE-IMPLEMENTATION.md`
- Chat idea captured 2026-07-11 (dual-CLI subagent factory)
