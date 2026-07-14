# Environment promote (DEV → PREPROD → PROD)

**Policy status:** user-approved 2026-07-11 — **keep**  
**Principle:** No promote without a complete **evidence pack** and an EM **GO**.

| Gate | From → To | Evidence root |
|------|-----------|---------------|
| **Q1** | DEV (E:) → PREPROD (F:) | `H:\releases\<app>-<version>\evidence\q1\` |
| **Q2** | PREPROD (F:) → PROD (G:) | `H:\releases\<app>-<version>\evidence\q2\` |

## Skills (subagents)

| Skill | Role |
|-------|------|
| [`promote-em`](../../.cursor/skills/promote-em/SKILL.md) | Orchestrate; GO/NO-GO only |
| [`promote-qa`](../../.cursor/skills/promote-qa/SKILL.md) | Tests + screenshots |
| [`promote-security`](../../.cursor/skills/promote-security/SKILL.md) | CSS / secrets / CORS |
| [`promote-review`](../../.cursor/skills/promote-review/SKILL.md) | Diff + rule compliance |
| [`promote-ops`](../../.cursor/skills/promote-ops/SKILL.md) | Deploy after GO only |
| [`promote-field-ops`](../../.cursor/skills/promote-field-ops/SKILL.md) | Field lessons (bind race, CF cache, PS traps, ACTIVITY-LOG) |
| [`e2e-hire`](../../.cursor/skills/e2e-hire/SKILL.md) | CONSCIOUS **#14** — hire E2E testing subagents (visual: Realme + desktop + tablet) |

## Field lessons (read on every promote)

Operational gaps found in live ships (Stack Pilot 0.1.3, 2026-07-13) live in:

**[field-lessons.md](./field-lessons.md)**

Hire **`promote-field-ops`** with the rest of the crew so these are not rediscovered under stress.

## Flow

```text
Human requests promote
  → promote-em clarifies app, version, gate (Q1|Q2)
  → spawn qa / security / review (parallel when possible)
  → write evidence under H:\releases\...\evidence\<gate>\
  → EM reads CHECKLIST.json → GO or NO-GO
  → on GO only: promote-ops moves bits / DNS / nginx
  → QA re-smoke on destination env
  → EM closes SUMMARY.md
```

## Related machine rules

- Drives: `workflow/CONSCIOUS.md`
- Ports: `workflow/ports/`
- DB schemas: `workflow/db/`
- CSS: `workflow/css/`
- **Dependency versions / git tags:** `workflow/deps/` (**mandatory** on every promote)
- **E2E testing hires:** `workflow/testing/E2E-HIRE.md` (CONSCIOUS **#14** — UI apps)
- Prod wrapper: `workflow/prod-deploy.md`
- Evidence format: [evidence-pack.md](./evidence-pack.md)
- Gate bars: [gates.md](./gates.md)
- Release archive: [release-archive.md](./release-archive.md)
- Per-release deps template: [templates/DEPENDENCIES.md](./templates/DEPENDENCIES.md)

## Release retention & archive (H:)

**H:`RELEASES` is handoff storage, not a runtime.** Apps execute on **F:** / **G:**.

| Rule | Detail |
|------|--------|
| Keep on H: | Last **3** releases **per app family**, plus any version **live on F: or G:** |
| Archive | Older folders → `C:\backup\releases\<release-id>.zip` (GDrive-synced) |
| Zip excludes | All `node_modules`; all `.env*` (no secrets to cloud) |
| Deps on deploy | After copy/restore to F:/G:: `npm ci` in the app root (Node apps); then `start.ps1` |
| Prune | Delete from H: only after zip verify + user confirmation (or explicit GO that includes prune) |

Full SOP: [release-archive.md](./release-archive.md) · Drive purpose: `H:\PURPOSE.md`

## Forbidden

- Promote with missing or failing required checklist flags
- Ops deploy before EM GO
- Pointing prod DNS at DEV `ng serve`
- Using wrong DB schema for the target env
- Skipping CSS `clientId` / JWKS validation for apps that need auth
- Promoting without **app git tag** (or commit) and **dependency versions/tags** recorded (`DEPENDENCIES.md` + CHECKLIST)
- Undocumented agent/subagent work (must log ACTIVITY-LOG + evidence)
- Treating H: as a runtime or leaving unbounded release trees on H: (use retention + archive)
