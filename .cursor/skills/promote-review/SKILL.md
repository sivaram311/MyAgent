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
4. `E:\MyAgent\workflow\deps\README.md`
5. `E:\MyAgent\workflow\promote\gates.md`

## Goal

Ensure the candidate build complies with machine rules and is reviewable vs prior release — including **dependency version docs**.

## Workflow

1. Diff against previous `H:\releases\` version when available.
2. Confirm target env mapping:
   - Q1 → F: + ports 4000–4999 + schema `preprod`
   - Q2 → G: + ports 5000–5999 + schema `prod`
3. Confirm `DEPENDENCIES.md` exists at release root with **app git tag** + upstream **version/tag** rows.
4. Flag hot-edit-to-prod, wrong schema, unreserved ports, or missing dependency version docs.
5. Write `evidence/<gate>/review/notes.md` (risks + required fixes).
6. Set `review_pass`, `ports_compliant`, `db_schema_compliant`; recommend EM set `app_git_tag_recorded` / `dependency_versions_recorded` only when accurate.
7. Append ACTIVITY-LOG row (role `review`) mentioning dependency doc status.

## Hard rules

- No GO recommendation if required compliance flags fail
- No GO recommendation if git tag / dependency versions are missing from the pack
- Do not deploy; report to EM only
- Document notes in evidence + ACTIVITY-LOG
