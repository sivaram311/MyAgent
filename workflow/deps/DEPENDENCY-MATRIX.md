# Dependency matrix — live pins (source of truth)

**Last updated:** 2026-07-15  
**Session:** `css-api-migrate-wave-2026-07-15` (all active auth consumers on css-next)
**Policy:** `workflow/deps/README.md` · Machine-readable: `DEPENDENCIES.json`

Update this file **in the same turn** as any F:/G: cutover or CSS (shared) release.  
Columns: what is **live**, what **git tag** backs it, and which **upstream versions/tags** it was verified against.

---

## Shared services (upstream)

| Service | Live PROD version | Git tag | Commit | Release pack | Public / port | Notes |
|---------|-------------------|---------|--------|--------------|---------------|-------|
| css | 0.1.0 | `v0.1.0` | `b754f0b` | `H:\releases\css-0.1.0` | https://css.delena.buzz `:5900` | **Classic IdP — keep available.** PREPROD `:4900`. No live consumers pin here post follow-ons. |
| css-next | **0.2.1** | `v0.2.1` | `75ae5ae` | `H:\releases\css-next-0.2.1` | https://css-next.delena.buzz `:5910` | Side-fleet IdP + Delena `/oauth/login` brand. PREPROD https://css-next-staging.delena.buzz `:4910`. |

---

## Consumer apps (PROD pins)

| App ID | Live PROD version | App git tag / commit | Release pack | Depends on | Dep version | Dep git tag | clientId | Issuer / notes |
|--------|-------------------|----------------------|--------------|------------|-------------|-------------|----------|----------------|
| agent-portal | **0.1.10** | `084e94a` | `H:\releases\agent-portal-0.1.10` | css-next | 0.2.1 | `v0.2.1` | `agent-portal` | hybrid password + OAuth/PKCE; BFF token; nginx `/auth` → `:5910` |
| agentverse-upgrade | **0.3.8** | `4786508` | `H:\releases\agentverse-upgrade-0.3.8` | css-next | 0.2.1 | `v0.2.1` | `agent-portal` (reuse) | F+G **0.3.8** · css-next · named hosts `agentverse-upgrade[-staging].delena.buzz` **and** short hosts `agentverse[-staging].delena.buzz` (nginx → `:4312`/`:5312` since 2026-07-15) |
| agentverse | 0.3.17 | `v0.3.17` @ `d972909` | `H:\releases\agentverse-0.3.17` | css | 0.1.0 | `v0.1.0` | `agent-portal` (reuse) | Classic densify **rollback only** · tree still on `:4310`/`:5310` (often stopped) · **not** public hostname SoT |

### PREPROD notes

PREPROD: ProdDeck F (`:4320`) **0.8.4** css-next hybrid.  
**agentverse-upgrade** F (`:4312`) and G (`:5312`) both **0.3.8** css-next.  
Public short names: `agentverse-staging.delena.buzz` → nginx `:4312`; `agentverse.delena.buzz` → nginx `:5312` (upgrade).  
**agent-portal** F (`:4080`) **0.1.10** hybrid.  
**trading-portal** F (`:4340`/`:4341`) **0.1.0** css-next JWKS `:4910`.

---

## How to update (promote crew)

1. Fill `H:\releases\<app>-<ver>\DEPENDENCIES.md` from the template.  
2. Set CHECKLIST flags: `app_git_tag_recorded`, `dependency_versions_recorded`, `dependency_matrix_updated`.  
3. On GO + successful deploy: edit this matrix + `DEPENDENCIES.json` to match live pins.  
4. ACTIVITY-LOG: include app git tag + dependency versions in the promote row.
