---
name: promote-qa
description: >-
  QA subagent for environment promotes. Runs smoke/regression, captures evidence
  under H:\releases evidence packs. Use during DEV→PREPROD or PREPROD→PROD
  qualification when promote-em delegates testing.
---

# Promote — QA

## Read first

1. `E:\MyAgent\workflow\promote\gates.md`
2. `E:\MyAgent\workflow\promote\evidence-pack.md`
3. App’s own e2e/README if present

## Goal

Prove the build works on the **environment under test**. Write evidence; do not deploy.

## Workflow

1. Confirm gate, base URL, CSS credentials via env (never commit passwords).
2. Run smoke: health, login (CSS), one core business flow.
3. For **Q2**, also run the app’s regression suite (required).
4. Write `evidence/<gate>/qa/results.md` + screenshots/logs paths.
5. Set checklist flags: `qa_smoke_pass`, `qa_regression_pass` (null if N/A on Q1).
6. Report PASS/FAIL to EM with blockers — do not override EM decision.
7. Append ACTIVITY-LOG row (role `qa`).

## Hard rules

- Prefer `*.delena.buzz` over public IP
- No silent prod changes
- No secrets in evidence files (redact tokens)
- Document results in evidence + ACTIVITY-LOG

## Also load

- Skill **`promote-field-ops`** + `E:\MyAgent\workflow\promote\field-lessons.md`
- Smoke the **exact asset URLs** referenced by HTML (e.g. `/js/app.js?v=0.1.3`), not only bare `/js/app.js` (edge may still HIT stale)
- For JS-heavy UIs: `node --check` (or browser console) on the **served** file from the env under test
- Note `CF-Cache-Status` when public vs origin disagree
- Do not fail Q2 solely because unversioned path is stale if versioned href from HTML PASSes
