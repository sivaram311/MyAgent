# Evidence pack

Every promote gate writes files under:

```text
H:\releases\<app-id>-<version>\evidence\<q1|q2>\
  SUMMARY.md
  CHECKLIST.json
  qa\
  security\
  review\
  ops\
```

Copy starter files from `templates/` when opening a gate.

## SUMMARY.md (EM owns)

Must include:

- App id, version, gate (Q1/Q2)
- Source env → target env + URLs
- Decision: **GO** or **NO-GO**
- Who/when (session id)
- Blockers (if NO-GO)
- Link to checklist flags

## CHECKLIST.json (machine gate)

All `required` items must be `true` before Ops may run. Template: `templates/CHECKLIST.json`.

EM sets `"decision": "GO"|"NO-GO"` only after specialists finish.

## Per-role folders

| Folder | Owner skill | Minimum artifacts |
|--------|-------------|-------------------|
| `qa/` | promote-qa | `results.md`, pass/fail matrix, screenshots or log paths |
| `security/` | promote-security | `checklist.md` (CSS clientId, CORS, secrets scan note) |
| `review/` | promote-review | `notes.md` (diff summary, ports/DB/drive compliance) |
| `ops/` | promote-ops | `deploy-log.md` (commands, health curls) — only after GO |

## Retention

Evidence lives with the release under `H:\releases\` (last **3** releases retained on H:). Do not delete evidence without user confirmation.
