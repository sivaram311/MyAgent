# SIGN-OFF — production-house PREPROD Session-0 autostart fix (deployment + stack-pilot)

| Field | Value |
|-------|-------|
| Session | claude-code, this session |
| Reviewer agent id | `cursor-agent -p --model auto --mode ask --trust` (readonly) |
| Provider | cursor |
| Repo 1 | `E:\Source\Deployment` — github.com/sivaram311/deployment — branch `main` — tip `37c85f3` |
| Repo 2 | `E:\Source\stack-pilot` — github.com/sivaram311/stack-pilot — branch `main` — tip `f512d79` |
| When (IST) | 2026-08-06 |
| Scope | 1 commit ahead per repo; PREPROD-only follow-up to the 2026-08-05 PROD fix; no tags, no release/APK |

## Checklist

- [x] Docs updated same turn (CONSCIOUS #12) — `docs/rdp-session0-durable-runtime.md` PREPROD coverage note + ports `REGISTRY.md` note (MyAgent, local commit only)
- [x] No secrets in either ahead diff — confirmed by readonly reviewer against `origin/main..HEAD` on both repos
- [x] Fleet splits OK — additive only; PROD `:5370` task from yesterday untouched (SKIP'd as already-listening on this run)
- [x] DEV E2E green if this push includes a release tag (#16) — N/A, no tag
- [x] Login E2E used DEV public domain when host exists (#18) — N/A
- [x] Tag ≠ live understood — N/A
- [x] Both working trees confirmed dirty with unrelated in-flight files (nginx confs, `agents/`, pre-existing `css-next-prod-s0.cmd` regen) — none staged; `git diff origin/main..HEAD` on each repo reflects only the intended 1 commit

## Verdict

**GO** for `git push origin main` on both `deployment` and `stack-pilot`.

### Findings

- Independent reviewer ran `git diff`/`git log origin/main..HEAD` itself on both repos and reported the exact tip SHAs and file scope claimed (`37c85f3`, `f512d79`).
- `deployment` diff confirmed as exactly: new `StackPilot-S0-ProductionHouse-Preprod` AtStartup task registration in `register-s0-app-tasks.ps1`, new `scripts/s0-apps/ph-preprod-s0.cmd` launcher, matching `Write-ViteLauncher` + port-4370 entry in `start-fleet-session0.ps1`. No command-injection risk — launcher only `cd`s to `F:\apps\production-house` and runs its existing `start.ps1`.
- `stack-pilot` diff confirmed as docs-only: PREPROD coverage note + `:4370` added to the verify-durability loop.
- No secrets/credentials in either diff.
- Live-verified before this SIGN-OFF: loopback `:4370` → 200, nginx by `Host: production-house-staging.delena.buzz` → 200, public `https://production-house-staging.delena.buzz/` → 200 with real Production House HTML body, process `session=0` confirming durability.
- Direct mirror of yesterday's PROD fix (`2026-08-05-production-house-session0-autostart-SIGN-OFF.md`); user explicitly requested this PREPROD follow-up.

### Conditions

- Push **exactly** the two reviewed tips: `deployment` `37c85f3`, `stack-pilot` `f512d79`. Do not `git add -A` in either repo.
- ACTIVITY-LOG entry required after push (CONSCIOUS #12).
- `stack-pilot` has a technically-enforced pre-push hook (`core.hooksPath`) requiring an in-repo `SIGN-OFF*.md` with a standalone `**GO**` line referencing the tip SHA — this evidence file alone (outside the repo) will not satisfy it; a matching in-repo copy must be placed under `agents/` before push, per the 2026-08-05 precedent.
