# Promote field lessons (ops / QA)

**Recorded:** 2026-07-13 (Stack Pilot 0.1.3 UI hotfix promote)  
**Status:** standing guidance for promote crew — keep until superseded  
**Audience:** `promote-em`, `promote-ops`, `promote-qa` (and any hired specialist on a promote)

These lessons came from live promote struggle; they were **not** obvious from CONSCIOUS alone.

---

## 0. Always record git tag + dependency versions

As of **2026-07-15** (CONSCIOUS **#13**): every promote must document this app’s **git tag** and each upstream’s **version + git tag** (especially CSS). SoT: `workflow/deps/`. Template: `promote/templates/DEPENDENCIES.md`. Missing → **NO-GO**.

---

## 1. Launcher “Failed to bind” can be a false negative

Many app `start.ps1` scripts sleep ~10s then check the port. Cold Spring Boot / Node often needs **11–20s**.

| Do | Don’t |
|----|--------|
| After start, **poll** `LISTENING` on the target port for 30–60s | Treat the script’s first “Failed to bind” as final |
| Read `*.out.log` / `*.err.log` and `netstat` before declaring deploy fail | Stop the promote solely because the launcher exited non-zero while the JVM is still starting |
| Note the race in `ops/deploy-log.md` when it happens | Assume err.log empty means “never started” |

---

## 2. Cloudflare: Zone Edit token ≠ cache purge

`CLOUDFLARE_API_TOKEN` used for DNS upsert may **not** have Cache Purge permission. Purge API can return auth error (`code: 10000`).

**Required pattern for edge-cached static assets** (`max-age` on `/js/*`, `/css/*`):

1. Prefer **versioned URLs in DYNAMIC HTML**, e.g. `/js/app.js?v=<release>` and `/css/style.css?v=<release>`.
2. Attempt CF purge by URL when a token with purge rights exists; if purge fails, **do not block** the promote — rely on cache-bust query + document in evidence.
3. Tell humans: old browser tabs / unversioned bookmarks may still HIT stale assets for up to the edge TTL (often **4 hours**).

HTML marked DYNAMIC still loads scripts by the href in the document — if href has no `?v=`, clients keep fetching the stale HIT.

---

## 3. Smoke the URL the HTML actually loads

| Check | Why |
|-------|-----|
| Parse/smoke **`/js/app.js?v=<release>`** (or whatever `index.html` references) | Bare `/js/app.js` can still be a **HIT** of the broken old file while origin is fixed |
| Confirm public HTML contains the new `?v=` (or hash) after Q2 | Proves DYNAMIC HTML rolled out |
| Record `CF-Cache-Status` when useful | MISS/HIT explains “works locally, broken on phone” |

Origin `:port` healthy ≠ public edge healthy for cached paths.

---

## 4. PowerShell: never use `$PID` or `$HOME` as locals

In PowerShell, `$PID` and `$HOME` are **read-only / automatic**. Kill-by-port helpers that assign `$pid = …` or `$home = Invoke-WebRequest …` throw and abort the deploy mid-flight.

Use names like `$procId`, `$page`, `$appHome`.

---

## 5. ACTIVITY-LOG: serialize parallel crew appends

Parallel subagents appending to `workflow/activity/ACTIVITY-LOG.md` can **scramble the markdown table** (header separator lands mid-rows).

| Do | Don’t |
|----|--------|
| EM (or one designated logger) owns ACTIVITY-LOG rows for the gate, **or** append one agent at a time | Blind parallel `StrReplace` on the same header block |
| After parallel crew finishes, EM **spot-check** the top of ACTIVITY-LOG for a valid table | Assume subagent “logged ok” without reading the file |
| Specialists always write their **evidence folder** first; ACTIVITY-LOG can be a single EM batch | Only chat |

---

## 6. Staging / prod hostnames are part of the gate (not optional)

Q1 is **not** complete with `F:` + port alone. Ops must:

1. Create/confirm **`<app>-staging.delena.buzz`** (or agreed name) in Cloudflare  
2. Nginx `server_name` → PREPROD port on F:  
3. Destination smoke on the **public HTTPS** staging URL  

Q2: same for prod hostname (`<app>.delena.buzz`).  

**Stack Pilot:** `control-staging.delena.buzz` → `:4091`; `control.delena.buzz` → `:5091` (DNS for `control*` via `cloudflare-dns.ps1`; wrapper blocks reserved `control`).

Missed on stack-pilot 0.2.0-a first Q1 pass (localhost-only) — remediated 2026-07-13.

---

## 7. Angular `:application` UI packs must use `browser/`

Agent Portal (and other Angular 17+ application-builder apps) emit:

`frontend/dist/<project>/browser/index.html`

Nginx `root …/ui` expects a **flat** tree (`ui/index.html`), matching older releases.

| Do | Don’t |
|----|--------|
| Copy `dist/frontend/browser/*` → `ui/` (see `scripts/pack-release-ui.ps1`) | Copy `dist/frontend/*` (leaves `ui/browser/…`) |
| Smoke **public `GET /`** + hashed JS/CSS from `index.html` | Smoke only `/api/health` |
| Keep nginx `root` on `…/ui` unless Ops deliberately changes it | “Fix” by pointing nginx at `ui/browser` without updating pack docs |

Symptom if wrong: nginx `directory index … forbidden` + `redirection cycle … /index.html` (403 on `/`).

Hit on **agent-portal 0.1.7** Q1 (2026-07-13); remediated same version UI hotfix.

---

## 7. H: is handoff — not a second install tree

H: filled up (2026-07-13) because every AgentVerse pack stored full `node_modules` + `.next` and retention (“last 3”) was never enforced.

| Do | Don’t |
|----|--------|
| Treat `H:\releases\` as versioned handoff + evidence | Run production/staging processes from H: |
| Keep last **3 per app family** + **F:/G: live pins** | Keep every historical tree on the 10 GB volume |
| Archive older packs to `C:\backup\releases\*.zip` **without** `node_modules` / `.env*` | Sync secrets or full `node_modules` to GDrive |
| After copy to F:/G:: **`npm ci`** then start | Assume `node_modules` must live forever on H: |

SOP: `workflow/promote/release-archive.md`.

---

## Quick checklist (paste into ops/qa notes)

- [ ] Port poll ≥30s after start (ignore premature bind fail if process comes up)
- [ ] Static assets referenced with `?v=<release>` (or content hash) in HTML
- [ ] Public smoke uses **versioned** asset URL from HTML
- [ ] **Angular apps:** pack from `dist/.../browser/*` into flat `ui/` (not `dist/...` root)
- [ ] Public smoke includes **`GET /`** (not only `/api/health`)
- [ ] CF purge attempted; if auth fail → documented, cache-bust relied upon
- [ ] **Q1:** public staging hostname live + smoked (not only 127.0.0.1)
- [ ] **Q2:** public prod hostname live + smoked
- [ ] No `$PID` / `$HOME` in deploy scripts run this gate
- [ ] ACTIVITY-LOG table intact after crew finishes
- [ ] H: retention: last 3/app + live pins; archive excess to `C:\backup\releases\`
- [ ] Node deploy from H: pack/zip: `npm ci` on F:/G: before start
