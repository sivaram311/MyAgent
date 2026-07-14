---
name: e2e-hire
description: >-
  Hire E2E testing subagents when an application is built or UI/API changes
  (CONSCIOUS #14). Visual apps need Realme P2 Pro, desktop, and tablet
  Playwright coverage. Before running Playwright, claim the machine slot
  (CONSCIOUS #15) and release after. Use when shipping apps, UI work, or promote prep.
---

# E2E hire (mandatory)

## SoT

- Hire: `E:\MyAgent\workflow\testing\E2E-HIRE.md` (#14)
- **Run slot:** `E:\MyAgent\workflow\testing\PLAYWRIGHT-SLOT.md` (#15)
- Devices: `E:\MyAgent\workflow\devices\` (do not web-search)

## Checklist

1. Open hire note under app `agents/hires/` with lanes: `e2e-realme`, `e2e-desktop`, `e2e-tablet` (or `e2e-api`).
2. Lead owns `playwright.config.ts` + `e2e/fixtures/devices.ts` mirroring PRIMARY.json.
3. Parallel subagents may **author** disjoint folders: `e2e/realme/**`, `e2e/desktop/**`, `e2e/tablet/**`.
4. **Before any Playwright run — claim the slot** (exit 2 = busy → wait):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File E:\MyAgent\workflow\testing\scripts\claim-playwright-slot.ps1 `
  -SessionId "<session>" -Provider cursor -AppId "<app>" -Project "all" -AgentRole "e2e-lead"
```

5. **Run against DEV first** (`http://127.0.0.1:3xxx` / app DEV URL) — CONSCIOUS **#16**. Staging/prod optional later. Do not cut over F/G unless EM GO. Prefer **one** claimed run covering all projects.
6. **After the run — release with confirmation:**

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File E:\MyAgent\workflow\testing\scripts\release-playwright-slot.ps1 `
  -SessionId "<session>" -Result pass
```

7. Evidence → `docs/E2E.md` and/or `H:\releases\<app>-<ver>\evidence\e2e\`.
8. ACTIVITY-LOG row(s) with role `qa+e2e`.
9. When green on DEV and ready to ship: hire **`git-release`** for annotated tag (do not tag before this gate).

## Viewport presets

| Project | Size |
|---------|------|
| realme-p2-pro | 360×780 |
| desktop-1280 | 1280×800 |
| tablet-pad2-approx | 800×1280 |

Missing hired E2E on a UI ship → incomplete / not promote-ready.  
Running Playwright without a claim → **policy violation**.
