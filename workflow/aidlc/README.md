# AI-DLC + autonomous operations — decision lock

**Status:** Phase 0 (decision lock) — no orchestrator, gateway, or write-autonomy exists yet.
**Authored:** 2026-07-31, session `claude-code`, after independent consultation with `agy` (Antigravity CLI), Cursor CLI (`auto` model), and Grok (`grok-4.20` via xAI API).
**Rule:** `workflow/CONSCIOUS.md` #23.

## Goal (reframed)

The user's ask was "make this machine completely AI-managed" and "build every app —
existing and new — on an AI-DLC lifecycle." Read literally, "completely AI-managed"
collides with existing human-custody rules (#9 promote GO, #17 push sign-off, trading
fail-closed). The precise goal this doc commits to instead:

> **AI runs the routine work end-to-end. A small, permanent, technically-enforced
> exception list stays human-only forever.** Autonomy expands only inside that
> boundary, and only as measured trust — never by declaration.

This is not "remove humans." It is "human moves from first-mover to the owner of a
short, fixed exception list, with everything else running unattended."

## Permanent gate list (never automated, never revisited by Phase 4)

Unchanged from the existing `dual-cli-subagent-workflow.md` backlog note, now made
authoritative:

- Deletes (files/folders/projects/volumes/partitions)
- Disk partitioning/formatting
- DNS record deletes
- Overwriting `G:\apps\<app>` (prod) directly (outside the promote pipeline)
- Q2 (preprod→prod) GO
- Secret/credential resets
- **`trading-portal` live execution unlock** — permanent, independent of any trust
  score. Construction-phase code changes to sizing/risk logic also always require
  human review on merge, regardless of what's unlocked elsewhere (a bad diff can
  bypass the runtime execution gate without ever touching it).

## Enforcement principle: technical, not policy-only

A rule an agent could technically violate but "shouldn't" is not a gate — it's a
suggestion. Every item on the permanent list above must eventually be backed by a
mechanism an agent cannot bypass by acting differently, not just a doc it's supposed
to read:

| Gate | Planned mechanism | Status |
|------|-------------------|--------|
| `F:`/`G:` writes | Windows ACLs restricting write access to a dedicated low-privilege agent account | **not yet applied — blocked on account-model design, see `acl-account-model-proposal.md`** |
| Protected branch/tag push | git `pre-push` hook (`workflow/aidlc/hooks/pre-push`) requiring a `SIGN-OFF*.md` with the pushed commit's SHA + a GO verdict, or a logged `MYAGENT_PUSH_OVERRIDE` | **applied to 14 repos as of 2026-08-01** via absolute `core.hooksPath` pointing at the one shared script: `E:\MyAgent` (2026-07-31, first), `stack-pilot`/`vibehub`/`mathura-portfolio` (2026-08-01), then `agent-portal`/`centralized-security-system`/`agentverse-project`/`rd-center-project`/`production-house`/`trading-portal`/`machine-sentinel`/`persistent-agent-platform`/`mt5-dev`/`agent-portal-extended` (2026-08-01, same day) — spot-verified via dry-run from `trading-portal` after rollout, correctly blocked an unsigned commit. Not yet on `boopathy-portfolio`/`h-drive-server` (no git repo) or the `sandbox/` apps (no real commits yet, out of scope until they do). |
| Secret resets / trading unlock | Agent service accounts never hold these credentials at all (not an ACL — simply absent) | **not yet applied** |
| Reviewer / EM sign-off | Must come from a session structurally distinct from the implementer (different session id, not just a different prompt in the same session) — otherwise it's self-approval | **policy only — needs orchestrator support to enforce automatically** |

`F:`/`G:` ACLs need a real account-model decision before they can mean anything —
today Claude Code, Cursor CLI, and Antigravity CLI all run as the same `Administrator`
account the human uses interactively, so there is no "agent" identity to restrict yet.
See `acl-account-model-proposal.md` for the design under review. The push hook was
lower-risk (per-repo, reversible via `git config --unset core.hooksPath`) and is live
on the governance repo itself as a dogfood case before wider rollout.

## Blast-radius tiers

Every autonomous capability sits in exactly one tier. Moving a capability up a tier
requires the Phase-1/2 trust metrics (below) to clear a stated bar — not a vibe check.

1. **Observe-only** — read machine/app state, no proposals written anywhere.
2. **Docs/drift proposals** — writes diffs to `ACTIVITY-LOG.md` / a review queue for a human to accept; no other writes.
3. **Q1 draft** — assembles a Q1 evidence pack / checklist; still requires human GO to deploy.
4. **Q1 auto-deploy** — deploys DEV→PREPROD without a human GO, once unlocked per app family.
5. **Permanently manual** — the gate list above. Never reaches tier 4.

## Kill switch and action budget

- **Kill switch:** if `E:\MyAgent\workflow\STOP-ALL-AGENTS` exists, every autonomous
  job (any tier ≥ 2) must check for it before acting and halt if present. The file is
  not created by default — only exists when someone wants a hard stop. (Not yet wired
  into any runner, since no runner exists yet — record the contract now so Phase 1's
  runner is built to honor it from day one.)
- **Action budget (initial, conservative — tune after real data):** max 1 concurrent
  autonomous job at a time (matches the existing Playwright-slot precedent), max 5
  auto-actions/day at tier 2, 0/day at tier ≥ 3 until Phase 2.

## Bolt definition (AI-DLC unit of work)

A **Bolt** = one mergeable change + its evidence + its docs update (CONSCIOUS #12),
scoped small enough to review in one sitting. No separate ceremony beyond what the
promote pipeline already requires — a Bolt's "Inception" is the spec/ask, its
"Construction" is the diff + evidence, its "Operations" is the promote/deploy step
already defined by Q1/Q2.

## AI-DLC rollout (retrofit all existing apps — confirmed 2026-07-31)

All ~15 apps in `E:\MyWorkspace` eventually get an **Inception baseline** doc (current
state as-is — not a redesign). Written **opportunistically**, the next time that app
has real work scheduled — not as a standalone documentation sprint across all apps at
once. Sequence by blast radius when a choice exists:

1. Static Astro sites (vibehub, mathura-portfolio, boopathy-portfolio) — near-zero risk, validates the mechanics cheaply.
2. Core platform (agent-portal, centralized-security-system).
3. 3D front-ends (agentverse-project, rd-center-project, production-house), erpnext.
4. `trading-portal` last — mandatory human review on every Construction merge regardless of tier elsewhere.

## Explicit non-goals (next 90 days)

- No unattended Q1 deploy (tier 4) for any app.
- No simultaneous 15-app Inception-baseline sprint.
- No change to the permanent gate list.
- No `machine-gateway` or `stack-pilot` cockpit build-out until Phase 1's read-only loop has a real track record.

## New projects started AI-DLC-native (not a retrofit)

Unlike the retrofit baselines above (as-is snapshots of pre-existing apps),
these projects started their AI-DLC lifecycle from Inception on day one —
`docs/aidlc/INCEPTION.md` is a forward-looking charter, not an as-is capture.

- **`cineforge`** (started 2026-08-01) — movie-generation pipeline orchestrating
  RunPod Serverless (ComfyUI / WAN 2.6 video models) via RunPod's official MCP
  server + REST API. Repo: `github.com/sivaram311/cineforge` (public).
  DEV ports reserved: `:3400` (api), `:3401` (future UI), `:3402` (future
  worker) — none bound yet. Inception charter + 8-Bolt Construction backlog +
  a non-functional skeleton (Python RunPod REST client, CLI, mocked unit
  tests) landed in the root commit, produced by 2 parallel `cursor-agent
  --force` scaffold hires (docs workstream + code workstream, non-overlapping
  file sets) per the user's standing delegation preference. Pushed after
  Reviewer GO (`workflow/review/evidence/2026-08-01-cineforge-first-push-SIGN-OFF.md`).
  CSS auth integration explicitly deferred as an open decision (Bolt 8) —
  not silently waived. Next: pick up Bolt 1 from `docs/aidlc/BOLTS.md` in
  that repo when Construction starts.

## Phase roadmap (for the next session picking this up)

- **Phase 0 (this doc)** — decision lock. Done 2026-07-31.
- **Phase 1** — read-only observe/drift-reconcile loop only (machine-sentinel +
  registry/doc drift → proposals in `ACTIVITY-LOG.md`). Run 2+ weeks, measure
  detection latency (MTTD) and false-positive rate before Phase 2. No orchestrator,
  gateway, or cockpit yet — a manually-scheduled single job runner is enough.
  **Started 2026-07-31** — see `phase1/README.md`. Ports + repos registry checks
  built and run once (18 findings, real drift found: unregistered port 3360 /
  `rd-center-project`, missing repo registry row for `mathura-portfolio`).
  **Scheduled 2026-07-31** — Windows Task Scheduler `MyAgent-AIDLC-Phase1-DriftReconcile`,
  daily 03:15, verified end-to-end (`LastTaskResult 0`, real report file produced).
  DB/CSS/deps drift checks and MTTD measurement not built yet. First two findings
  (port 3360, `mathura-portfolio` repo row) left for the user to triage directly
  in `phase1/REVIEW-QUEUE.md` — not auto-fixed.
- **Phase 2** — write-capable role workers (docs/qa/security/review) assemble
  evidence, but Q1 GO stays human until Phase 1 metrics clear a bar (to be set when
  Phase 1 data exists). Build `machine-gateway` + `stack-pilot` surfacing only now.
  **Started 2026-08-01** on explicit user go-ahead (mandatory human sign-off
  before any applied write; agents never get trade-execution/secret-reset
  credentials; Phase 1 metrics gate auto-deploy - now quantified, see
  `phase2/README.md`). v0 = a propose -> sign-off -> apply pipeline
  (`phase2/propose-repo-registry-refresh.ps1` + `apply-proposal.ps1`), tested
  end-to-end including a real application. Found and fixed two real bugs
  while building it: a BOM-encoding issue in the official repo-registry
  refresh script, and a GO/NO-GO detection flaw in the Phase 0 pre-push hook.
  No auto-deploy (tier 4) exists or is scheduled - that stays gated on the
  quantified Phase 1 bar, not close to met yet (~1 day of track record).
  **Extended 2026-08-01** to the four remaining role workers (docs, qa,
  security, review), all tested with real runs. Researched (not blindly
  built) `machine-gateway` + `stack-pilot`: machine-gateway's real
  implementation already exists, merged and live inside `agent-portal`
  (`/api/machine/*`) - nothing to build there. `stack-pilot` wiring was
  designed (a new controller reading MyAgent's AI-DLC files directly, matching
  its existing local-state-reading pattern) but deliberately not implemented -
  it's a live Spring Boot service and warrants its own build/test/review pass,
  not a rushed patch. Auto-deploy remains unbuilt by design - see
  `phase2/README.md`'s "Auto-deploy (tier 4)" section for the full reasoning
  and the recorded trigger condition for when to revisit it.
- **Phase 3** — AI-DLC Inception baselines land opportunistically per the sequence
  above. **Extended 2026-08-01** to all 4 `sandbox/` apps (proddeck, library,
  mindmap, forgecity-launcher) — every app in `E:\MyWorkspace` with a git repo
  and real content now has an Inception baseline, 17 total, **all pushed to
  GitHub** (sandbox 4 pushed 2026-08-01 after Reviewer GO per CONSCIOUS #17,
  see `workflow\review\evidence\2026-08-01-sandbox-baselines-push-SIGN-OFF.md`).
  **Extended 2026-08-04**: `h-drive-server` and `boopathy-portfolio` (baseline
  docs existed since 2026-08-01 but had no git repo at all) got `git init` + a
  first local commit, then — once the user fixed the broken `gh auth` token
  (see Phase 1 finding below) — new public GitHub repos were created via
  `gh repo create --source=. --push` and the baseline commits pushed
  (`boopathy-portfolio`@`29f1394`, `h-drive-server`@`93513c1`), closing this
  gap entirely: all apps with real content in `E:\MyWorkspace` now have both a
  GitHub repo and a pushed Inception baseline. Scope also widened past
  `E:\MyWorkspace` for the first time: `E:\Source\stack-pilot` and
  `E:\Source\Deployment` are real active repos that were never in scope only
  because Phase 3 was originally worded as "every app in `E:\MyWorkspace`" —
  both now have Inception baselines too (local commits, not pushed).
  `machine-gateway` (has a git repo, was previously undocumented) got an
  investigation-baseline that independently re-confirmed the Phase 2 claim
  below: it's docs/idea-only, the real `/api/machine/*` implementation lives
  in `agent-portal` — no deletion/deprecation recommended, that stays a human
  call. `erpnext` remains explicitly excluded (vendored third-party code).
  `raga-by-revenge` (new 2026-08-02, reference-image scaffold only, no code,
  no git repo) is deliberately **not** baselined yet — there's no as-is state
  to document.
- **Phase 4** — narrow gates above the permanent list, per app family, by measured
  trust only. **Readiness-check tooling built 2026-08-01** (`workflow/aidlc/phase4/check-readiness.ps1`)
  on explicit user request, explicitly scoped to reporting only - no
  auto-deploy/tier-4 mechanism code exists or was built. First real check:
  NOT READY, 1/14 consecutive scheduled Phase 1 days. Required adding
  trigger-source tagging (`scheduled` vs `manual`) to Phase 1's own
  `drift-reconcile.ps1` so the bar only counts real unattended runs, not
  test invocations - see `phase4/README.md` for the two real bugs found and
  fixed while building this (a disabled Windows event log assumption, and a
  PowerShell scalar-vs-array `.Count` gotcha).

## Sources

- User ask, this session (2026-07-31).
- `E:\MyAgent\ideas\dual-cli-subagent-workflow.md` (existing backlog, human-gates list origin).
- Independent consultations: `agy` (Windows ACL / signed-push-hook enforcement, flagged file-lock/build-race risk), Cursor CLI `auto` (decision-lock framing, blast-radius tiers, kill switch/budget, Reviewer/EM separation, disagreed with building orchestrator/gateway early), Grok `grok-4.20` via xAI API (recursive self-governance risk, immutable evidence trail before orchestrator code, trust-scored gate narrowing).
