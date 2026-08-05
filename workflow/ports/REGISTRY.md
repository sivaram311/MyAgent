# Port registry (source of truth)

**Mandatory:** update this file **before** binding a new port.  
Mirror every change in `registry.json`.

Status values: `active` | `reserved` | `legacy` | `retired`

---

## Shared infra

| Port | App ID | Env | Role | Status | Bind | Notes |
|------|--------|-----|------|--------|------|-------|
| 80 | nginx | shared | http | active | 0.0.0.0 | Reverse proxy |
| 443 | nginx | shared | https | reserved | — | TLS when enabled |
| 5432 | postgres | shared | db | active | :: | Shared PostgreSQL |
| 9000 | css | shared | http | active | :: | Centralized Security System (`E:\MyWorkspace\centralized-security-system`) |
| 3389 | rdp | shared | other | active | :: | Remote desktop |

---

## DEV (E:) — range 3000–3999

| Port | App ID | Role | Status | Path / process | Notes |
|------|--------|------|--------|----------------|-------|
| 3010 | h-drive-server | http | active | E:\MyWorkspace\h-drive-server | Exposes H:\ files/folders; open CORS |
| 3080 | agent-portal | http | reserved | E:\MyWorkspace\agent-portal | Preferred DEV API offset (migrate from legacy :8080) |
| 3091 | stack-pilot | http | reserved | E:\Source\stack-pilot | Preferred DEV offset (migrate from legacy :8091) |

| 3310 | agentverse | http | active | E:\MyWorkspace\agentverse-project | Next.js DEV UI (R3F); npm run dev -p 3310 |
| 3311 | agentverse-v2 | http | active | E:\MyWorkspace\agentverse-project | stable-v2 side deploy; feature/stable-v2; npm run next -p 3311; side-by-side — primary DEV may stay 3310 on other branches |
| 3312 | agentverse-upgrade | http | active | E:\MyWorkspace\agentverse-project | upgradation functionality side fleet; feature/upgradation-functionality; npm -p 3312; must NOT use 3310/3311 |
| 3320 | proddeck | http | active | E:\wt\proddeck-integrate | ProdDeck DEV; https://home-dev.delena.buzz → :3320 |
| 3330 | library | http | reserved | E:\MyWorkspace\sandbox\library | Library DEV; https://library-dev.delena.buzz → :3330 |
| 3340 | trading-portal | api | active | E:\MyWorkspace\trading-portal\backend | Spring Boot 3.3 API DEV; ACTIVE 2026-07-15 (/api/health ok); dev-bypass auth (CSS JWKS ready); GROK-DECISION-001 |
| 3341 | trading-portal | http | active | E:\MyWorkspace\trading-portal | Angular UI DEV; UI listening verified GET / → 200 (2026-07-15) |
| 3342 | trading-portal | worker | active | E:\MyWorkspace\trading-portal\python | Python MT5 XAUUSD ingest worker DEV; optional `GET /health` verified 2026-07-15 (`python -m trading_portal_ingest seed --health`); not a persistent daemon by default — start via `scripts/run-ingest-dev.ps1` |
| 3370 | production-house | http | active | E:\MyWorkspace\sandbox\production-house\web | Production House Vite+R3F DEV; Grok design brief Phase 0.1; `npm run dev` |
| 3380 | vibehub | http | active | E:\MyWorkspace\vibehub | Blog/docs/pages site (Astro) DEV; ACTIVE 2026-07-25, https://vibehub-dev.delena.buzz → :3380 verified 200 all routes; no DB/CSS auth (public content) |
| 3390 | mathura-portfolio | http | active | E:\MyWorkspace\mathura-portfolio | Model/anchor portfolio site (Astro) DEV; ACTIVE 2026-07-25, http://127.0.0.1:3390 + https://mathura-portfolio-dev.delena.buzz verified 200 (correct title); nginx + CF proxied A live; no DB/CSS auth (public content) |
| 3391 | boopathy-portfolio | http | active | E:\MyWorkspace\boopathy-portfolio | Software architect portfolio (Astro) DEV; ACTIVE 2026-07-29, http://127.0.0.1:3391 + https://boopathy-portfolio-dev.delena.buzz verified 200 (correct title); nginx + CF proxied A live; no DB/CSS auth (public content) |
| 3360 | rd-center-project | http | active | E:\MyWorkspace\rd-center-project | Next.js R3F DEV; found via Phase 1 drift-reconcile 2026-08-01 (was listening, unregistered) — confirmed real via `Get-CimInstance Win32_Process` PID 10960: `node ... next start -H 0.0.0.0 -p 3360` from this path, and cross-checked against the app's own README (`Port train (reserved) 3360/4360/5360`); https://rd-center-dev.delena.buzz |
| 3383 | vibehub | preview | active | E:\MyWorkspace\vibehub | Local `astro preview` (serves the built production output, distinct from DEV :3380 `astro dev`); command requested `--port 3382` but auto-bumped to 3383 (3382 was already taken at start time — not investigated further); found unregistered via Phase 1 drift-reconcile 2026-08-01, confirmed via `Win32_Process` PID 19124, registered on user request 2026-08-01 |
| 3350 | machine-sentinel | http | active | E:\MyWorkspace\machine-sentinel\backend | Spring Boot backend DEV; found via Phase 1 drift-reconcile 2026-08-04 (was listening, unregistered), confirmed via `Get-CimInstance Win32_Process` PID 7128: `java -jar machine-sentinel-backend-0.1.0-SNAPSHOT.jar` from this path |
| 3351 | machine-sentinel | http | active | E:\MyWorkspace\machine-sentinel\ui | Thin ops UI DEV, static HTML/JS served via `python -m http.server 3351 --bind 127.0.0.1`; already present in `registry.json` (live since 2026-07-17, session-0 MachineSentinelUI, CSS JWT to API :3350) but missing from this file — added 2026-08-05 to fix the drift; launched by `E:\MyWorkspace\machine-sentinel\scripts\run-ui-session0.ps1` (Task Scheduler startup trigger, runs as SYSTEM/Session 0) |
| 3400 | cineforge | api | reserved | E:\MyWorkspace\cineforge | New project (AI-DLC Inception, started 2026-08-01): movie-generation pipeline orchestrating RunPod Serverless (ComfyUI/WAN video models) via RunPod's official MCP server + REST API. Not bound/running yet — reserved ahead of Construction. |
| 3401 | cineforge | http | reserved | E:\MyWorkspace\cineforge | Reserved for a future UI (status/job dashboard), not built yet |
| 3402 | cineforge | worker | reserved | E:\MyWorkspace\cineforge | Reserved for a future local worker/queue process, not built yet |

<!-- Add new DEV rows below -->

---

## PREPROD (F:) — range 4000–4999

| Port | App ID | Role | Status | Path / process | Notes |
|------|--------|------|--------|----------------|-------|
| 4010 | h-drive-server | http | active | F:\apps\h-drive-server | Staging expose of H:\; open CORS |
| 4080 | agent-portal | http | active | F:\apps\agent-portal | API; UI static via nginx; https://agent-portal-staging.delena.buzz |
| 4081 | agent-portal | http | retired | nginx (disabled) | Was PREPROD public-IP edge `<ORIGIN_IP>:4081`; disabled 2026-07-16 — hostname only |
| 4310 | agentverse | http | reserved | F:\apps\agentverse | Classic densify PREPROD rollback tree; **not** public SoT. Hostname `agentverse-staging.delena.buzz` nginx → **`:4312`** (upgrade) since 2026-07-15 |
| 4311 | agentverse-v2 | http | active | F:\apps\agentverse-v2 | stable-v2 side PREPROD; https://agentverse-v2-staging.delena.buzz (must NOT use 4310) |
| 4312 | agentverse-upgrade | http | active | F:\apps\agentverse-upgrade | upgradation PREPROD SoT; https://agentverse-upgrade-staging.delena.buzz **and** nginx alias https://agentverse-staging.delena.buzz |
| 4320 | proddeck | http | active | F:\apps\proddeck | ProdDeck PREPROD; https://home-staging.delena.buzz → :4320; Q1 0.1.0 2026-07-13 |
| 4330 | library | http | reserved | F:\apps\library | Library PREPROD; https://library-staging.delena.buzz → :4330 (app not deployed yet) |
| 4900 | css | http | active | F:\apps\css | Preprod classic CSS IdP; keep live; do not replace with css-next |
| 4910 | css-next | http | active | F:\apps\css-next | Side-fleet PREPROD OAuth SSO 0.2.0; https://css-next-staging.delena.buzz → :4910; must NOT use 4900 |
| 4091 | stack-pilot | http | active | F:\apps\stack-pilot | PREPROD; https://control-staging.delena.buzz ? :4091 |
| 4340 | trading-portal | http | active | F:\apps\trading-portal | Spring Boot API PREPROD; ACTIVE 2026-07-15 health ok; paper-only |
| 4341 | trading-portal | http | active | F:\apps\trading-portal | Angular UI static PREPROD; ACTIVE 2026-07-15 GET / 200 |
| 4342 | trading-portal | worker | reserved | F:\apps\trading-portal\python | Python MT5 XAUUSD ingest worker PREPROD; not bound yet — GROK-DECISION-001 |
| 4370 | production-house | http | active | F:\apps\production-house | Production House PREPROD vite preview; https://production-house-staging.delena.buzz; durable via `StackPilot-S0-ProductionHouse-Preprod` AtStartup task (added 2026-08-06, same gap as PROD :5370 fixed 2026-08-05) |
| 4380 | vibehub | http | active | F:\apps\vibehub | Blog/docs/pages site PREPROD; 0.1.2 (RSS) ACTIVE 2026-07-25, astro preview; https://vibehub-staging.delena.buzz → :4380 verified 200 all routes incl. /rss.xml; no DB/CSS |
| 4360 | rd-center-project | http | reserved | F:\apps\rd-center-project | Not deployed yet; reserved per app README (`rd-center-staging.delena.buzz`); added 2026-08-01 alongside DEV :3360 during Phase 1 drift triage, not independently verified listening |

---

## PROD (G:) — range 5000–5999

| Port | App ID | Role | Status | Path / process | Notes |
|------|--------|------|--------|----------------|-------|
| 5080 | agent-portal | http | active | G:\apps\agent-portal | API; UI static via nginx; https://agent-portal.delena.buzz; auth→prod CSS :5900 |
| 5010 | h-drive-server | http | active | G:\apps\h-drive-server | https://hdrive.delena.buzz → 127.0.0.1:5010 |
| 5900 | css | http | active | G:\apps\css | Prod classic CSS IdP; https://css.delena.buzz; keep live; do not replace with css-next |
| 5910 | css-next | http | active | G:\apps\css-next | Side-fleet PROD OAuth SSO 0.2.0; https://css-next.delena.buzz → :5910; must NOT use 5900 |
| 5091 | stack-pilot | http | active | G:\apps\stack-pilot | PROD; https://control.delena.buzz ? :5091; CF via cloudflare-dns.ps1 (wrapper blocks `control`) |

---

| 5310 | agentverse | http | reserved | G:\apps\agentverse | Classic densify PROD rollback tree; **not** public SoT. Hostname `agentverse.delena.buzz` nginx → **`:5312`** (upgrade) since 2026-07-15 |
| 5311 | agentverse-v2 | http | active | G:\apps\agentverse-v2 | stable-v2 side PROD; https://agentverse-v2.delena.buzz (must NOT use 5310) |
| 5312 | agentverse-upgrade | http | active | G:\apps\agentverse-upgrade | upgradation PROD SoT; https://agentverse-upgrade.delena.buzz **and** nginx alias https://agentverse.delena.buzz |
| 5320 | proddeck | http | active | G:\apps\proddeck | ProdDeck PROD; https://home.delena.buzz |
| 5330 | library | http | reserved | G:\apps\library | Library PROD; https://library.delena.buzz → :5330 (app not deployed yet) |
| 5340 | trading-portal | http | active | F: or G: apps\trading-portal | Spring Boot API PROD; ACTIVE 2026-07-15 health ok; paper-only |
| 5341 | trading-portal | http | active | F: or G: apps\trading-portal | Angular UI static PROD; ACTIVE 2026-07-15 GET / 200 |
| 5342 | trading-portal | worker | reserved | G:\apps\trading-portal\python | Python MT5 XAUUSD ingest worker PROD; not bound yet — GROK-DECISION-001 |
| 5370 | production-house | http | active | G:\apps\production-house | Production House PROD vite preview; https://production-house.delena.buzz; durable via `StackPilot-S0-ProductionHouse-Prod` AtStartup task (added 2026-08-05, was previously interactive-only and died on logoff/reboot) |
| 5380 | vibehub | http | active | G:\apps\vibehub | Blog/docs/pages site PROD; 0.1.2 (RSS) ACTIVE 2026-07-25, astro preview; https://vibehub.delena.buzz → :5380 verified 200 all routes incl. /rss.xml; no DB/CSS |
| 5360 | rd-center-project | http | reserved | G:\apps\rd-center-project | Not deployed yet; reserved per app README (`rd-center.delena.buzz`); added 2026-08-01 alongside DEV :3360 during Phase 1 drift triage, not independently verified listening |

## Legacy outside scheme (migrate later)

| Port | App ID | Env | Role | Status | Process | Notes |
|------|--------|-----|------|--------|---------|-------|
| 4200 | agent-portal | dev | http | legacy | node/ng | DEV UI (ng serve); public delena.buzz / |
| 8080 | agent-portal | dev | http | legacy | java | DEV API; migrate toward :3080; Machine Gateway `/api/machine/*` (no extra port) |
| 8081 | legacy-java-8081 | unknown | http | legacy | java | Identify owner |
| 8082 | legacy-java-8082 | unknown | http | legacy | java | Identify owner |
| 8091 | stack-pilot | dev | http | legacy | java | Stopped 2026-07-11 sole cutover; prod :5091 owns control.delena.buzz |


---

## Template (copy a row)

```md
| 3010 | my-app-web | http | reserved | E:\Source\my-app | block 3010–3014 |
```




