---
name: e2e-hire
description: >-
  Hire E2E testing subagents when an application is built or UI/API changes
  (CONSCIOUS #14). Visual apps need parallel Realme P2 Pro, desktop, and tablet
  Playwright lanes. Use when shipping apps, UI work, or promote prep.
---

# E2E hire (mandatory)

## SoT

- `E:\MyAgent\workflow\testing\E2E-HIRE.md`
- Devices: `E:\MyAgent\workflow\devices\` (do not web-search)

## Checklist

1. Open hire note under app `agents/hires/` with lanes: `e2e-realme`, `e2e-desktop`, `e2e-tablet` (or `e2e-api`).
2. Lead owns `playwright.config.ts` + `e2e/fixtures/devices.ts` mirroring PRIMARY.json.
3. Parallel subagents own disjoint folders: `e2e/realme/**`, `e2e/desktop/**`, `e2e/tablet/**`.
4. Run against DEV or public staging URL; do not cut over F/G unless EM GO.
5. Evidence → `docs/E2E.md` and/or `H:\releases\<app>-<ver>\evidence\e2e\`.
6. ACTIVITY-LOG row(s) with role `qa+e2e`.

## Viewport presets

| Project | Size |
|---------|------|
| realme-p2-pro | 360×780 |
| desktop-1280 | 1280×800 |
| tablet-pad2-approx | 800×1280 |

Missing hired E2E on a UI ship → incomplete / not promote-ready.
