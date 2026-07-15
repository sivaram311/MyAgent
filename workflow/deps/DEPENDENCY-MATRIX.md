# Dependency matrix — live pins (source of truth)

**Last updated:** 2026-07-15  
**Session:** `agentverse-upgrade-0.3.2-q1-preprod`  
**Policy:** `workflow/deps/README.md` · Machine-readable: `DEPENDENCIES.json`

Update this file **in the same turn** as any F:/G: cutover or CSS (shared) release.  
Columns: what is **live**, what **git tag** backs it, and which **upstream versions/tags** it was verified against.

---

## Shared services (upstream)

| Service | Live PROD version | Git tag | Commit | Release pack | Public / port | Notes |
|---------|-------------------|---------|--------|--------------|---------------|-------|
| css | 0.1.0 | `v0.1.0` | `b754f0b` | `H:\releases\css-0.1.0` | https://css.delena.buzz `:5900` | **Classic IdP — keep.** PREPROD `:4900`. Consumers still pin here unless migrated. |
| css-next | 0.2.0 | `v0.2.0` | `180ac13` | `H:\releases\css-next-0.2.0` | https://css-next.delena.buzz `:5910` | **Side-fleet** OAuth SSO. PREPROD https://css-next-staging.delena.buzz `:4910`. Does **not** replace classic. |

---

## Consumer apps (PROD pins)

| App ID | Live PROD version | App git tag / commit | Release pack | Depends on | Dep version | Dep git tag | clientId | Issuer / notes |
|--------|-------------------|----------------------|--------------|------------|-------------|-------------|----------|----------------|
| agent-portal | 0.1.8 | _(jar pack)_ | `H:\releases\agent-portal-0.1.8` | css | 0.1.0 | `v0.1.0` | `agent-portal` | prod CSS `:5900` / css.delena.buzz |
| agentverse-upgrade | 0.3.2 | `v0.3.2` @ `2aa2e7c` | `H:\releases\agentverse-upgrade-0.3.2` | css | 0.1.0 | `v0.1.0` | `agent-portal` (reuse) | **ProdDeck Dispatch peer SoT** · staging `:4312` **0.3.2** `agentverse-upgrade-staging.delena.buzz` · prod `:5312` still **0.3.1** until Q2 · `F/G:\apps\agentverse-upgrade` |
| agentverse | 0.3.17 | `v0.3.17` @ `d972909` | `H:\releases\agentverse-0.3.17` | css | 0.1.0 | `v0.1.0` | `agent-portal` (reuse) | Classic densify **rollback only** · `:4310`/`:5310` · **not** Dispatch default |
| proddeck | 0.8.0 | `v0.8.0` @ `6882ea46` | `H:\releases\proddeck-0.8.0` | css | 0.1.0 | `v0.1.0` | `proddeck` | home.delena.buzz `:5320`; Wave A; Dispatch → **agentverse-upgrade 0.3.1** |
| stack-pilot | 0.2.0-a | _(record on next promote)_ | `H:\releases\stack-pilot-0.2.0-a` | css | waived | — | waived-public-read | Auth disabled by design |
| h-drive-server | 0.1.0 | _(record on next promote)_ | `H:\releases\h-drive-server-0.1.0` | css | waived | — | waived-public-read | Open CORS file expose by design |

### PREPROD notes

PREPROD consumer apps that auth against **prod CSS** still list dep = CSS `v0.1.0` / `0.1.0` (same IdP). ProdDeck F matches PROD pin **0.8.0**.  
**agentverse-upgrade** F (`:4312`) pins **0.3.2** (Q1 2026-07-15). G (`:5312`) still **0.3.1** until Q2.

---

## How to update (promote crew)

1. Fill `H:\releases\<app>-<ver>\DEPENDENCIES.md` from the template.  
2. Set CHECKLIST flags: `app_git_tag_recorded`, `dependency_versions_recorded`, `dependency_matrix_updated`.  
3. On GO + successful deploy: edit this matrix + `DEPENDENCIES.json` to match live pins.  
4. ACTIVITY-LOG: include app git tag + dependency versions in the promote row.