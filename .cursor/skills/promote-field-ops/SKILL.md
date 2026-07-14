---
name: promote-field-ops
description: >-
  Field lessons for promote crew: start.ps1 bind races, Cloudflare cache vs Zone
  Edit token, smoke versioned asset URLs, PowerShell $PID/$HOME traps, and
  serial ACTIVITY-LOG appends. Use with promote-em/ops/qa on any DEV→PREPROD→PROD
  ship, especially static UI or Spring Boot jar promotes.
---

# Promote — Field Ops (crew skill)

## When to load

Hire this skill alongside **promote-em**, **promote-ops**, and **promote-qa** for every promote. Mandatory when:

- Shipping **static JS/CSS** behind Cloudflare
- Restarting apps via **`start.ps1`** with a short sleep
- Running **parallel** promote subagents that log to ACTIVITY-LOG

## Source of truth

Read and follow: **`E:\MyAgent\workflow\promote\field-lessons.md`**

## Non-negotiables (summary)

1. **Bind race** — Poll the port 30–60s; launcher “Failed to bind” is not final if the process is still starting.
2. **CF cache** — Zone Edit token may not purge. Use **`?v=<release>`** (or hash) on asset URLs in DYNAMIC HTML; document purge failure; don’t block GO solely on purge API.
3. **Smoke the real href** — Test the asset URL from HTML (versioned), not only the bare `/js/app.js` path (may still be HIT/stale).
4. **PowerShell** — Never assign `$PID` or `$HOME`; use `$procId` / `$page` / `$appHome`.
5. **ACTIVITY-LOG** — Serialize appends or let EM batch-write; verify table header after parallel crew.

## Role hooks

| Role | Extra duty from this skill |
|------|----------------------------|
| **promote-ops** | Longer port poll; cache-bust in release notes; record CF purge attempt/fail; avoid reserved PS vars in one-liners |
| **promote-qa** | Assert HTML contains version query; `node --check` (or equivalent) on **served** versioned JS; note `CF-Cache-Status` |
| **promote-em** | Do not NO-GO only because purge API failed if cache-bust + versioned smoke PASS; fix ACTIVITY-LOG if crew scrambled it |

## Evidence

Cite `field-lessons.md` in `ops/deploy-log.md` or `qa/results.md` when any lesson applied (bind race, purge fail, cache-bust).
