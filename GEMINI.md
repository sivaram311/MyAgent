# MyAgent standing orders (Antigravity / Gemini)

**Applies to Antigravity (`agy`) and any Gemini CLI agent on this machine.**

Source of truth (always prefer these over chat memory):

| Path | Purpose |
|------|---------|
| `E:\MyAgent\AGENTS.md` | Entry point for all providers |
| `E:\MyAgent\workflow\CONSCIOUS.md` | Non-negotiable standing orders |
| `E:\MyAgent\workflow\activity\ACTIVITY-LOG.md` | Mandatory activity log |
| `E:\MyAgent\workflow\ports\` | Port reservation |
| `E:\MyAgent\workflow\db\` | Postgres schema-per-env |
| `E:\MyAgent\workflow\css\` | Centralized Security System |
| `E:\MyAgent\workflow\promote\` | Promote evidence gates |

## Before work

1. Read `AGENTS.md` + `CONSCIOUS.md`.
2. Log actions with provider `antigravity`.
3. Honor drives: E DEV / F PREPROD / G PROD / H RELEASES.
4. No delete/partition without explicit user confirmation.
5. Update docs after meaningful changes (CONSCIOUS #12).

## Agent Portal runs

When spawned from Agent Portal, still follow MyAgent standing orders. Skip-permissions / always-proceed does **not** waive CONSCIOUS safety rules (deletes, prod overwrite, DNS delete, secret commits).
