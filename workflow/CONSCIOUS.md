# Machine consciousness

Standing orders for **every AI agent** on this machine (`E:\MyAgent` workspace) — including **Cursor**, **Antigravity**, and any other provider (Agent Portal or local).

**Last updated:** 2026-07-11  
**Session that recorded this:** `93d977cc-7c3b-4a37-b889-09d2e6676ed5`

**Provider note:** `.cursor/rules` and `.cursor/skills` help Cursor discover policy. Antigravity and others must still follow this file and `AGENTS.md`. Activity logging and promote evidence are **provider-agnostic**.

---

## Strict rules (non-negotiable)

1. **No deletion without confirmation**  
   Do not delete files, folders, projects, volumes, or partitions unless the user explicitly confirms the exact target and action.

2. **No partitioning without confirmation**  
   Do not create, shrink, extend, format, wipe, or repartition any disk or volume unless the user explicitly confirms the exact plan.

3. **Propose first, execute after yes**  
   Disk layout ideas, env plans, and commands may be written as proposals only. Wait for confirmation before applying destructive or irreversible changes.

4. **When unsure, stop and ask**  
   Treat ambiguous cleanup, “organize disk”, or “set up drives” requests as planning-only until confirmed.

5. **Honor each drive’s purpose**  
   Never use a volume for a different role than listed below (e.g. do not put agent experiments on PROD, do not archive releases on PREPROD).

6. **Port reservation is mandatory** (user-approved 2026-07-11 — **keep**)  
   No app may listen on a port until it is reserved in `workflow/ports/REGISTRY.md` (+ `registry.json`).  
   Ranges: DEV **3000–3999**, PREPROD **4000–4999**, PROD **5000–5999**. Process: `workflow/ports/README.md`.  
   Do not remove or replace this registry without explicit user confirmation.

7. **Postgres schema-per-env is mandatory** (user-approved 2026-07-11 — **keep**)  
   Shared instance **:5432**. Each app uses database `app_<id>` with schemas **`dev` / `preprod` / `prod`** and matching roles.  
   E:→`dev` only, F:→`preprod` only, G:→`prod` only. Reserve in `workflow/db/` before wiring.  
   Conventions: `workflow/db/conventions.md`.

8. **Centralized Security System (CSS) is mandatory for app auth** (user-directed 2026-07-11 — **keep**)  
   Use `E:\MyWorkspace\centralized-security-system` (**:9000**). Do not invent per-app IdPs.  
   Register `clientId` in `workflow/css/CLIENT-REGISTRY.md`. Integration: `workflow/css/integration.md`.

9. **Promote requires evidence + EM GO** (user-approved 2026-07-11 — **keep**)  
   DEV→PREPROD (**Q1**) and PREPROD→PROD (**Q2**) need packs under `H:\releases\...\evidence\`.  
   Skills: `promote-em`, `promote-qa`, `promote-security`, `promote-review`, `promote-ops`.  
   Process: `workflow/promote/README.md`. Ops deploys only after **GO**.

10. **All agent activity must be documented** (user-directed 2026-07-11 — **keep**)  
    Every agent/subagent action is logged (not chat-only) — **Cursor and Antigravity alike**.  
    Primary log: `workflow/activity/ACTIVITY-LOG.md`. Promote roles also write evidence folders.  
    Process: `workflow/activity/README.md`. Redact secrets. Do not delete activity history without confirmation.

11. **Rules are provider-agnostic** (user-directed 2026-07-11 — **keep**)  
    These standing orders bind **Cursor, Antigravity, and any other AI agent** on this machine.  
    Entry points: `AGENTS.md` + this file. Do not treat `.cursor/` as Cursor-only exemptions for other providers.

12. **Update docs after every meaningful action** (user-directed 2026-07-11 — **keep**)  
    Documentation is always important — not optional cleanup. After any action that changes behavior, config, deploy topology, ports, DB, auth, or ops procedures:  
    - Update the **product/app docs** that operators will read (e.g. `docs/OPS.md`, README, platform guides in the app repo).  
    - Update **machine workflow docs** when policy or registries change (`workflow/`, this file, `AGENTS.md`).  
    - Keep **DEPLOY.md** / release README / evidence notes in sync on F:/G:/H: when those envs change.  
    Chat + ACTIVITY-LOG alone are **not** enough when the next human/agent would otherwise lack written how-to.  
    Do this in the **same work turn** as the change whenever practical; do not leave “docs later” as the default.

---

## Allowed without extra confirmation

- Read-only inspection (list disks, partitions, free space, folder trees)
- Creating **new** files/folders inside the workspace for docs, ideas, workflow (non-destructive)
- Editing tracking docs the user asked to maintain (`ideas/`, `workflow/`, `.cursor/rules/`)
- Appending to `workflow/activity/ACTIVITY-LOG.md` and evidence packs (documentation is mandatory)
- Updating product/ops docs and registries to reflect work just completed (rule 12)
- Writing **inside the correct env root** when the user explicitly names that env (still no deletes without confirm)
- Adding **new** port reservations to `workflow/ports/` when starting an app the user requested (still no deletes/reassigns without confirm)
- Adding **new** DB schema reservations to `workflow/db/` when an app needs Postgres (DDL create/drop still needs confirmation)
- Adding **new** CSS `clientId` rows to `workflow/css/CLIENT-REGISTRY.md` when wiring an app (CSS server seed/DDL still follow CSS repo + confirmation for prod)

---

## Drive purposes (strict) — APPLIED 2026-07-11

| Letter | Label | Size | Purpose | Agents may |
|--------|-------|------|---------|------------|
| **C:** | OS | ~202 GB | Windows, runtimes, shared tools only — **not** an app env root | Install tools only when asked |
| **D:** | (optical) | — | CD/DVD — not a data env | Ignore for projects |
| **E:** | `DEV` | ~68 GB | **Development** — AI agents, repos, MyAgent, MyWorkspace, Source, GitBackup | Day-to-day create/edit here |
| **F:** | `PREPROD` | 10 GB | **Pre-production / staging** runtime only | Change only when user says pre-prod/staging |
| **G:** | `PROD` | 10 GB | **Production-like** runtime only | Change only when user explicitly says prod |
| **H:** | `RELEASES` | 10 GB | **Last 3 release packages** only (`H:\releases\`) | Add/promote releases only when asked; retention max 3 |

Each env drive also has `PURPOSE.md` at its root.

### Path contracts

```text
E:\          → development work (default for agents)
F:\          → staging deploy root (not an archive)
G:\          → prod-like deploy root (not an archive)
H:\releases\ → versioned release artifacts (keep last 3 only)
```

Promote flow: build on **E:** → store package on **H:** → deploy to **F:** → promote to **G:** when approved.  
Prod public go-live: `workflow/prod-deploy.md` → `E:\Source\Deployment\scripts\deploy-prod-app.ps1` (zone **delena.buzz**).

### Port contracts

| Env | Drive | Port range |
|-----|-------|------------|
| dev | E: | 3000–3999 |
| preprod | F: | 4000–4999 |
| prod | G: | 5000–5999 |
| shared | — | 80/443 nginx, 5432 postgres, … |

Registry: `workflow/ports/REGISTRY.md`

### DB schema contracts

| Env | Drive | Schema (in `app_<id>`) | Role |
|-----|-------|--------------------------|------|
| dev | E: | `dev` | `app_<id>_dev` |
| preprod | F: | `preprod` | `app_<id>_preprod` |
| prod | G: | `prod` | `app_<id>_prod` |

Instance: `127.0.0.1:5432`. Registry: `workflow/db/SCHEMA-REGISTRY.md`

### Auth contracts (CSS)

| Item | Value |
|------|-------|
| Project | `E:\MyWorkspace\centralized-security-system` |
| Port | **9000** |
| Public | `https://delena.buzz/auth/` → nginx → `:9000` |
| Registry | `workflow/css/CLIENT-REGISTRY.md` |

New apps: login via CSS + validate JWT via JWKS (`clientId` required).

### Promote contracts

| Gate | Path | Evidence |
|------|------|----------|
| Q1 | E: → F: | `H:\releases\<app>-<ver>\evidence\q1\` |
| Q2 | F: → G: | `H:\releases\<app>-<ver>\evidence\q2\` |

Orchestrator skill: `promote-em`. Details: `workflow/promote/README.md`

### Activity documentation

All agent/subagent work is append-logged in `workflow/activity/ACTIVITY-LOG.md` (plus evidence packs when promoting).

### Docs after action (rule 12)

Updating **how-to / ops / product docs** after meaningful changes is mandatory — same priority as the activity log. Prefer same-turn updates to app `docs/`, README, `DEPLOY.md`, and `workflow/` when topology or procedure changes.

---

## Environment layout status

| Env | Root | Status |
|-----|------|--------|
| OS / tools | `C:` | Unchanged |
| Development | `E:` `DEV` ~67.66 GB | **Applied** — shrunk by 30 GB |
| Pre-prod | `F:` `PREPROD` 10 GB | **Applied** |
| Prod | `G:` `PROD` 10 GB | **Applied** |
| Releases (last 3) | `H:` `RELEASES` 10 GB | **Applied** — `H:\releases\` created |

Note: F/G/H are logical partitions inside one MBR extended partition on Disk 0 (same VMware disk).

---

## Related files

- Workflow: `workflow/README.md`
- Sessions: `workflow/sessions.md`
- Ideas: `ideas/README.md`
- Cursor rule: `.cursor/rules/machine-safety.mdc`
- Drive purposes rule: `.cursor/rules/drive-purposes.mdc`
- Port registry: `workflow/ports/README.md`
- Port reservation rule: `.cursor/rules/port-reservation.mdc`
- DB schemas: `workflow/db/README.md`
- DB schema rule: `.cursor/rules/db-schema-per-env.mdc`
- CSS auth: `workflow/css/README.md`
- CSS rule: `.cursor/rules/css-mandatory.mdc`
- Promote: `workflow/promote/README.md`
- Promote rule: `.cursor/rules/promote-evidence.mdc`
- Activity log: `workflow/activity/README.md`
- Activity rule: `.cursor/rules/activity-documentation.mdc`
