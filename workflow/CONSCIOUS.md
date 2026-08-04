# Machine consciousness

Standing orders for **every AI agent** on this machine (`E:\MyAgent` workspace) — including **Cursor**, **Antigravity**, and any other provider (Agent Portal or local).

**Last updated:** 2026-07-31  
**Session that recorded this:** AI-DLC + autonomous-ops decision lock (#23) · prior: OpenRouter API env (#22) · DeepSeek (#21) · Cloudflare Workers AI (#19) · repo inventory (#20)

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

13. **Dependency versions + git tags are mandatory on promote** (user-directed 2026-07-15 — **keep**)  
    Multi-app prod means shared upstreams (especially **CSS**). Every Q1/Q2 promote must record:  
    - This app’s **git tag** (preferred) or commit SHA  
    - Each dependency’s **version + git tag** + release pack id (CSS minimum for auth apps)  
    SoT: `workflow/deps/DEPENDENCY-MATRIX.md` (+ `DEPENDENCIES.json`).  
    Per release: `H:\releases\<app>-<ver>\DEPENDENCIES.md`.  
    CHECKLIST / SUMMARY / ACTIVITY-LOG must name these; missing → **NO-GO**.  
    After GO + deploy, update the matrix to match live F:/G: pins.

14. **E2E testing subagents are mandatory when an application is built** (user-directed 2026-07-15 — **keep**)  
    Whenever an app (or meaningful UI/API surface) is **built / shipped / materially changed**, the Crew Lead **must hire testing subagents** for end-to-end coverage — not chat-only smoke.  
    SoT: `workflow/testing/E2E-HIRE.md` (+ `workflow/testing/README.md`).  
    **Visual / UI apps:** validate at least these device presets from `workflow/devices/` **in parallel hires** when practical:  
    - **Realme P2 Pro** (`realme-p2-pro` · **360×780**) — primary phone  
    - **Computer / desktop** (`desktop-1280` · **1280×800**)  
    - **Tablet** (`tablet-pad2-approx` · **800×1280**)  
    API-only surfaces may hire API E2E without the three visual projects, but must still hire a testing subagent and write evidence.  
    Missing hired E2E for a UI ship → treat as incomplete; do not call “done” / promote-ready without evidence under the app `e2e/` (or `H:\releases\...\evidence\e2e\`).

15. **Playwright run slot — register before run, confirm after** (user-directed 2026-07-15 — **keep**)  
    Concurrent Playwright browsers degrade this machine. **At most one** Playwright (or equivalent browser E2E) runner may execute at a time.  
    SoT: `workflow/testing/PLAYWRIGHT-SLOT.md` + `workflow/testing/playwright-slot.json`.  
    **Before** any `npx playwright` / `npm run test:e2e*`: claim via `workflow/testing/scripts/claim-playwright-slot.ps1`.  
    If claim fails (busy) → wait or reschedule; do **not** start another instance.  
    **After** the run (pass/fail/abort): release via `release-playwright-slot.ps1` with a result confirmation so the next agent can proceed.  
    Editing `e2e/**` specs does not require the slot — **running** does. Parallel Device Lab *authors* are fine; **execution** is serialized through this slot.

16. **DEV E2E before git tag / pack** (user-directed 2026-07-15 — **keep**)  
    For UI apps, run Device Lab E2E against **DEV** **before** annotated release tags and H: pack cut.  
    SoT: `GIT-RELEASE-MANAGEMENT.md` §6 · skill `git-release` · hire `e2e-hire` + Playwright slot (#15) + DEV host login (#18).  
    Prefer Realme **360×780** + desktop **1280×800** + tablet **800×1280** on DEV. Staging/prod browser checks may complement promote; they do **not** replace DEV E2E as the tag gate.  
    Hire **`git-release`** for tagging only after DEV E2E is green (or API-only app with API E2E green). Missing DEV E2E → **NO-GO for tag**.  
    When the app has a DEV public hostname, auth/login E2E on that host is part of this gate (#18) — loopback-only login does **not** satisfy #16 for CSS consumers.

17. **Reviewer SIGN-OFF before any git push** (user-directed 2026-07-15 — **keep**)  
    Before **`git push`** of a branch tip **or** annotated tag, the Lead **must hire a readonly Reviewer** and obtain a written **SIGN-OFF** with verdict **GO**.  
    SoT: `workflow/review/REVIEWER-SIGNOFF.md` (template + store path). Preferred evidence: `H:\releases\<app>-<ver>\evidence\review\SIGN-OFF.md` (or session `agents/.../SIGN-OFF.md` when no pack yet).  
    Local **`git commit`** may proceed without a Reviewer. **`git push`** / **`git push --tags`** without **GO** → **NO-GO** (do not push).  
    Log reviewer agent id + SIGN-OFF path in ACTIVITY-LOG. Reviewer checks at minimum: docs updated (#12), no secrets, fleet splits respected (classic vs side fleets), DEV E2E green when the push includes a release tag (#16), and domain login evidence when #18 applies.

18. **Playwright login E2E on DEV public domain** (user-directed 2026-07-15 — **keep**)  
    When a Playwright tester exercises **login** (password, hybrid, or CSS SSO), the run **must** use the app’s **DEV public hostname** when one exists (e.g. ProdDeck `https://home-dev.delena.buzz`) — not only `http://127.0.0.1:3xxx` / `localhost`.  
    SoT: `workflow/testing/DEV-HOST-E2E.md` (+ `E2E-HIRE.md`).  
    Reasons: OAuth `redirect_uri` / origin, cookies, HTTPS, nginx/CF path, CSS CORS. Loopback may complement non-auth smoke; it does **not** replace domain login for auth apps.  
    Evidence must record the domain `baseURL`. No DEV subdomain yet → loopback + documented waive + task to add host. Missing domain login E2E when a DEV host exists → incomplete / **NO-GO** for #16 tag on that app.

19. **Cloudflare Workers AI credentials via env (never commit)** (user-directed 2026-07-19 — **keep**)  
    Workers AI account/token live in **Windows User env** and `workflow/secrets/cloudflare-workers-ai.env` (gitignored).  
    Vars: **`CLOUDFLARE_ACCOUNT_ID`**, **`CLOUDFLARE_WORKERS_AI_TOKEN`**.  
    SoT how-to: `workflow/cloudflare-workers-ai.md` (+ `.env.example`) — includes **model catalog fetch** (`ai/models/search`) and **neuron quota checks** (`cf-ai-neurons` header · GraphQL `aiInferenceAdaptiveGroups` · Free **10k neurons/day** UTC · error **4006** when exhausted).  
    Keep Workers AI token **separate** from Zone Edit / DNS (`workflow/secrets/cloudflare.token`, `agent-portal/.env` `CLOUDFLARE_API_TOKEN`).  
    Never commit tokens; redact in ACTIVITY-LOG. Verify with token verify + a sample `ai/run` call before relying on inference.  
    Mindmap must keep an awareness node for this standing order.

20. **Repository visibility inventory is mandatory** (user-directed 2026-07-19 — **keep**)
    Track every GitHub repository owned by `sivaram311` in `workflow/repos/REGISTRY.md` and `registry.json`.
    Required metadata: authoritative GitHub visibility (`PUBLIC` / `PRIVATE` / `INTERNAL`), URL, default branch, archived/fork status, local path when known, and update timestamp.
    Refresh with `workflow/repos/refresh-repository-registry.ps1` after create/import/rename/transfer/delete, visibility changes, archive changes, or default-branch changes.
    Visibility must come from authenticated GitHub metadata (`gh repo list`), never inference from a clone URL. Never record credentials or collaborator secrets.

21. **DeepSeek API credentials via env (never commit)** (user-directed 2026-07-25 — **keep**)  
    DeepSeek API key lives in **Windows User env** and `workflow/secrets/deepseek.env` (gitignored).  
    Var: **`DEEPSEEK_API_KEY`**.  
    SoT how-to: `workflow/deepseek.md` (+ `.env.example`) — includes **models list** (`GET /models`) and a sample **chat/completions** call (`https://api.deepseek.com`, OpenAI-compatible).  
    Keep DeepSeek key **separate** from Cloudflare Workers AI / Zone Edit / xAI and other provider secrets.  
    Never commit keys; redact in ACTIVITY-LOG. Verify with `/models` then a sample chat call before relying on inference.  
    Mindmap must keep an awareness node for this standing order.

22. **OpenRouter API credentials via env (never commit)** (user-directed 2026-07-25 — **keep**)  
    OpenRouter API key lives in **Windows User env** and `workflow/secrets/openrouter.env` (gitignored).  
    Var: **`OPENROUTER_API_KEY`**.  
    SoT how-to: `workflow/openrouter.md` (+ `.env.example`) — includes **key/credits** (`GET /api/v1/key`), **models** (`GET /api/v1/models`), free catalog (`:free` / zero pricing), and free-tier RPM/RPD quotas.  
    Keep OpenRouter key **separate** from DeepSeek / Cloudflare / xAI and other provider secrets.  
    Never commit keys; redact in ACTIVITY-LOG. Verify with `/key` then a sample chat call before relying on inference.  
    Mindmap must keep an awareness node for this standing order.

23. **AI-DLC + autonomous operations decision lock** (user-directed 2026-07-31 — **keep**)  
    The user's goal ("make this machine completely AI-managed," "build every app — existing and new — on AI-DLC") is governed by `workflow/aidlc/README.md`, authored after independent consultation with `agy`, Cursor CLI, and Grok, not by ad hoc interpretation.  
    Precise goal: AI runs routine work end-to-end; a **permanent, technically-enforced** exception list (deletes, partitioning, DNS delete, `G:\apps\<app>` overwrite outside promote, Q2 GO, secret resets, **trading-portal live execution**) stays human-only forever and is never revisited by trust-based gate narrowing.  
    Phase 0 (decision lock) done. **Phase 1 (read-only observe/drift-reconcile)** started 2026-07-31, scheduled daily 03:15 — `workflow/aidlc/phase1/drift-reconcile.ps1`; queue is at 0 open findings as of 2026-08-01 after a full triage pass. **Phase 2 (scoped write autonomy)** started 2026-08-01 on explicit user go-ahead with three hard constraints: mandatory human sign-off before any write is applied, agents never receive trade-execution/secret-reset credentials, and auto-deploy (tier 4) stays locked behind a now-quantified Phase 1 metrics bar (`workflow/aidlc/phase2/README.md`) not close to met yet (~1 day of track record vs. the 14+ day bar). v0 = a propose→sign-off→apply pipeline, technically enforced (mirrors the `pre-push` hook's SIGN-OFF pattern). **Extended same day** to five role workers total (repo-registry, docs, qa, security, review — all tested with real runs, all report/propose-only, no auto-apply). `machine-gateway` was researched, not built from scratch — its real implementation already exists live inside `agent-portal` (`/api/machine/*`). `stack-pilot` wiring was designed but deliberately not implemented (live Spring Boot service, needs its own build/test/review pass). **No auto-deploy code of any kind exists** — this is a deliberate, documented decision (see `phase2/README.md`), not an oversight; the trigger condition for building it is recorded there. A **read-only readiness-check script** (`workflow/aidlc/phase4/check-readiness.ps1`) was built 2026-08-01 to report status against that bar — it cannot enable or build anything, only tell you whether the bar is cleared. First real check: **NOT READY**, 1/14 consecutive scheduled Phase 1 days. The `pre-push` sign-off gate (`workflow/aidlc/hooks/`) is **live on `E:\MyAgent` only**; the `F:`/`G:` ACL agent-account model is a **reviewed design, not applied** (`workflow/aidlc/acl-account-model-proposal.md`). AI-DLC Inception baselines for existing apps land **opportunistically** (next real work on that app), never as a simultaneous fleet-wide sprint.  
    Do not build orchestrator/gateway/cockpit infrastructure, grant Q1 auto-deploy, or start a multi-app AI-DLC retrofit sprint without re-reading `workflow/aidlc/README.md`'s current phase first — it is the SoT for this initiative and will be updated as phases complete.

24. **App name + version must be clearly displayed** (user-directed 2026-08-04 — **keep**)  
    Every app that is built and deployed — DEV, PREPROD, and PROD alike — must clearly display its **application name and version**, both:  
    - **In the UI** — human-visible without dev tools (footer, header, or an About/Settings screen).  
    - **Via API** — a `/api/health` or `/api/version`-style endpoint reporting `name` + `version` machine-readably.  
    Applies to every provider (Cursor, Antigravity, Grok, Claude Code) — not a Claude-only preference.  
    **Enforced as a Q1/Q2 promote gate** (same tier as rule #13 dependency versions): missing or unclear name/version on either surface → **NO-GO**. SoT: `workflow/promote/gates.md`.  
    **Not retroactive on its own** — existing apps are not required to stop and add this today. It becomes mandatory the next time that app has a real Q1/Q2 promote, same opportunistic pattern as the AI-DLC baseline rollout (rule #23). New builds from today onward must have it from first DEV deploy.

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
| **H:** | `RELEASES` | 10 GB | **Release handoff** — last **3 per app family** (+ live F:/G: pins) under `H:\releases\`; older → `C:\backup\releases\` zips | Add/promote when asked; archive/prune per `workflow/promote/release-archive.md` |

Each env drive also has `PURPOSE.md` at its root.

### Path contracts

```text
E:\          → development work (default for agents)
F:\          → staging deploy root (not an archive)
G:\          → prod-like deploy root (not an archive)
H:\releases\ → versioned release handoff (last 3 per app + F/G pins; not a runtime)
C:\backup\releases\ → cold archive zips (GDrive-synced; no node_modules / .env*)
```

Promote flow: build on **E:** → store package on **H:** → deploy to **F:** → promote to **G:** when approved.  
H: packs may omit `node_modules` — on F:/G: run `npm ci` then start. Archive SOP: `workflow/promote/release-archive.md`.  
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
| Version SoT | `workflow/deps/` (CSS live tag e.g. `v0.1.0`) |

New apps: login via CSS + validate JWT via JWKS (`clientId` required).  
Promotes must cite **CSS version + git tag**, not only `clientId`.

### Dependency version contracts

| Item | Value |
|------|-------|
| Matrix SoT | `workflow/deps/DEPENDENCY-MATRIX.md` |
| JSON mirror | `workflow/deps/DEPENDENCIES.json` |
| Per release | `H:\releases\<app>-<ver>\DEPENDENCIES.md` |
| Promote bar | App git tag + upstream versions/tags required or **NO-GO** |

### Promote contracts

| Gate | Path | Evidence |
|------|------|----------|
| Q1 | E: → F: | `H:\releases\<app>-<ver>\evidence\q1\` |
| Q2 | F: → G: | `H:\releases\<app>-<ver>\evidence\q2\` |

Orchestrator skill: `promote-em`. Details: `workflow/promote/README.md`  
Dependency policy: `workflow/deps/README.md` (rule **13**).

### Activity documentation

All agent/subagent work is append-logged in `workflow/activity/ACTIVITY-LOG.md` (plus evidence packs when promoting).  
Promote rows must include **git tag** and **dependent versions**.

### Docs after action (rule 12)

Updating **how-to / ops / product docs** after meaningful changes is mandatory — same priority as the activity log. Prefer same-turn updates to app `docs/`, README, `DEPLOY.md`, and `workflow/` when topology or procedure changes.

### Cloudflare Workers AI (rule 19)

| Item | Value |
|------|-------|
| Account ID env | `CLOUDFLARE_ACCOUNT_ID` |
| Token env | `CLOUDFLARE_WORKERS_AI_TOKEN` |
| Secret file | `workflow/secrets/cloudflare-workers-ai.env` (gitignored) |
| How-to | `workflow/cloudflare-workers-ai.md` |
| DNS/Zone token | separate — `workflow/secrets/cloudflare.token` / agent-portal `.env` |

### DeepSeek API (rule 21)

| Item | Value |
|------|-------|
| Key env | `DEEPSEEK_API_KEY` |
| Secret file | `workflow/secrets/deepseek.env` (gitignored) |
| How-to | `workflow/deepseek.md` |
| Base URL | `https://api.deepseek.com` |

### OpenRouter API (rule 22)

| Item | Value |
|------|-------|
| Key env | `OPENROUTER_API_KEY` |
| Secret file | `workflow/secrets/openrouter.env` (gitignored) |
| How-to | `workflow/openrouter.md` |
| Base URL | `https://openrouter.ai/api/v1` |

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
- Dependency versions: `workflow/deps/README.md`
- Dependency rule: `.cursor/rules/dependency-versions.mdc`
- Promote: `workflow/promote/README.md`
- Promote rule: `.cursor/rules/promote-evidence.mdc`
- Activity log: `workflow/activity/README.md`
- Activity rule: `.cursor/rules/activity-documentation.mdc`
- Cloudflare Workers AI: `workflow/cloudflare-workers-ai.md`
- DeepSeek API: `workflow/deepseek.md`
- OpenRouter API: `workflow/openrouter.md`
- AI-DLC + autonomous ops: `workflow/aidlc/README.md`
