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
- Prod wrapper: `workflow/prod-deploy.md`
- Evidence format: [evidence-pack.md](./evidence-pack.md)
- Gate bars: [gates.md](./gates.md)

## Forbidden

- Promote with missing or failing required checklist flags
- Ops deploy before EM GO
- Pointing prod DNS at DEV `ng serve`
- Using wrong DB schema for the target env
- Skipping CSS `clientId` / JWKS validation for apps that need auth
- Undocumented agent/subagent work (must log ACTIVITY-LOG + evidence)
