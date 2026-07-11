# Session Log

Track Cursor agent session IDs for this machine and workspace (`E:\MyAgent`).

## Active session

| Field | Value |
|-------|-------|
| **Session ID** | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` |
| **Started** | 2026-07-11 |
| **Status** | `in_progress` |
| **Focus** | Env partitions + promotes; stack-pilot 0.1.0 Q1+Q2 GO |
| **Transcript** | `C:\Users\Administrator\.cursor\projects\E-MyAgent\agent-transcripts\93d977cc-7c3b-4a37-b889-09d2e6676ed5\` |

### Outcomes (update as work proceeds)

- [x] Created `ideas/` and `workflow/` tracking + safety rules
- [x] User confirmed partitioning plan
- [x] Shrunk E: by 30 GB → label `DEV` (~67.66 GB)
- [x] Created F:`PREPROD` 10 GB, G:`PROD` 10 GB, H:`RELEASES` 10 GB
- [x] Created `H:\releases\` + `PURPOSE.md` on E/F/G/H
- [x] Cursor rule `.cursor/rules/drive-purposes.mdc`
- [x] Central port registry `workflow/ports/` (mandatory reservation)
- [x] Cursor rule `.cursor/rules/port-reservation.mdc`
- [x] User approved: **keep** port reservation system as standing policy
- [x] Prod deploy full wrapper: `E:\Source\Deployment\scripts\deploy-prod-app.ps1` (zone delena.buzz)
- [x] Docs: `workflow/prod-deploy.md`; nginx apps include wired
- [x] DB schema-per-env policy documented (`workflow/db/`) — user approved
- [x] CSS mandatory for app auth (`workflow/css/`) — use existing MyWorkspace CSS
- [x] Promote evidence + skills (`workflow/promote/`, `promote-*` skills) — user approved
- [x] Mandatory activity documentation (`workflow/activity/`) — all agents/subagents
- [x] Standing orders bind **Cursor + Antigravity** (`AGENTS.md`, CONSCIOUS #11)
- [x] CSS Q1 promote to PREPROD **GO** — `F:\apps\css` :4900; evidence `H:\releases\css-0.1.0\evidence\q1\`
- [x] CSS Q2 promote to PROD **GO** — `G:\apps\css` :5900; https://css.delena.buzz; triple-run kept live
- [x] Postgres password reset + `app_css` schemas/roles **active**; CSS F/G on Postgres
- [x] Activity + subagent rollup documented (`workflow/activity/CSS-PROGRAM-ROLLUP.md`)
- [x] Agent-Portal 0.1.0 Q1+Q2 GO — F::4080 / G::5080; auth→prod CSS :5900; staging+prod DNS
- [x] Agent-Portal LOB/@Lob→TEXT + oid migrate; product docs updated (OPS/README/platform)
- [x] Stack-Pilot 0.1.0 Q1+Q2 GO — F::4091 / G::5091; https://control.delena.buzz → :5091; evidence `H:\releases\stack-pilot-0.1.0\evidence\`
- [x] Stack-Pilot sole cutover — stopped DEV `:8091` + PREPROD `:4091`; only prod `:5091` listening
- [x] Stack-Pilot DNS fix 2026-07-11 — created missing Cloudflare A `control.delena.buzz`; HTTPS 200; NIC DNS → 1.1.1.1
- [x] Stack-Pilot 0.1.1 Q1+Q2 GO — Task Manager UI; prod-apps (css/agent-portal/hdrive); https://control.delena.buzz
- [x] Stack-Pilot 0.1.2 Q1+Q2 GO — Realme P2 Pro plan (OLED dark, safe-area, 48px+ touch, unlock sheet)

### Next

- **Confirm:** which H: release folders to prune (retention max 3) — name exact folders before delete
- Optional: real-device screenshot pass on Realme P2 Pro portrait + keyboard open
- Optional: “Take Control” on prod-apps to run under Stack Pilot PID tree (currently RUNNING_EXTERNAL)
- **Roadmap:** Dual-CLI subagent job runner + Agent Portal predefined pipelines (`ideas/dual-cli-subagent-workflow.md`)
---

## How to add a session

Copy this block to the top of **History** (or replace **Active session** when starting a new chat):

```md
## YYYY-MM-DD — `<session-id>`

| Field | Value |
|-------|-------|
| **Session ID** | `<session-id>` |
| **Started** | YYYY-MM-DD |
| **Status** | `in_progress` |
| **Focus** | … |
| **Transcript** | `…\agent-transcripts\<session-id>\` |

### Outcomes
- …

### Next
- …
```

Session ID source: folder name under  
`C:\Users\Administrator\.cursor\projects\E-MyAgent\agent-transcripts\`.

---

## History

<!-- Move completed active sessions here -->
