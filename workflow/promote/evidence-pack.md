# Evidence pack

Every promote gate writes files under:

```text
H:\releases\<app-id>-<version>\
  DEPENDENCIES.md          ← mandatory (from templates/DEPENDENCIES.md)
  evidence\<q1|q2>\
    SUMMARY.md
    CHECKLIST.json
    qa\
    security\
    review\
    ops\
```

Copy starter files from `templates/` when opening a gate. **Always** copy `DEPENDENCIES.md` into the release root.

## SUMMARY.md (EM owns)

Must include:

- App id, version, gate (Q1/Q2)
- **App git tag** (or commit SHA if untagged)
- **Dependencies:** each upstream name + version + **git tag** + release id (CSS required for auth apps)
- Source env → target env + URLs
- Decision: **GO** or **NO-GO**
- Who/when (session id)
- Blockers (if NO-GO)
- Link to checklist flags
- Confirmation that `DEPENDENCIES.md` exists and matrix update planned/done

Missing git tag or dependency versions → **NO-GO**.

## CHECKLIST.json (machine gate)

All `required` items must be `true` before Ops may run. Template: `templates/CHECKLIST.json`.

EM sets `"decision": "GO"|"NO-GO"` only after specialists finish.

## Per-role folders

| Folder | Owner skill | Minimum artifacts |
|--------|-------------|-------------------|
| `qa/` | promote-qa | `results.md`, pass/fail matrix, screenshots or log paths |
| `security/` | promote-security | `checklist.md` (CSS **clientId + CSS version/tag**, CORS, secrets scan note) |
| `review/` | promote-review | `notes.md` (diff summary, ports/DB/drive compliance, **DEPENDENCIES.md** present) |
| `ops/` | promote-ops | `deploy-log.md` (commands, health curls) — only after GO; after deploy remind EM to update dependency matrix |

## Dependency recording (mandatory)

| Artifact | Owner | Minimum |
|----------|-------|---------|
| `H:\releases\<app>-<ver>\DEPENDENCIES.md` | EM (+ security fills CSS row) | App git tag + every upstream version/tag |
| `CHECKLIST.json` fields `appGitTag`, `dependencies`, flags `app_git_tag_recorded`, `dependency_versions_recorded`, `dependency_matrix_updated` | EM | All required true before GO (matrix flag may be true only after deploy on Q2; on Q1 set true when F: pin updated) |
| `workflow/deps/DEPENDENCY-MATRIX.md` + `DEPENDENCIES.json` | EM / ops closeout | Live F:/G: pins match reality |

SoT: `workflow/deps/README.md`.

## Retention

Evidence lives with the release under `H:\releases\` (last **3** releases retained on H:). Do not delete evidence without user confirmation.
