# Dependency matrix â€” live pins (source of truth)

**Last updated:** 2026-07-30  
**Session:** `agent-portal-diagnostics-0.1.15-2026-07-30` (Q1+Q2 live) · prior: `css-next-android-sso-2026-07-28`  
**Policy:** `workflow/deps/README.md` · Machine-readable: `DEPENDENCIES.json`

Update this file **in the same turn** as any F:/G: cutover or CSS (shared) release.  
Columns: what is **live**, what **git tag** backs it, and which **upstream versions/tags** it was verified against.

---

## Shared services (upstream)

| Service | Live PROD version | Git tag | Commit | Release pack | Public / port | Notes |
|---------|-------------------|---------|--------|--------------|---------------|-------|
| css | 0.1.0 | `v0.1.0` | `b754f0b` | `H:\releases\css-0.1.0` | https://css.delena.buzz `:5900` | **Classic IdP â€” keep available.** PREPROD `:4900`. No live consumers pin here post follow-ons. |
| css-next | **0.2.2** | `v0.2.2` | `fc11dd8` | `H:\releases\css-next-0.2.2` | https://css-next.delena.buzz `:5910` | Side-fleet IdP + Android callback allow-list corrective release. PREPROD https://css-next-staging.delena.buzz `:4910`. |

---

## Consumer apps (PROD pins)

| App ID | Live PROD version | App git tag / commit | Release pack | Depends on | Dep version | Dep git tag | clientId | Issuer / notes |
|--------|-------------------|----------------------|--------------|------------|-------------|-------------|----------|----------------|
| agent-portal | **0.1.15** | `v0.1.15` @ `2e70da8` | `H:\releases\agent-portal-0.1.15` | css-next | 0.2.2 | `v0.2.2` | `agent-portal` | hybrid + ForgeCity rewrite + mobile diagnostics `/api/diagnostics/client-logs`; nginx `/auth` → `:5910` |
| agentverse-upgrade | **0.3.8** | `4786508` | `H:\releases\agentverse-upgrade-0.3.8` | css-next | 0.2.2 | `v0.2.2` | `agent-portal` (reuse) | F+G **0.3.8** Â· css-next Â· named hosts `agentverse-upgrade[-staging].delena.buzz` **and** short hosts `agentverse[-staging].delena.buzz` (nginx â†’ `:4312`/`:5312` since 2026-07-15) |
| agentverse | 0.3.17 | `v0.3.17` @ `d972909` | `H:\releases\agentverse-0.3.17` | css | 0.1.0 | `v0.1.0` | `agent-portal` (reuse) | Classic densify **rollback only** · tree still on `:4310`/`:5310` (often stopped) · **not** public hostname SoT |
| **proddeck** | **1.0.0** | `v1.0.0` @ `32ba037` | `H:\releases\proddeck-1.0.0` | css-next | 0.2.2 | `v0.2.2` | `proddeck` | Cloud OS v1 · hybrid · F+G **1.0.0** · hard outs `OS_*` OFF |
| **trading-portal** | **0.3.2** | `v0.3.2` | `H:\releases\trading-portal-0.3.2` | css-next | 0.2.2 | `v0.2.2` | `trading-portal` | feature surface + Flyway V2 · F+G **0.3.2** · `live-enabled=false` |
| production-house | **0.1.0** | `v0.1.0` @ `6baae19` | `H:\releases\production-house-0.1.0` | — | — | — | waived-public-read | **Q1+Q2 live** · F:`:4370` · G:`:5370` · https://production-house.delena.buzz |
| vibehub | **0.1.3** | `v0.1.3` @ `7aebc44` | `H:\releases\vibehub-0.1.3` | — | — | — | waived-public-read | **Q1+Q2 live** (Shiplog section) · DEV:`:3380` · F:`:4380` · G:`:5380` · https://vibehub.delena.buzz |

### PREPROD notes

PREPROD: ProdDeck F (`:4320`) **1.0.0** css-next hybrid (`v1.0.0`).  
**agentverse-upgrade** F (`:4312`) and G (`:5312`) both **0.3.8** css-next.  
Public short names: `agentverse-staging.delena.buzz` → nginx `:4312`; `agentverse.delena.buzz` → nginx `:5312` (upgrade).  
**agent-portal** F (`:4080`) + G (`:5080`) **0.1.15** `v0.1.15` diagnostics API + ForgeCity rewrite + hybrid.  
**trading-portal** F (`:4340`/`:4341`) **0.3.2** `v0.3.2` css-next JWKS `:4910`. G (`:5340`/`:5341`) **0.3.2** same tag · JWKS `:5910` · Flyway v2.  
**production-house** F (`:4370`) + G (`:5370`) **0.1.0** `v0.1.0` · https://production-house-staging.delena.buzz · https://production-house.delena.buzz · DEV https://production-house-dev.delena.buzz → `:3370` · waived-public-read SPA.  
**vibehub** F (`:4380`) + G (`:5380`) **0.1.3** `v0.1.3` (adds `/shiplog` — public plain-language changelog) · https://vibehub-staging.delena.buzz · https://vibehub.delena.buzz · DEV https://vibehub-dev.delena.buzz → `:3380` · waived-public-read static Astro blog/docs/pages/shiplog. Build requires `PUBLIC_SITE_URL` per env (else feed/link URLs default to DEV) — see `H:\releases\vibehub-0.1.3\evidence\*\ops\`. Deploy note: use `robocopy` for the F:/G: mirror step, not `Copy-Item -Recurse` with a wildcard source — the latter silently produces a broken partial merge against an existing target directory (hit and fixed during the 0.1.3 promote, see `evidence\q1\ops\deploy-log.md`).

---

## How to update (promote crew)

1. Fill `H:\releases\<app>-<ver>\DEPENDENCIES.md` from the template.  
2. Set CHECKLIST flags: `app_git_tag_recorded`, `dependency_versions_recorded`, `dependency_matrix_updated`.  
3. On GO + successful deploy: edit this matrix + `DEPENDENCIES.json` to match live pins.  
4. ACTIVITY-LOG: include app git tag + dependency versions in the promote row.
