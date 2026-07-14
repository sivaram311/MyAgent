# E2E testing hire mandate (CONSCIOUS #14)

**Status:** standing order · user-directed 2026-07-15  
**SoT devices:** [`../devices/`](../devices/) (Realme P2 Pro primary — do not web-search)

## When this fires

Hire testing subagents when **any** of these happen:

- A new application is scaffolded / first built
- A meaningful UI or user-facing API surface ships or changes
- **Before** `git-release` tag / H: pack cut (CONSCIOUS **#16** — DEV E2E gate)
- A promote pack is prepared for Q1/Q2 (UI apps; destination smoke complements DEV)
- Soft-ship “done” would otherwise be claimed after coding without E2E evidence

Do **not** treat `scripts/smoke.mjs` or ad-hoc PowerShell alone as satisfying this rule for visual apps.

**Preferred base URL:** DEV. For **login / OAuth / hybrid auth**, prefer the app’s **DEV public domain** (CONSCIOUS **#18** · [DEV-HOST-E2E.md](./DEV-HOST-E2E.md)) — e.g. ProdDeck `https://home-dev.delena.buzz`.  
`http://127.0.0.1:3xxx` alone does **not** satisfy login E2E when a DEV subdomain exists. Staging/prod Playwright is optional after tag/pack/promote — not the first green.

## Required hires (visual / UI apps)

Spin **parallel** testing subagents (or one Device Lab crew with parallel lanes), covering:

| Role / lane | Viewport preset | Size | Priority |
|-------------|-----------------|------:|----------|
| `e2e-realme` | `realme-p2-pro` | **360×780** | **Primary** — must pass first for “mobile done” |
| `e2e-desktop` | `desktop-1280` | **1280×800** | Computer / desktop screen |
| `e2e-tablet` | `tablet-pad2-approx` | **800×1280** | Tablet screen |

Presets: [`../devices/VIEWPORTS.md`](../devices/VIEWPORTS.md) · numbers: [`../devices/PRIMARY.json`](../devices/PRIMARY.json).

## API-only apps

Hire at least one `e2e-api` testing subagent (contract / health / auth matrix). Visual trio optional unless a UI appears later.

## Deliverables (each hire)

1. Playwright (preferred) or equivalent project under app `e2e/`
2. Named projects matching device presets (visual apps)
3. **Login specs:** `baseURL` = DEV public hostname when present (#18); evidence names that URL
4. Evidence: app `docs/E2E.md` **and/or** `H:\releases\<app>-<ver>\evidence\e2e\`
5. ACTIVITY-LOG row with role `qa+e2e` (or per-lane), session id, result
6. Crew hire note under app `agents/hires/` (or `agents/crew-activity.md`)

## Ownership / parallelism

| Pattern | Rule |
|---------|------|
| Parallel lanes | Disjoint file ownership (`e2e/realme/**`, `e2e/tablet/**`, `e2e/desktop/**`) — **authoring** may be parallel |
| Playwright **execution** | **Serialized** — CONSCIOUS **#15** · claim → run → release · see [PLAYWRIGHT-SLOT.md](./PLAYWRIGHT-SLOT.md) |
| Lead | Owns `playwright.config.ts`, `e2e/fixtures/devices.ts`, hire GO, ACTIVITY-LOG serialize; usually **one** claim for all projects |
| No F/G cutover | Testers do not promote unless EM GO separately |

### Playwright slot (mandatory before run)

```powershell
# claim (exit 2 = busy — do not run)
E:\MyAgent\workflow\testing\scripts\claim-playwright-slot.ps1 -SessionId "..." -AppId "proddeck" -Project "all" -AgentRole "e2e-lead"
# ... run playwright ...
E:\MyAgent\workflow\testing\scripts\release-playwright-slot.ps1 -SessionId "..." -Result pass   # or fail / aborted
```

## Promote gate

UI promote CHECKLIST / SUMMARY should note E2E hire + last green run (or explicit NO-GO / waived with reason). Missing hired E2E → incomplete — do not call promote-ready.
