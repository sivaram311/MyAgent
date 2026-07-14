# Git release management (promote / prod)

**Status:** Recommended standing model (Grok consult 2026-07-15, `cursor-grok-4.5-high`)  
**Audience:** Crew leads, promote-em, ops, any agent cutting a release  
**Related:** `workflow/CONSCIOUS.md` (#9, #13), `workflow/promote/`, `workflow/deps/`, `workflow/activity/`

---

## Core model

| Concern | Where |
|--------|--------|
| Code history | App repo: `main` + short-lived `feature/*` |
| “This bits = this version” | Annotated tag `vX.Y.Z` (or fleet-prefixed — see tagging) |
| “What is live on F:/G:” | `workflow/deps/DEPENDENCY-MATRIX.md` (+ `DEPENDENCIES.json`) — **mutable SoT** |
| Evidence / GO / smoke | `H:\releases\<app>-<ver>\` — **not** git history |
| Deploy secrets / bakefile env | Outside git (env roots + local secrets) |
| Promote event | ACTIVITY-LOG + pack CHECKLIST / SUMMARY |

**One rule:** a tag never means “live on prod.” A matrix row does. A tag means “this tree was cut for a release pack.”

Git owns **immutable release identity**. MyAgent + `H:\releases` own **what is live and how it got there**. Do **not** encode E / F / G in branches.

---

## 1) Branch strategy

### Keep

- **`main`** (migrate `master` → `main` once per repo when practical; don’t dual-default forever) — only integration line that may receive release tags.
- **`feature/<slug>`** — work branches; delete after merge. Fork from the **stable tag you intend to extend** (not a random side branch).

### Use sparingly

- **`release/X.Y.Z`** — only when you need a short stabilization window (multi-day Q1/Q2, hotfix cherry-picks). Create from the intended tag commit; delete or leave frozen after ship. Not a permanent env.

### Avoid

- **`dev` / `preprod` / `prod` / `f` / `g` branches** — envs are drives + ports. Env branches diverge from reality; agents will “promote” by merging lies.
- Long-lived “stable-v2” *as the only truth* — fine as a **side fleet app id + ports**, but the git line should still merge to `main` (or tag from a clear tip) so you don’t get two eternal histories.

### Side fleets (`css-next`, `agentverse-upgrade`, …)

Prefer **separate app id + ports + release packs** over eternal parallel default branches. A long `feature/css-next` is OK while incubating; once tagged and live as its own app id, treat further work as normal feature → `main` (or keep one named line only if classic and next truly cannot share history — then two repos or two clear tag namespaces, not `prod` branches).

---

## 2) Tagging conventions

### Default (one primary product per repo)

- Annotated only:  
  `git tag -a v0.2.0 -m "css-next 0.2.0 — OAuth SSO side fleet"`
- Semver: `MAJOR.MINOR.PATCH` (+ optional prerelease for experimental packs only)
- Tag **after** the commit is what you will copy to H:, **before** Q1 (or at pack cut — same SHA in `DEPENDENCIES.md`)
- Never move tags; never retag “what’s on G:”

### Side fleets in the same repo

- Prefer **app-family in the release id**, not weird tags: packs `css-0.1.0` vs `css-next-0.2.0`, both tagged `v0.1.0` / `v0.2.0` on the same repo if the tree is linear.
- If classic and next share one repo but diverge long-term, use **fleet-qualified tags**: `css/v0.1.0`, `css-next/v0.2.0` (or `v0.1.0+css` / `v0.2.0+css-next`) so agents don’t assume “latest `v*` = prod IdP.”
- Matrix always names **app id + tag**; tag alone is never enough for CSS.

### Do not

- Lightweight tags for promotes
- `prod`, `live`, `current` tags
- Tagging every WIP commit

---

## 3) What belongs in git vs outside git

| In git (app or MyAgent) | Outside git |
|-------------------------|-------------|
| Source, tests, `docs/OPS.md` / DEPLOY *templates* | Real `.env*`, JWT keys, Cloudflare tokens |
| Port / schema / `clientId` **registries** (MyAgent) | Live F:/G: runtime trees |
| Dependency **policy** + matrix (MyAgent) | Full `H:\releases\*\evidence\` screenshots, jars, zips |
| Per-release DEPENDENCIES **template** | Per-release filled `DEPENDENCIES.md` on H: (canonical for that ship) |
| Nginx *example* confs if useful | Env-specific nginx live confs on the machine |
| Bake / start scripts **without secrets** | Bakefile / env files with real passwords |

**Pragmatic split:** commit a one-line pointer in app docs (“live pins: MyAgent `workflow/deps/`”) — do **not** duplicate the full live matrix into every app repo (it will rot). H: packs stay the promote artifact; MyAgent matrix is the machine-wide “what’s live.”

---

## 4) Recording what is live on F:/G: without lying in git

| Layer | Meaning |
|-------|---------|
| **Immutable (git)** | Tag + commit SHA = “these bits existed.” |
| **Mutable (MyAgent)** | `DEPENDENCY-MATRIX.md` / `DEPENDENCIES.json` = “these bits are running now.” |
| **Event log** | ACTIVITY-LOG + H: SUMMARY = “on date X we cut over after GO.” |

Update the matrix **only after** successful deploy. Do not commit “deployed to prod” into the app repo as a merge to a `prod` branch.

Optional (lightweight): a small `LIVE.json` next to the matrix with `{ appId, env, version, tag, sha, pack, updatedAt, sessionId }` — still mutable docs, not a git tag rewrite.

If someone asks “what was on G: last month?” → archive zip on `C:\backup\releases\` + ACTIVITY-LOG + matrix git history in **MyAgent**, not app `main` archaeology.

---

## 5) Hotfix / rollback / parallel fleets

### Hotfix

1. Branch `hotfix/vX.Y.Z+1` from the **live** tag (matrix says which).
2. Fix → merge to `main` → tag `vX.Y.(Z+1)`.
3. Normal Q1/Q2 (or documented emergency GO with same evidence bar, thinner tests OK if human says so — still tag + DEPENDENCIES + matrix).

### Rollback

- Ops rolls **filesystem** on F:/G: to previous pack (kept on H: because “live or last 3”).
- Point matrix back to previous version/tag.
- Do **not** delete the failed tag; add ACTIVITY-LOG “rolled back G: app X from vA to vB.”
- Git rollback = redeploy old tag, not `git push --force` on `main`.

### Parallel fleets (classic CSS + css-next)

- Separate **app ids**, ports, hostnames, release packs.
- Consumers pin **which** upstream in DEPENDENCIES (`css` vs `css-next`) — never “CSS” without id.
- Cutover classic → next is a **consumer promote** (new app pin), not rewriting CSS history.
- Keep classic live until matrix shows zero consumers (or explicit waive).

---

## 6) Minimal process (agent + human)

Per ship, only this:

1. Feature → PR/merge → `main` (or documented integration tip)
2. **DEV** build + smoke on `:3xxx`
3. **DEV E2E** Device Lab (visual: Realme + desktop + tablet) against **DEV URL** — claim/release Playwright slot (CONSCIOUS **#14/#15/#16**). Staging/prod browser runs are optional cutover checks, not the first gate.
4. Hire **readonly Reviewer** → write `SIGN-OFF.md` with **GO** (CONSCIOUS **#17**, `workflow/review/REVIEWER-SIGNOFF.md`) **before any `git push`** of the branch tip or tag
5. Hire **`git-release`** (`.cursor/skills/git-release/SKILL.md`) → annotated `git tag -a vX.Y.Z` → push branch+tag only after Reviewer GO (tag SHA = pack SHA)
6. Build pack → `H:\releases\<app>-<ver>\` + fill DEPENDENCIES (app tag + CSS/deps) + keep Reviewer SIGN-OFF under `evidence/review/`
7. promote-em Q1/Q2 → GO
8. Ops deploy F: then G:
9. Update matrix + ACTIVITY-LOG
10. Done

No release trains, no env PRs, no GitOps controllers, no required `release/*` for every patch.

**Hire order:** e2e lanes (author) → Playwright slot holder (run on DEV) → **Reviewer SIGN-OFF** → **`git-release`** (tag + push) → pack → promote crew.

---

## Optional alternatives (only if pain appears)

| If… | Then… |
|-----|--------|
| Many cherry-picks during Q1 | Temporary `release/X.Y.Z`, delete after Q2 |
| Classic vs next cannot share `main` | Fleet-qualified tags or split repo; still no env branches |
| Auditors want signed provenance | Signed annotated tags + keep H: packs; still no prod branch |
| Matrix edit conflicts | Single “deps keeper” agent per promote; serial append (ACTIVITY-LOG races taught this) |

---

## Anti-patterns for this machine

1. **Env branches (`prod` / `preprod`)** — duplicates F:/G: poorly; agents will merge instead of promote.
2. **Tag = live** — moving `v-prod` or retagging after deploy falsifies history.
3. **Committing H: evidence into app git** — huge binaries, secrets risk, wrong SoT.
4. **Promoting untagged SHAs as normal** — escape hatch OK; don’t make it the habit.
5. **One repo tag namespace with two live fleets and no app-id in the matrix** — “latest CSS tag” ambiguity.
6. **Long-lived feature branch as prod** without tagging/matrix.
7. **GitOps / Argo / env PRs** — EM GO + drive layout already exist; sync controllers are theater.
8. **Rewriting `main` to match G:** after hotfix — deploy the hotfix tag; leave history linear.
9. **Secrets or bakefile passwords in git** — ever.
10. **Treating MyAgent matrix as optional** — without it, git only knows what *could* run, not what *does*.
11. **Tagging before DEV E2E** on UI apps — browser truth belongs on DEV first; do not tag from “works on staging smoke only.”
12. **Running Playwright without the machine slot** — CONSCIOUS **#15**.

---

## Bottom line

Treat git as a versioned parts catalog (`main` + annotated `v*` tags + short features). Treat MyAgent deps + H: packs + ACTIVITY-LOG as the flight recorder for F:/G:. That matches CONSCIOUS **#13/#16** and side fleets (`css` / `css-next`) — stop short of encoding environments in branches. Hire **`git-release`** for the tag step after DEV E2E.
