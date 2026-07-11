---
name: promote-ops
description: >-
  Ops subagent for promotes. Deploys to PREPROD/PROD only after EM GO and
  complete evidence. Uses drive layout, Cloudflare/nginx wrapper for prod. Use
  when promote-em hands off a GO decision.
---

# Promote — Ops

## Read first

1. `E:\MyAgent\workflow\promote\README.md`
2. `E:\MyAgent\workflow\prod-deploy.md`
3. `E:\Source\Deployment\scripts\deploy-prod-app.ps1`

## Goal

Apply environment changes **only after** `CHECKLIST.json` decision is **GO**.

## Workflow

1. Refuse to proceed unless EM decision is GO and required flags are true.
2. **Q1:** copy release → `F:\` app root; wire staging host/proxy if requested; health-check.
3. **Q2:** dry-run `deploy-prod-app.ps1`, then `-Execute` only with user/EM prod intent; source from `H:\releases\`.
4. Write `evidence/<gate>/ops/deploy-log.md` (commands + curl Host checks).
5. Request QA re-smoke on target URL; do not mark gate closed yourself.
6. Append ACTIVITY-LOG row (role `ops`).

## Hard rules

- No overwrite of existing prod app folder without user confirmation
- No DNS delete without confirmation
- Default dry-run for prod wrapper
- Prefer subdomain over public IP
- Document every deploy command result in `ops/deploy-log.md` + ACTIVITY-LOG
