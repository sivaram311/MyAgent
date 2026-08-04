# Phase 1 review queue

Append-only. Each run adds one block at the **top** (below this header).
Human triage: mark each finding accepted (real, needs fixing) or false-positive
(mark it directly below the finding line) so we can compute a false-positive
rate before Phase 2 decisions lean on this data.

---

## 2026-08-04 03:15:02  -  3 finding(s)  -  trigger: scheduled  -  report: `reports/2026-08-04T03-15-02Z-drift-report.md`

- [x] **[warn] [ports]** Port 3350 is listening (owning process: java) (within the managed 3000-5999 range) but has **no entry** in workflow/ports/REGISTRY.md - CONSCIOUS #6 requires reservation before bind. _(triage: accepted, FIXED 2026-08-04 - confirmed via Win32_Process PID 7128 as machine-sentinel backend (`java -jar machine-sentinel-backend-0.1.0-SNAPSHOT.jar`), added to ports/REGISTRY.md + registry.json)_
- [x] **[warn] [ports]** Port 3351 is listening (owning process: python) (within the managed 3000-5999 range) but has **no entry** in workflow/ports/REGISTRY.md - CONSCIOUS #6 requires reservation before bind. _(triage: accepted, NOT fixed - confirmed via Win32_Process PID 7104 as an ad-hoc `python -m http.server 3351 --bind 127.0.0.1`, not a registered app; same pattern as the 2026-08-01 vibehub :3383 stray-process finding - needs your decision: register it, or is it a one-off you can kill)_
- [x] **[error] [repos]** Repo check failed to run: HTTP 401: Requires authentication (https://api.github.com/graphql) _(triage: accepted, NOT fixed - root cause confirmed via `gh auth status`: the stored GitHub token for sivaram311 is invalid/expired. This also blocks any new `gh repo create`/push and is why workflow/repos/REGISTRY.md (last regenerated 2026-08-01) never picked up the new `raga-by-revenge` folder. Needs `gh auth login -h github.com` run interactively - cannot be done headlessly)_


## 2026-08-03 03:15:02  -  0 finding(s)  -  trigger: scheduled  -  report: `reports/2026-08-03T03-15-02Z-drift-report.md`

- No drift detected this run.


## 2026-08-02 03:15:02  -  0 finding(s)  -  trigger: scheduled  -  report: `reports/2026-08-02T03-15-02Z-drift-report.md`

- No drift detected this run.


## 2026-08-01 03:15:02  -  0 finding(s)  -  trigger: scheduled  -  report: `reports/2026-08-01T03-15-02Z-drift-report.md`

- No drift detected this run.


## 2026-08-01 02:52:24  -  0 finding(s)  -  trigger: scheduled  -  report: `reports/2026-08-01T02-52-24Z-drift-report.md`

- No drift detected this run.


## 2026-08-01 02:52:08  -  0 finding(s)  -  trigger: manual  -  report: `reports/2026-08-01T02-52-08Z-drift-report.md`

- No drift detected this run.


## 2026-08-01 02:51:14  -  0 finding(s)  -  report: `reports/2026-08-01T02-51-14Z-drift-report.md`

- No drift detected this run.


## 2026-08-01 00:27:01  -  0 finding(s)  -  report: `reports/2026-08-01T00-27-01Z-drift-report.md`

- No drift detected this run.


## 2026-08-01 00:09:46  -  0 finding(s)  -  report: `reports/2026-08-01T00-09-46Z-drift-report.md`

- No drift detected this run.


## 2026-08-01 00:05:35  -  1 finding(s)  -  report: `reports/2026-08-01T00-05-35Z-drift-report.md`

- [x] **[warn] [ports]** Port 3383 is listening (owning process: node) (within the managed 3000-5999 range) but has **no entry** in workflow/ports/REGISTRY.md - CONSCIOUS #6 requires reservation before bind. _(triage: accepted, NOT fixed - same vibehub stray "astro preview" process as the earlier runs, still needs your decision; see triage/2026-08-01-triage.md)_


## 2026-07-31 23:56:56  -  18 finding(s)  -  report: `reports/2026-07-31T23-56-56Z-drift-report.md`

- [x] **[info] [ports]** Port 3310 (agentverse) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 3311 (agentverse-v2) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 3312 (agentverse-upgrade) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 3320 (proddeck) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 3342 (trading-portal) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 4311 (agentverse-v2) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 4312 (agentverse-upgrade) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 4340 (trading-portal) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 4341 (trading-portal) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 5311 (agentverse-v2) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 5340 (trading-portal) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 5341 (trading-portal) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 9000 (css) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[warn] [ports]** Port 5985 is listening (within the managed 3000-5999 range) but has **no entry** in workflow/ports/REGISTRY.md  -  CONSCIOUS #6 requires reservation before bind. _(triage: false-positive - Windows WinRM, PID 4 System; see triage/2026-08-01-triage.md)_
- [x] **[warn] [ports]** Port 3383 is listening (within the managed 3000-5999 range) but has **no entry** in workflow/ports/REGISTRY.md  -  CONSCIOUS #6 requires reservation before bind. _(triage: accepted, NOT fixed - vibehub stray "astro preview" process, needs your decision; see triage/2026-08-01-triage.md)_
- [x] **[warn] [ports]** Port 5037 is listening (within the managed 3000-5999 range) but has **no entry** in workflow/ports/REGISTRY.md  -  CONSCIOUS #6 requires reservation before bind. _(triage: false-positive - Android adb.exe dev tool, not an app; see triage/2026-08-01-triage.md)_
- [x] **[warn] [ports]** Port 3360 is listening (within the managed 3000-5999 range) but has **no entry** in workflow/ports/REGISTRY.md  -  CONSCIOUS #6 requires reservation before bind. _(triage: accepted, FIXED - added to ports/REGISTRY.md + registry.json (rd-center-project 3360/4360/5360); see triage/2026-08-01-triage.md)_
- [x] **[info] [repos]** Repo **mathura-portfolio** exists on GitHub under sivaram311 but has no row in workflow/repos/REGISTRY.md. _(triage: accepted, FIXED - ran refresh-repository-registry.ps1, repo now registered; see triage/2026-08-01-triage.md)_


## 2026-07-31 23:49:40  -  18 finding(s)  -  report: `reports/2026-07-31T23-49-40Z-drift-report.md`

- [x] **[info] [ports]** Port 3310 (agentverse) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 3311 (agentverse-v2) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 3312 (agentverse-upgrade) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 3320 (proddeck) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 3342 (trading-portal) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 4311 (agentverse-v2) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 4312 (agentverse-upgrade) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 4340 (trading-portal) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 4341 (trading-portal) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 5311 (agentverse-v2) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 5340 (trading-portal) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 5341 (trading-portal) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[info] [ports]** Port 9000 (css) is registered **active** but nothing is currently listening on it. May be a normal not-running-right-now app, or real drift  -  needs a human look. _(triage: false-positive - registry "active" means assigned, not always-running; see triage/2026-08-01-triage.md Group 1)_
- [x] **[warn] [ports]** Port 5985 is listening (within the managed 3000-5999 range) but has **no entry** in workflow/ports/REGISTRY.md  -  CONSCIOUS #6 requires reservation before bind. _(triage: false-positive - Windows WinRM, PID 4 System; see triage/2026-08-01-triage.md)_
- [x] **[warn] [ports]** Port 3383 is listening (within the managed 3000-5999 range) but has **no entry** in workflow/ports/REGISTRY.md  -  CONSCIOUS #6 requires reservation before bind. _(triage: accepted, NOT fixed - vibehub stray "astro preview" process, needs your decision; see triage/2026-08-01-triage.md)_
- [x] **[warn] [ports]** Port 5037 is listening (within the managed 3000-5999 range) but has **no entry** in workflow/ports/REGISTRY.md  -  CONSCIOUS #6 requires reservation before bind. _(triage: false-positive - Android adb.exe dev tool, not an app; see triage/2026-08-01-triage.md)_
- [x] **[warn] [ports]** Port 3360 is listening (within the managed 3000-5999 range) but has **no entry** in workflow/ports/REGISTRY.md  -  CONSCIOUS #6 requires reservation before bind. _(triage: accepted, FIXED - added to ports/REGISTRY.md + registry.json (rd-center-project 3360/4360/5360); see triage/2026-08-01-triage.md)_
- [x] **[info] [repos]** Repo **mathura-portfolio** exists on GitHub under sivaram311 but has no row in workflow/repos/REGISTRY.md. _(triage: accepted, FIXED - ran refresh-repository-registry.ps1, repo now registered; see triage/2026-08-01-triage.md)_


