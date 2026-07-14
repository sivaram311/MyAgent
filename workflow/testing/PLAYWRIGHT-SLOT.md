# Playwright run slot (machine-wide)

**Status:** standing order · user-directed 2026-07-15  
**Why:** Multiple concurrent Playwright browsers crush this host. Agents must **register before** any Playwright run and **confirm/release after**.

**SoT state file:** [`playwright-slot.json`](./playwright-slot.json)  
**Helpers:** [`scripts/claim-playwright-slot.ps1`](./scripts/claim-playwright-slot.ps1) · [`scripts/release-playwright-slot.ps1`](./scripts/release-playwright-slot.ps1)

Related: [E2E-HIRE.md](./E2E-HIRE.md) (CONSCIOUS **#14**) · this slot is CONSCIOUS **#15**.

---

## Rule

1. **Before** `npx playwright …`, `npm run test:e2e*`, or any browser E2E runner: **claim** the slot.  
2. If the slot is held by someone else → **wait or skip** (do not start a second instance).  
3. **After** tests finish (pass/fail/abort): **release** the slot and write confirmation (`releasedAt`, `result`).  
4. Stale holds (>45 minutes, or holder process gone) may be **force-released** by Crew Lead only — log in ACTIVITY-LOG.

Writing/editing `e2e/**` specs does **not** require the slot. Only **running** Playwright does.

Device Lab: hire lanes may author specs in parallel; **one** registered holder runs projects (sequentially or single `playwright test` invocation).

---

## Claim

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File E:\MyAgent\workflow\testing\scripts\claim-playwright-slot.ps1 `
  -SessionId "your-session-id" `
  -Provider cursor `
  -AppId proddeck `
  -Project "realme-p2-pro" `
  -AgentRole e2e-realme
```

Exit **0** → you hold the slot (JSON printed).  
Exit **2** → busy — read holder fields; do not run Playwright.

## Release (required after run)

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File E:\MyAgent\workflow\testing\scripts\release-playwright-slot.ps1 `
  -SessionId "your-session-id" `
  -Result "pass|fail|aborted" `
  -Notes "optional"
```

Optional `-Force` only for Lead clearing a stale lock (document why).

---

## State shape (`playwright-slot.json`)

| Field | Meaning |
|-------|---------|
| `status` | `free` \| `held` |
| `holder.sessionId` | Who claimed |
| `holder.provider` | cursor / antigravity / other |
| `holder.appId` | App under test |
| `holder.project` | Playwright project or `all` |
| `holder.agentRole` | e.g. e2e-realme / lead |
| `holder.claimedAt` | ISO time |
| `holder.pid` | Optional claimer PID |
| `lastRelease.*` | Last confirmation after a run |

---

## ACTIVITY-LOG

Optional but preferred: when claim blocked or force-released, log role `qa+e2e` with note `playwright-slot busy|force-release`.
