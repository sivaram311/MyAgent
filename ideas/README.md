# Implementation Ideas

Track product and technical ideas for MyAgent before they move into active work.

Related: [Development workflow](../workflow/README.md) · [Session log](../workflow/sessions.md)

## How to use

1. Add a new idea under **Backlog**.
2. Move it to **In progress** when you start building.
3. Move it to **Done** when shipped (or drop it under **Parked** if deferred).

Use this template for each idea:

```md
### Title
- **Status:** backlog | in progress | done | parked
- **Priority:** high | medium | low
- **Summary:** One or two sentences on the idea.
- **Why:** Problem it solves or value it adds.
- **Notes:** Open questions, constraints, links.
```

---

## Backlog

### Dual-CLI subagent workflow (Cursor + Antigravity)
- **Status:** backlog
- **Priority:** high
- **Summary:** Job pipeline that runs promote/ops/docs roles via Cursor CLI + Antigravity CLI; later configure with Agent Portal predefined pipelines/tasks.
- **Why:** Encode CONSCIOUS + promote skills as reproducible automation; provider-agnostic (#11) and docs-after-action (#12).
- **Notes:** Full sketch: [dual-cli-subagent-workflow.md](./dual-cli-subagent-workflow.md). Do not auto Q2/prod without human GO.

### Identify legacy listeners
- **Status:** backlog
- **Priority:** medium
- **Summary:** Map java/node ports (4200, 8080–8082, 8091, 9000) to real app-ids and move into env ranges when possible.
- **Notes:** Listed as `legacy` in `workflow/ports/REGISTRY.md`.

## In progress

### Stack Pilot — Machine Control Panel
- **Status:** in progress (pre-work / vision)
- **Priority:** high
- **Summary:** Evolve Stack Pilot into the host operator cockpit on `control.delena.buzz` (fleet, edge, drives, promote status) keeping OLED palette; MyAgent stays SoT.
- **Why:** Control URL + prod fleet management already point at this role; need one phone-friendly surface without a second policy editor.
- **Notes:** Full sketch: [stack-pilot-machine-control-panel.md](./stack-pilot-machine-control-panel.md). Vision: `E:\Source\stack-pilot\agents\pre-work\01-vision-walkthrough.md`. **No coding until approval.**

## Done

### Activity documentation (all agents)
- Append-only log: `workflow/activity/ACTIVITY-LOG.md`; rule in CONSCIOUS #10.
- Binds **Cursor + Antigravity** (`AGENTS.md`, CONSCIOUS #11).

### Promote with evidence (skills + subagents)
- Q1/Q2 gates, evidence under `H:\releases\...\evidence\`, skills `promote-*`.
- Docs: `workflow/promote/`

### CSS mandatory for app builds
- Use `E:\MyWorkspace\centralized-security-system` (:9000); register `clientId` in `workflow/css/`.
- See [css-mandatory-for-apps.md](./css-mandatory-for-apps.md).

### DB schema-per-env policy
- Approved and documented: `workflow/db/` (conventions + SCHEMA-REGISTRY).
- Shared Postgres :5432; schemas `dev` / `preprod` / `prod` per app database.

### Prod deploy wrapper (Cloudflare + nginx)
- Script: `E:\Source\Deployment\scripts\deploy-prod-app.ps1`
- Zone: `delena.buzz`; guide: `workflow/prod-deploy.md`

### Central port reservation registry
- Created `workflow/ports/` with ranges, REGISTRY.md, registry.json; mandatory before bind.
- Ranges: DEV 3000–3999, PREPROD 4000–4999, PROD 5000–5999.

### Env disk layout (dev / pre-prod / prod / releases)
- Applied: E:`DEV` ~68 GB, F:`PREPROD` 10 GB, G:`PROD` 10 GB, H:`RELEASES` 10 GB (`H:\releases\` for last 3).
- Docs: `PURPOSE.md` on each env drive; rules in `.cursor/rules/drive-purposes.mdc`.

## Parked

<!-- Deferred or rejected ideas (keep for later reference) -->
