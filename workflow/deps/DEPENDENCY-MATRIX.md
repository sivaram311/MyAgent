# Dependency matrix â€” live pins (source of truth)

**Last updated:** 2026-08-09  
**Session:** `agent-portal-acp-cold-start-fix-2026-08-09` (backend jar rebuild + F:/G: redeploy) · prior: `agent-portal-machine-status-403-fix-2026-08-09`  
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
| agent-portal | **0.1.20** | `v0.1.20` @ `2eeab48` (tag object `9934fdc`) | `H:\releases\agent-portal-0.1.20` | css-next | 0.2.2 | `v0.2.2` | `agent-portal` | **v0.1.20 (backend jar rebuilt):** fixed ACP cold-start reliability — sessions with a stale stored `cursorSessionId` always tried `session/load` first, which reliably burned its full 6s sub-timeout before falling back to spawn+`session/new` (needs ~10.3s alone), leaving the old 12s total budget deterministically short (`ACP start timed out ... at step 'session/new'`, ~1.9s remaining every time). Widened `agent.cursor.start-timeout-seconds` 12→20 (hard cap 22s incl. 2s watchdog buffer), tightened `agent.cursor.session-load-timeout-seconds` 6→3; mcp-bridge `MCP_PORTAL_ACCEPT_TIMEOUT_MS` 15000→25000 to match. Process-inventory check performed (per machine rule: identify by parent PID, never mass-kill by name) — found no safe-to-kill orphans; corrected an earlier unverified "~31 zombie processes" theory. **Verified live on G: PROD itself** (not just DEV) via the real MCP bridge: the exact `hasCursorSessionId=true` session that originated this incident went through the full session/load-detour-then-respawn path and completed successfully, `waitedMs=19511`, well inside the new 22s cap. **v0.1.19:** `machine_status` 403 fix (bridge token-TTL + retry-on-403). **v0.1.18:** `machine_chat` fully async (accept + `requestId` + background worker + poll). hybrid + ForgeCity rewrite + mobile diagnostics; nginx `/auth` → `:5910`. |
| agentverse-upgrade | **0.3.8** | `4786508` | `H:\releases\agentverse-upgrade-0.3.8` | css-next | 0.2.2 | `v0.2.2` | `agent-portal` (reuse) | F+G **0.3.8** Â· css-next Â· named hosts `agentverse-upgrade[-staging].delena.buzz` **and** short hosts `agentverse[-staging].delena.buzz` (nginx â†’ `:4312`/`:5312` since 2026-07-15) |
| agentverse | 0.3.17 | `v0.3.17` @ `d972909` | `H:\releases\agentverse-0.3.17` | css | 0.1.0 | `v0.1.0` | `agent-portal` (reuse) | Classic densify **rollback only** · tree still on `:4310`/`:5310` (often stopped) · **not** public hostname SoT |
| **proddeck** | **1.0.0** | `v1.0.0` @ `32ba037` | `H:\releases\proddeck-1.0.0` | css-next | 0.2.2 | `v0.2.2` | `proddeck` | Cloud OS v1 · hybrid · F+G **1.0.0** · hard outs `OS_*` OFF |
| **trading-portal** | **0.3.2** | `v0.3.2` | `H:\releases\trading-portal-0.3.2` | css-next | 0.2.2 | `v0.2.2` | `trading-portal` | feature surface + Flyway V2 · F+G **0.3.2** · `live-enabled=false` |
| production-house | **0.2.0** | `v0.2.0` @ `00ec53d` | `H:\releases\production-house-0.2.0` | — | — | — | waived-public-read | **Q1+Q2 live** · F:`:4370` · G:`:5370` · https://production-house.delena.buzz |
| vibehub | **0.1.9** | `v0.1.9` @ `29bd605` | `H:\releases\vibehub-0.1.9` | — | — | — | waived-public-read | **Q1+Q2 live** (0.1.8: two new usage-guide blog posts — MT5-MCP, Agent Portal MCP bridge — no domain/IP per user constraint; 0.1.9 fast-follow: fixed a stale "loopback-only" claim in the MT5-MCP post, found by cross-checking against ACTIVITY-LOG which already recorded the server going public a day earlier) · DEV:`:3380` · F:`:4380` · G:`:5380` · https://vibehub.delena.buzz |

### PREPROD notes

PREPROD: ProdDeck F (`:4320`) **1.0.0** css-next hybrid (`v1.0.0`).  
**agentverse-upgrade** F (`:4312`) and G (`:5312`) both **0.3.8** css-next.  
Public short names: `agentverse-staging.delena.buzz` → nginx `:4312`; `agentverse.delena.buzz` → nginx `:5312` (upgrade).  
**agent-portal** F (`:4080`) + G (`:5080`) jar **0.1.20** `v0.1.20` @ `2eeab48` — ACP cold-start budget fix (start-timeout 12→20s, session-load-timeout 6→3s, hard cap 22s). Both `.env` files confirmed to have no `CURSOR_ACP_*` overrides before deploy, so the new jar defaults apply directly. The single live mcp-bridge process (source at `E:\MyWorkspace\agent-portal\workspaces\agent-api\mcp-bridge`, `.env` points `PORTAL_URL` at G::5080, `MCP_PORTAL_ACCEPT_TIMEOUT_MS=25000`) was restarted and verified live — full async cycle (`accepted→running→completed`) exercising the exact stale-`cursorSessionId` path that originated this incident, now succeeding at `waitedMs=19511`. + app name/version gate + diagnostics API + ForgeCity rewrite + hybrid.  
**trading-portal** F (`:4340`/`:4341`) **0.3.2** `v0.3.2` css-next JWKS `:4910`. G (`:5340`/`:5341`) **0.3.2** same tag · JWKS `:5910` · Flyway v2.  
**production-house** F (`:4370`) + G (`:5370`) **0.2.0** `v0.2.0` @ `00ec53d` · https://production-house-staging.delena.buzz · https://production-house.delena.buzz · DEV https://production-house-dev.delena.buzz → `:3370` · waived-public-read SPA.  
**vibehub** F (`:4380`) + G (`:5380`) **0.1.9** `v0.1.9` @ `29bd605` (two new usage-guide blog posts + a same-session accuracy fix — a post claimed the MT5-MCP server was "loopback-only," but that was already stale by the time it shipped; cross-checking new public claims against ACTIVITY-LOG before publishing, not just against redaction rules, is now the standing lesson) · https://vibehub-staging.delena.buzz · https://vibehub.delena.buzz · DEV https://vibehub-dev.delena.buzz → `:3380` · waived-public-read static Astro blog/docs/pages/shiplog. Build requires `PUBLIC_SITE_URL` per env (else feed/link URLs default to DEV) — see `H:\releases\vibehub-0.1.7\evidence\q1\SUMMARY.md`. Deploy lessons learned across 0.1.3–0.1.7: (1) use `robocopy` for the F:/G: mirror step, not `Copy-Item -Recurse` with a wildcard source — the latter silently produces a broken partial merge against an existing target directory; (2) **stop the previous release's `astro preview` process before removing/redeploying its directory** — a still-running process holding a file open causes `npm ci`/file-copy to fail with `EPERM` on the next deploy (hit during 0.1.4's PREPROD redeploy, applied proactively since); (3) mirror the **full app source tree** (excluding `node_modules`/`dist`/`.astro`/`logs`), not just `dist/`, so `package.json` and other metadata on F:/G: actually match the deployed tag. Also: **Shiplog's filenames are public URL slugs** (`entry.id` in `src/pages/shiplog/[slug].astro`) — any future automated content for this section must redact-check the filename/slug, not just the body text (a body-only redaction filter let 7 internal codenames leak into public URLs during the 0.1.4 backfill; caught by Reviewer NO-GO, fixed, see `H:\releases\vibehub-0.1.4\evidence\q1\security\checklist.md`). **0.1.5 lesson:** `rss.xml.js` had silently stayed blog-only since the Shiplog collection was added — the E2E RSS test's hard-coded item count (`toBe(3)`) is exactly why nobody noticed; any new content collection must be explicitly added to `rss.xml.js`, and count-based feed assertions should use `>=` against a real minimum, not a value that will go stale. **0.1.6→0.1.7 lesson (new, this release):** a "successful build" is not proof correct HTML was produced — Astro's markdown pipeline is CommonMark-based, and a **blank line inside a raw HTML block (e.g. a multi-line inline `<svg>`) silently terminates HTML-block parsing**, causing the remainder to be reinterpreted as an indented code block (rendered as literal escaped text). This shipped to real PROD before being caught, because every check run before deploy (the build's exit code, source-level tag-balance checks, two independent AI code reviews) inspected the *source* or the *build outcome*, never the *rendered output HTML*. Any future inline-HTML/SVG content in this app (or any Astro/CommonMark-based site on this machine) must have its **built `dist/` output actually read and grepped**, not just "build succeeded," before being treated as verified.

---

## How to update (promote crew)

1. Fill `H:\releases\<app>-<ver>\DEPENDENCIES.md` from the template.  
2. Set CHECKLIST flags: `app_git_tag_recorded`, `dependency_versions_recorded`, `dependency_matrix_updated`.  
3. On GO + successful deploy: edit this matrix + `DEPENDENCIES.json` to match live pins.  
4. ACTIVITY-LOG: include app git tag + dependency versions in the promote row.
