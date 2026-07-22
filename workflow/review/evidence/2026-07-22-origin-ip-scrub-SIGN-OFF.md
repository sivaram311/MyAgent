# Reviewer SIGN-OFF — Origin IP scrub (4 PUBLIC repos)

_MyAgent standing rule #17: Reviewer SIGN-OFF before any git push. READ-ONLY review._

| Field | Value |
|-------|-------|
| Session | `origin-ip-scrub-2026-07-22` |
| Reviewer | Reviewer (git push gate) |
| Provider | cursor |
| Scope | Tip working-tree scrub of VPS origin IP `103.118.183.185` (Cloudflare-bypass risk) |
| Repos | MyAgent `E:\MyAgent` @ `1307685`; MyMachine `E:\MyWorkspace\MyMachine` @ `33d232e`; agent-portal `E:\MyWorkspace\agent-portal` @ `69e0bc7`; stack-pilot-android `E:\Source\stack-pilot-android` @ `f316791` |
| When | 2026-07-22 10:12 (UTC+5:30) — **re-review after blocker fix** |
| Prior verdict | NO-GO (REGISTRY.md sweep-in + agent-portal `CURSOR_MODEL` hunk) |

## Verdict

**GO** — safe to commit and push the staged tip scrubs for all four PUBLIC repos.

## Checklist

- [x] **No origin IP on added (`+`) lines** — for all four repos, `git diff --cached | Select-String '^\+.*103\.118\.183\.185'` is **empty**. Removals (`-`) of the IP are present and expected.
- [x] **Scope: redaction-only staging** — prior blockers cleared on re-review:
  - MyAgent `REGISTRY.md`: HEAD restore + only `:4081` IP→`<ORIGIN_IP>` (plus harmless BOM strip on line 1).
  - agent-portal `.env.docker.example`: HEAD restore + only `PUBLIC_HOST=<ORIGIN_IP>` (`CURSOR_MODEL` gone).
  - Unrelated dirty trees remain unstaged in MyAgent / agent-portal.
- [x] **No secrets introduced** — no new tokens/passwords/keys. Pre-existing example `POSTGRES_PASSWORD=agent` / empty `CURSOR_API_KEY=` unchanged.
- [x] **Android default hostname** — `defaultServerUrl` / `hintText` / docs → `http://control.delena.buzz` (not a broken `<ORIGIN_IP>` URL).
- [x] **History note (non-blocking)** — tip scrub only; git *history* still contains the IP until a separate filter-repo rewrite.

## Findings

### Blocking

**None** (re-review).

### Prior blockers — resolved

1. ~~MyAgent `REGISTRY.md` port-row sweep-in + mojibake~~ → restored; staged diff is IP redaction on `:4081` only (+ UTF-8 BOM removal on `# Port registry…` header — **non-material**, do not block).
2. ~~agent-portal `CURSOR_MODEL=auto`~~ → removed; staged `.env.docker.example` is `PUBLIC_HOST` only.

### Verified clean

| Repo | Tip | Staged | Result |
|------|-----|--------|--------|
| **MyAgent** | `1307685` | `ACTIVITY-LOG.md`, `ports/REGISTRY.md`, 2 prior SIGN-OFF evidence files | IP→`<ORIGIN_IP>`; session bookkeeping row; no `+` IP. |
| **MyMachine** | `33d232e` | 116 files (147+/147−) | Text→`<ORIGIN_IP>`; binary `.db`/`.db-wal` same-size; samples `no_ip` + `HAS_XXX`; no `+` IP. |
| **agent-portal** | `69e0bc7` | 5 files (skill, `.env.docker.example`, DELENA-PROXY, MACHINE-GATEWAY, e2e README) | Redaction / hostname preference only. |
| **stack-pilot-android** | `f316791` | 4 files | Default/docs/hint → `http://control.delena.buzz`. |

### Informational (non-blocking)

- MyAgent prior SIGN-OFF evidence still has a slightly contradictory `git grep "<ORIGIN_IP>"` wording after placeholder substitution — cosmetic.
- MyMachine mirrors of android docs may keep `http://<ORIGIN_IP>:8091` as placeholder policy; live android repo uses hostname — acceptable.
- UTF-8 BOM strip on MyAgent `REGISTRY.md` first line is harmless.

## Conditions

1. Commit **only** the currently staged sets reviewed here; do not add unrelated dirty files before push.
2. After commit, push the new tips; if any further edits land before push, re-run hard check #1 (`^\+.*103\.118\.183\.185` empty) and re-request SIGN-OFF if scope changes.
3. Update MyAgent activity row outcome to ok after successful push (optional bookkeeping).
4. Separate follow-up (non-blocking): history rewrite via `git filter-repo` if full eradication from remotes is required.
