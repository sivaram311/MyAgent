# DB schema-per-env recommendation

**Status:** approved 2026-07-11 — documented under `workflow/db/`  
**Session:** `93d977cc-7c3b-4a37-b889-09d2e6676ed5`

## Summary

Shared Postgres (`:5432`). Each app gets database `app_<id>` with schemas **`dev` / `preprod` / `prod`** and matching roles. Env processes may only use their schema.

Full conventions: [../workflow/db/conventions.md](../workflow/db/conventions.md)
