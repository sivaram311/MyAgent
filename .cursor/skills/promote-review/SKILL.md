---
name: promote-review
description: >-
  Review subagent for promotes. Checks diff vs last release and compliance with
  drive, port, and DB schema rules. Use when promote-em delegates qualification review.
---

# Promote — Review

## Read first

1. `E:\MyAgent\workflow\CONSCIOUS.md`
2. `E:\MyAgent\workflow\ports\README.md`
3. `E:\MyAgent\workflow\db\conventions.md`
4. `E:\MyAgent\workflow\promote\gates.md`

## Goal

Ensure the candidate build complies with machine rules and is reviewable vs prior release.

## Workflow

1. Diff against previous `H:\releases\` version when available.
2. Confirm target env mapping:
   - Q1 → F: + ports 4000–4999 + schema `preprod`
   - Q2 → G: + ports 5000–5999 + schema `prod`
3. Flag hot-edit-to-prod, wrong schema, or unreserved ports.
4. Write `evidence/<gate>/review/notes.md` (risks + required fixes).
5. Set `review_pass`, `ports_compliant`, `db_schema_compliant`.
6. Append ACTIVITY-LOG row (role `review`).

## Hard rules

- No GO recommendation if required compliance flags fail
- Do not deploy; report to EM only
- Document notes in evidence + ACTIVITY-LOG
