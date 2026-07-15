# Dependency matrix — live pins (source of truth)

**Last updated:** 2026-07-15  
**Session:** `css-api-migrate-wave-2026-07-15` (ProdDeck 0.8.2 css-next)
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
| agentverse-upgrade | **0.3.6** | `v0.3.6` @ `3d90a73` | `H:\releases\agentverse-upgrade-0.3.6` | css | 0.1.0 | `v0.1.0` | `agent-portal` (reuse) | F+G **0.3.6** · specialist cast remap · shared Priya+Rajesh · `agentverse-upgrade[-staging].delena.buzz` |
| agentverse | 0.3.17 | `v0.3.17` @ `d972909` | `H:\releases\agentverse-0.3.17` | css | 0.1.0 | `v0.1.0` | `agent-portal` (reuse) | Classic densify **rollback only** · `:4310`/`:5310` · **not** Dispatch default |
| proddeck | **0.8.2** | `v0.8.2` @ `2c57914` | `H:\releases\proddeck-0.8.2` | css-next | 0.2.0 | `v0.2.0` | `proddeck` | home.delena.buzz `:5320` **hybrid**; IdP css-next; classic CSS peers unchanged; Dispatch → agentverse-upgrade |
| stack-pilot | 0.2.0-a | _(record on next promote)_ | `H:\releases\stack-pilot-0.2.0-a` | css | waived | — | waived-public-read | Auth disabled by design |
| h-drive-server | 0.1.0 | _(record on next promote)_ | `H:\releases\h-drive-server-0.1.0` | css | waived | — | waived-public-read | Open CORS file expose by design |

### PREPROD notes

PREPROD: ProdDeck F (`:4320`) matches PROD pin **0.8.2** on **css-next** `v0.2.0` hybrid. Other consumers still on classic CSS `v0.1.0` until their migrate IDs run.  
**agentverse-upgrade** F (`:4312`) and G (`:5312`) both pin **0.3.6**.

---

## How to update (promote crew)

1. Fill `H:\releases\<app>-<ver>\DEPENDENCIES.md` from the template.  
2. Set CHECKLIST flags: `app_git_tag_recorded`, `dependency_versions_recorded`, `dependency_matrix_updated`.  
3. On GO + successful deploy: edit this matrix + `DEPENDENCIES.json` to match live pins.  
4. ACTIVITY-LOG: include app git tag + dependency versions in the promote row.