# SIGN-OFF — production-house Session-0 autostart fix (deployment + stack-pilot)

| Field | Value |
|-------|-------|
| Session | claude-code, this session |
| Reviewer agent id | `cursor-agent -p --model auto --mode ask --trust` (readonly) |
| Provider | cursor |
| Repo 1 | `E:\Source\Deployment` — github.com/sivaram311/deployment — branch `main` — tip `84a2f4e` |
| Repo 2 | `E:\Source\stack-pilot` — github.com/sivaram311/stack-pilot — branch `main` — tip `852f88f` |
| When (IST) | 2026-08-05 |
| Scope | 1 commit ahead per repo; no tags, no release/APK |

## Checklist

- [x] Docs updated same turn (CONSCIOUS #12) — `docs/rdp-session0-durable-runtime.md` coverage note + ports `REGISTRY.md` note (MyAgent, local commit only)
- [x] No secrets in either ahead diff — confirmed by readonly reviewer against `origin/main..HEAD` on both repos
- [x] Fleet splits OK — additive only; existing `StackPilot-S0-*` tasks for other apps untouched (confirmed all pre-existing ports SKIP'd as already-listening when the registration script ran)
- [x] DEV E2E green if this push includes a release tag (#16) — N/A, no tag
- [x] Login E2E used DEV public domain when host exists (#18) — N/A
- [x] Tag ≠ live understood — N/A
- [x] Both working trees confirmed dirty with unrelated in-flight files (nginx confs, `agents/`, an unrelated pre-existing `css-next-prod-s0.cmd` regen) — none of it staged; `git diff origin/main..HEAD` on each repo reflects only the intended 1 commit

## Verdict

**GO** for `git push origin main` on both `deployment` and `stack-pilot`, in that order (deployment carries the actual fix; stack-pilot docs reference it).

### Findings

- Independent reviewer ran `git diff`/`git log origin/main..HEAD` itself on both repos and reported the exact same tip SHAs (`84a2f4e`, `852f88f`) and file scope claimed here — not just echoing the prompt.
- `deployment` diff confirmed as exactly: new `StackPilot-S0-ProductionHouse-Prod` AtStartup task registration in `register-s0-app-tasks.ps1`, new `scripts/s0-apps/ph-prod-s0.cmd` generated launcher, and a matching `Write-ViteLauncher` + port-5370 entry in `start-fleet-session0.ps1`. No command-injection risk flagged — launcher only `cd`s to `G:\apps\production-house` and runs its existing `start.ps1`.
- `stack-pilot` diff confirmed as docs-only: coverage note + port `:5370` added to the verify-durability loop in `docs/rdp-session0-durable-runtime.md`.
- No secrets/credentials in either diff.
- Root cause matches the same class as the 2026-07-21 css-next/proddeck 502 (documented in the same file): app promoted to PROD but never wired into Session-0 autostart, so it only survived as long as the interactive session that started it.
- Live-verified before this SIGN-OFF (by the orchestrating session, independently of the reviewer): loopback `:5370` → 200, nginx by `Host: production-house.delena.buzz` → 200, public `https://production-house.delena.buzz/` → 200 with real Production House HTML body (not a stale/wrong-app response), process `session=0` confirming durability.

### Conditions

- Push **exactly** the two reviewed tips: `deployment` `84a2f4e`, `stack-pilot` `852f88f`. Do not `git add -A` in either repo — unrelated in-flight files must stay uncommitted.
- ACTIVITY-LOG entry required after push (CONSCIOUS #12).
- F: PREPROD (`:4370`, `production-house-staging.delena.buzz`) has the same autostart gap, left unfixed — lower priority, no public dependency, but should be picked up eventually.
