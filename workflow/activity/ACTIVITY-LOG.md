# Activity log

Append-only. Newest entries at the **top** (below this header block).

Session transcripts (Cursor): `C:\Users\Administrator\.cursor\projects\E-MyAgent\agent-transcripts\<session-id>\`

| When (UTC+5:30) | Session | Provider | Role | Action | Target | Result | Evidence / notes |
|-----------------|---------|----------|------|--------|--------|--------|------------------|
| 2026-07-11 23:32 | `stack-pilot-0.1.2-realme-2026-07-11` | cursor | em | Q1+Q2 GO stack-pilot 0.1.2 Realme OLED polish | F::4091 G::5091 | ok | H:\releases\stack-pilot-0.1.2\evidence\ |
| 2026-07-11 23:31 | `stack-pilot-0.1.2-realme-2026-07-11` | cursor | qa | Q2 HTTPS+OLED markers | control.delena.buzz | ok | theme/sp-oled/skeleton/48px touch |
| 2026-07-11 23:30 | `stack-pilot-0.1.2-realme-2026-07-11` | cursor | ops | Deploy 0.1.2 PREPROD+PROD | F:/G stack-pilot | ok | sibling apps kept UP |
| 2026-07-11 23:25 | `stack-pilot-0.1.1-promote-2026-07-11` | cursor | em | Q1+Q2 GO stack-pilot 0.1.1 UI+prod-apps | F::4091 G::5091 | ok | H:\releases\stack-pilot-0.1.1\evidence\ |
| 2026-07-11 23:25 | `stack-pilot-0.1.1-promote-2026-07-11` | cursor | qa | Q2 HTTPS+prod services smoke | control.delena.buzz | ok | css/agent-portal/hdrive RUNNING_EXTERNAL |
| 2026-07-11 23:24 | `stack-pilot-0.1.1-promote-2026-07-11` | cursor | ops | Deploy 0.1.1 jar profile=prod restart :5091 | G:\apps\stack-pilot | ok | sibling apps kept UP |
| 2026-07-11 23:20 | `stack-pilot-0.1.1-promote-2026-07-11` | cursor | qa | Q1 smoke preprod new UI | F::4091 | ok | evidence\q1\qa\results.md |
| 2026-07-11 23:19 | `stack-pilot-0.1.1-promote-2026-07-11` | cursor | ops | Deploy 0.1.1 to PREPROD profile=dev | F:\apps\stack-pilot | ok | evidence\q1\ops\deploy-log.md |
| 2026-07-11 23:15 | `stack-pilot-0.1.1-promote-2026-07-11` | cursor | em | UI redesign + prod profile + package 0.1.1 | E:\Source\stack-pilot | ok | mobile design subagent + implement/prod-apps subagents |
| 2026-07-11 23:05 | `stack-pilot-dns-fix-2026-07-11` | cursor | ops | Docs sync :5091 + CF control exception | Deployment/MyAgent/portal/G: | ok | nginx-setup, prod-deploy, CLOUDFLARE-DNS-PROXY, DEPLOY.md |
| 2026-07-11 23:02 | `stack-pilot-dns-fix-2026-07-11` | cursor | ops | NIC DNS 4.2.2.4→1.1.1.1+8.8.8.8; HTTPS verify 200 | Ethernet0 + control.delena.buzz | ok | / and /api/services 200 |
| 2026-07-11 23:00 | `stack-pilot-dns-fix-2026-07-11` | cursor | ops | Create missing CF A control.delena.buzz (proxied) | cloudflare-dns.ps1 | ok | was NXDOMAIN; Q2 skipped reserved name |
| 2026-07-11 22:58 | `stack-pilot-dns-fix-2026-07-11` | cursor | qa | Diagnose control.delena.buzz outage | :5091 ok; nginx Host 200; public DNS NXDOMAIN | ok | root cause: missing CF record |
| 2026-07-11 22:52 | `agent-portal-0.1.3-promote-2026-07-11` | cursor | em | Q1+Q2 GO agent-portal 0.1.3 Console tab → PREPROD+PROD | F:/G :4080/:5080 | ok | H:\releases\agent-portal-0.1.3\evidence\ |
| 2026-07-11 22:52 | `agent-portal-0.1.3-promote-2026-07-11` | cursor | qa | Q2 prod smoke + Console bundle `session-console` | agent-portal.delena.buzz | ok | evidence\q2\qa\results.md |
| 2026-07-11 22:51 | `agent-portal-0.1.3-promote-2026-07-11` | cursor | ops | Deploy 0.1.3 jar+ui to PROD restart :5080 | G:\apps\agent-portal | ok | evidence\q2\ops\deploy-log.md |
| 2026-07-11 22:50 | `agent-portal-0.1.3-promote-2026-07-11` | cursor | qa | Q1 staging smoke + Console bundle | staging.delena.buzz | ok | evidence\q1\qa\results.md |
| 2026-07-11 22:49 | `agent-portal-0.1.3-promote-2026-07-11` | cursor | ops | Deploy 0.1.3 jar+ui to PREPROD restart :4080 | F:\apps\agent-portal | ok | evidence\q1\ops\deploy-log.md |
| 2026-07-11 22:15 | `agent-portal-auto-approve-rules` | cursor | ops | Cursor allow-always + agy skip-permissions on F/G; MyAgent global rules | portal .env + ~/.cursor/rules + GEMINI.md | ok | AGENT_DEFAULT_AUTO_APPROVE; myagent-machine.mdc |
| 2026-07-11 21:52 | `agent-portal-0.1.2-session-invoke` | cursor | ops | Deploy 0.1.2 session auto-invoke to PREPROD+PROD | F:/G agent-portal | ok | invokeTaskSession live; @Lazy cycle fix |
| 2026-07-11 21:45 | `agent-portal-0.1.2-session-invoke` | cursor | em | Wire SYSTEM_E2E_LOOP to spawn sessions like other work | PlatformRegistryService | ok | handoff -> New session + prompt |
| 2026-07-11 21:35 | `agent-portal-0.1.1-promote-2026-07-11` | cursor | qa | Live SYSTEM_E2E_LOOP Realme Playwright → GREEN iter 1/20 | agent-portal.delena.buzz :5080 | ok | evidence\live-playwright-pass.md; run 94375ec7… |
| 2026-07-11 21:34 | `agent-portal-0.1.1-promote-2026-07-11` | cursor | ops | Fix start.ps1 health-wait (90s) sync F/G/H | agent-portal start.ps1 | ok | avoids false Failed-to-bind exit 1 |
| 2026-07-11 21:30 | `agent-portal-0.1.1-promote-2026-07-11` | cursor | em | Q2 closed PROD LIVE agent-portal 0.1.1 SYSTEM_E2E_LOOP | G:\apps\agent-portal :5080 | ok | evidence\q2\; maxIterations 20 |
| 2026-07-11 21:29 | `agent-portal-0.1.1-promote-2026-07-11` | cursor | qa | Q2 preprod regression + prod smoke SYSTEM_E2E_LOOP | :4080/:5080 | ok | evidence\q2\qa\results.md |
| 2026-07-11 21:28 | `agent-portal-0.1.1-promote-2026-07-11` | cursor | ops | Prod jar/ui swap + restart :5080 | G:\apps\agent-portal | ok | evidence\q2\ops\deploy-log.md |
| 2026-07-11 21:28 | `agent-portal-0.1.1-promote-2026-07-11` | cursor | em | Q2 GO agent-portal → PROD | agent-portal 0.1.1 | ok | evidence\q2\SUMMARY.md; human prod intent |
| 2026-07-11 21:27 | `agent-portal-0.1.1-promote-2026-07-11` | cursor | security | Q2 PASS CSS/CORS/JWT | agent-portal 0.1.1 | ok | evidence\q2\security\checklist.md |
| 2026-07-11 21:27 | `agent-portal-0.1.1-promote-2026-07-11` | cursor | review | Q2 PASS G:/5080/H: + Q1 present | agent-portal 0.1.1 | ok | evidence\q2\review\notes.md |
| 2026-07-11 21:26 | `agent-portal-0.1.1-promote-2026-07-11` | cursor | qa | Q1 smoke PREPROD SYSTEM_E2E_LOOP | F:\apps\agent-portal :4080 | ok | evidence\q1\qa\results.md |
| 2026-07-11 21:25 | `agent-portal-0.1.1-promote-2026-07-11` | cursor | ops | Deploy+start preprod :4080 | F:\apps\agent-portal | ok | evidence\q1\ops\deploy-log.md |
| 2026-07-11 21:24 | `agent-portal-0.1.1-promote-2026-07-11` | cursor | em | Q1 GO agent-portal → PREPROD | agent-portal 0.1.1 | ok | evidence\q1\SUMMARY.md |
| 2026-07-11 21:23 | `agent-portal-0.1.1-promote-2026-07-11` | cursor | security | Q1 PASS CSS client + JWT APIs | agent-portal 0.1.1 | ok | evidence\q1\security\checklist.md |
| 2026-07-11 21:23 | `agent-portal-0.1.1-promote-2026-07-11` | cursor | review | Q1 PASS F:/4080 + SYSTEM_E2E_LOOP in JAR | agent-portal 0.1.1 | ok | evidence\q1\review\notes.md |
| 2026-07-11 21:20 | `agent-portal-0.1.1-promote-2026-07-11` | cursor | em | Start promote 0.1.1 — prod lacked SYSTEM_E2E_LOOP | H:\releases\agent-portal-0.1.1 | ok | User asked promote if not configured |
| 2026-07-11 19:40 | `stack-pilot-promote-2026-07-11` | cursor | ops | Sole cutover: stop DEV :8091 + PREPROD :4091 | G:\apps\stack-pilot :5091 | ok | Host+API 200; H: prune still needs named folder |
| 2026-07-11 18:42 | `stack-pilot-promote-2026-07-11` | cursor | em | Q2 closed PROD LIVE stack-pilot | control.delena.buzz :5091 | ok | evidence\q2\; H: retention 4>3 pending user prune |
| 2026-07-11 18:40 | `stack-pilot-promote-2026-07-11` | cursor | qa | Q2 prod smoke :5091 + Host control.delena.buzz | G:\apps\stack-pilot | ok | evidence\q2\qa\results.md |
| 2026-07-11 18:38 | `stack-pilot-promote-2026-07-11` | cursor | ops | Prod deploy G: :5091 + nginx cutover | G:\apps\stack-pilot | ok | evidence\q2\ops\deploy-log.md; wrapper blocked control subdomain |
| 2026-07-11 18:35 | `stack-pilot-promote-2026-07-11` | cursor | em | Q2 GO stack-pilot → PROD | stack-pilot 0.1.0 | ok | evidence\q2\SUMMARY.md; control.delena.buzz → :5091 |
| 2026-07-11 18:27 | `stack-pilot-promote-2026-07-11` | cursor | review | Q2 PASS ports/G:/H:; control subdomain nginx exception | stack-pilot 0.1.0 → G: :5091 | ok | evidence\q2\review\notes.md; review_pass+ports+db N/A |
| 2026-07-11 18:57 | `stack-pilot-promote-2026-07-11` | cursor | security | Q2 PASS CSS waived-public-read; CORS control.delena.buzz; api-key residual | stack-pilot 0.1.0 | ok | evidence\q2\security\checklist.md; security_pass + css_client_registered |
| 2026-07-11 18:56 | `stack-pilot-promote-2026-07-11` | cursor | qa | Q2 smoke+regression PREPROD :4091 | stack-pilot 0.1.0 | ok | evidence\q2\qa\results.md; qa_smoke_pass+qa_regression_pass=true; Q1 dest confirmed |
| 2026-07-11 18:30 | `stack-pilot-promote-2026-07-11` | cursor | em | Open Q2 stack-pilot PREPROD→PROD | stack-pilot 0.1.0 | ok | evidence\q2\SUMMARY.md PENDING; keep control.delena.buzz |
| 2026-07-11 18:30 | `stack-pilot-promote-2026-07-11` | cursor | qa | Q1 re-smoke PREPROD :4091 | F:\apps\stack-pilot | ok | UI+API 200; evidence\q1\ops\deploy-log.md |
| 2026-07-11 18:29 | `stack-pilot-promote-2026-07-11` | cursor | ops | Deploy+start preprod :4091 | F:\apps\stack-pilot | ok | evidence\q1\ops\deploy-log.md |
| 2026-07-11 18:28 | `stack-pilot-promote-2026-07-11` | cursor | em | Q1 GO stack-pilot → PREPROD | stack-pilot 0.1.0 | ok | evidence\q1\SUMMARY.md; :4091 |
| 2026-07-11 18:25 | `stack-pilot-promote-2026-07-11` | cursor | qa | Q1 smoke DEV :8091 + Host control.delena.buzz | stack-pilot 0.1.0 | ok | evidence\q1\qa\results.md; qa_smoke_pass=true |
| 2026-07-11 18:23 | `stack-pilot-promote-2026-07-11` | cursor | security | Q1 PASS CSS waived-public-read; secrets note redacted; staging host plan | stack-pilot 0.1.0 | ok | evidence\q1\security\checklist.md; security_pass + css_client_registered |
| 2026-07-11 18:23 | `stack-pilot-promote-2026-07-11` | cursor | review | Q1 PASS ports/F:/DB N/A; H: retention flag | stack-pilot 0.1.0 | ok | evidence\q1\review\notes.md; 4091; grok_dev on E: accepted; prune H: (4>3) |
| 2026-07-11 18:20 | `stack-pilot-promote-2026-07-11` | cursor | em | Start promote stack-pilot 0.1.0 Q1 then Q2 to PROD | E:\Source\stack-pilot | ok | Human requested prod; ports 3091/4091/5091; URL control.delena.buzz |
| 2026-07-11 17:40 | `myworkspace-hdrive-promote-2026-07-11` | cursor | em | Q2 GO h-drive-server â†’ PROD | h-drive-server 0.1.0 | ok | evidence\q2\SUMMARY.md; https://hdrive.delena.buzz |
| 2026-07-11 17:40 | `myworkspace-hdrive-promote-2026-07-11` | cursor | ops | Prod deploy DNS+nginx+start :5010 | G:\apps\h-drive-server | ok | evidence\q2\ops\deploy-log.md; fixed CF curl body + nginx BOM |
| 2026-07-11 17:40 | `myworkspace-hdrive-promote-2026-07-11` | cursor | qa | Q2 preprod regression + prod smoke | :4010/:5010/nginx | ok | evidence\q2\qa\results.md |
| 2026-07-11 17:40 | `myworkspace-hdrive-promote-2026-07-11` | cursor | security | Q2 PASS waived-public-read + CORS * | h-drive-server | ok | evidence\q2\security\checklist.md |
| 2026-07-11 17:40 | `myworkspace-hdrive-promote-2026-07-11` | cursor | review | Q2 PASS ports/G:/H: | h-drive-server | ok | evidence\q2\review\notes.md |
| 2026-07-11 17:30 | `myworkspace-hdrive-promote-2026-07-11` | cursor | em | Q1 GO h-drive-server â†’ PREPROD | h-drive-server 0.1.0 | ok | evidence\q1\SUMMARY.md |
| 2026-07-11 17:30 | `myworkspace-hdrive-promote-2026-07-11` | cursor | ops | Deploy+start preprod :4010 | F:\apps\h-drive-server | ok | evidence\q1\ops\deploy-log.md |
| 2026-07-11 17:30 | `myworkspace-hdrive-promote-2026-07-11` | cursor | qa | Q1 smoke DEV+PREPROD | :3010/:4010 | ok | evidence\q1\qa\results.md |
| 2026-07-11 17:30 | `myworkspace-hdrive-promote-2026-07-11` | cursor | security | Q1 PASS CSS waived-public-read | h-drive-server | ok | evidence\q1\security\checklist.md |
| 2026-07-11 17:30 | `myworkspace-hdrive-promote-2026-07-11` | cursor | review | Q1 PASS ports/F: | h-drive-server | ok | evidence\q1\review\notes.md |
| 2026-07-11 17:06 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | Park dual-CLI subagent automation on roadmap | MyAgent ideas + agent-portal FUTURE/SUBAGENTS/ROADMAP | ok | Portal predefined pipelines TBD later |
| 2026-07-11 16:41 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | git init + public GitHub push | https://github.com/sivaram311/MyAgent | ok | secrets gitignored; main ff4abf6 |
| 2026-07-11 16:37 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | CONSCIOUS #12: update docs after every meaningful action | CONSCIOUS AGENTS activity README activity-documentation.mdc | ok | User-directed keep |
| 2026-07-11 16:28 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | Update agent-portal product docs for prod/staging/CSS/LOB | docs/OPS.md README DELENA-PROXY platform/* H: README | ok | Deployed envs + TEXT/@Lob rule documented |
| 2026-07-11 16:25 | `e2e-sanity-prod` | cursor | qa | Prod E2E: LOB+403 diagnose, fix @Lobâ†’TEXT, oid migrate, redeploy, API matrix | G:/F agent-portal :5080/:4080 | ok | H:\releases\agent-portal-0.1.0\evidence\e2e-sanity-prod.md |
| 2026-07-11 15:10 | `prod-jdbc-fix` | cursor | ops | Fix prod session JDBC (missing session_guidance) | G:/F agent-portal + prod/preprod DDL | ok | H:\releases\agent-portal-0.1.0\evidence\jdbc-fix.md |
| 2026-07-11 15:03 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | ops | Reset prod CSS admin password | app_css.prod users.admin + G:\apps\css\.env | ok | Verified login agent-portal via :5900; secret not logged |
| 2026-07-11 15:00 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | em | Q2 GO agent-portal to PROD | agent-portal 0.1.0 | ok | evidence\q2\SUMMARY.md; https://agent-portal.delena.buzz |
| 2026-07-11 15:00 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | ops | Deploy+start prod :5080 + DNS + nginx | G:\apps\agent-portal | ok | evidence\q2\ops\deploy-log.md; authâ†’CSS :5900 |
| 2026-07-11 15:00 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | qa | Q2 preprod regression + prod smoke | :4080/:5080/CF | ok | evidence\q2\qa\results.md |
| 2026-07-11 15:00 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | security | Q2 PASS CSS prod IdP | agent-portal | ok | evidence\q2\security\checklist.md |
| 2026-07-11 15:00 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | review | Q2 PASS ports/DB/G: | agent-portal | ok | evidence\q2\review\notes.md |
| 2026-07-11 14:56 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | em | Q1 GO agent-portal to PREPROD | agent-portal 0.1.0 | ok | evidence\q1\SUMMARY.md |
| 2026-07-11 14:56 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | ops | Deploy+start preprod :4080 + staging DNS | F:\apps\agent-portal | ok | evidence\q1\ops\deploy-log.md |
| 2026-07-11 14:56 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | qa | Q1 smoke preprod + CSS JWT | :4080 | ok | evidence\q1\qa\results.md |
| 2026-07-11 14:56 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | security | Q1 PASS | agent-portal | ok | evidence\q1\security\checklist.md |
| 2026-07-11 14:56 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | review | Q1 PASS | agent-portal | ok | evidence\q1\review\notes.md |
| 2026-07-11 14:52 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | em | Wire agent-portal to prod CSS; reserve ports/DB | 4080/5080 app_agent_portal | ok | release H:\releases\agent-portal-0.1.0 |
| 2026-07-11 14:48 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | User: keep all standing orders in mind | CONSCIOUS #1â€“11 + drives/ports/db/css/promote/activity | ok | Binding for this and future turns |
| 2026-07-11 14:25 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | ops | CSS preprod+prod on Postgres | app_css.preprod/.prod :4900/:5900 | ok | PgConnection; tables in schemas; evidence\postgres-cutover.md |
| 2026-07-11 14:21 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | ops | Reset postgres password + DDL app_css | PostgreSQL 18 :5432 | ok | secrets\postgres.env (gitignored); schemas/roles active |
| 2026-07-11 14:21 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | em | User directed: reset PG password; document all activity/subagents | css + workflow | ok | Closed H2 waiver for F/G |
| 2026-07-11 14:45 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | em | Q2 GO css to PROD | css PREPRODâ†’PROD | ok | evidence\q2\SUMMARY.md; https://css.delena.buzz |
| 2026-07-11 14:45 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | ops | Start prod :5900 + CF DNS + nginx | G:\apps\css | ok | triple-run :9000/:4900/:5900 kept live |
| 2026-07-11 14:45 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | qa | Preprod matrix + prod edge smoke | :4900/:5900/CF | ok | evidence\q2\qa\results.md |
| 2026-07-11 14:45 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | security | Q2 harden + PASS | prod keys/issuer/CORS/env pw | ok | evidence\q2\security\checklist.md |
| 2026-07-11 14:45 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | review | Q2 PASS (H2 then Postgres) | G: :5900 | ok | evidence\q2\review\notes.md |
| 2026-07-11 14:06 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | em | Q1 GO for css after evidence | css DEVâ†’PREPROD | ok | H:\releases\css-0.1.0\evidence\q1\SUMMARY.md |
| 2026-07-11 14:06 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | ops | Deploy+start CSS preprod :4900 | F:\apps\css | ok | evidence\q1\ops\deploy-log.md |
| 2026-07-11 14:06 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | qa | Smoke DEV+PREPROD CSS | :9000 and :4900 | ok | evidence\q1\qa\results.md |
| 2026-07-11 14:06 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | security | Security gate remediations + PASS | css preprod | ok | evidence\q1\security\checklist.md |
| 2026-07-11 14:06 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | review | Review PASS ports/F: dual-run | css Q1 | ok | evidence\q1\review\notes.md |
| 2026-07-11 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | Rules bind Cursor + Antigravity | `AGENTS.md`, CONSCIOUS #11 | ok | Provider-agnostic standing orders |
| 2026-07-11 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | Mandated activity documentation | `workflow/activity/` | ok | CONSCIOUS #10 |
| 2026-07-11 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | Promote evidence + skills | `workflow/promote/` | ok | User approved |
| 2026-07-11 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | CSS/ports/db/disk workflow bootstrap | E:\MyAgent | ok | Session foundation |
| 2026-07-11 14:06 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | ops | Deploy+start CSS preprod :4900 | F:\apps\css PID 16376 | ok | evidence\q1\ops\deploy-log.md; DEV :9000 kept |
| 2026-07-11 14:06 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | qa | Smoke DEV+PREPROD CSS | :9000 and :4900 | ok | evidence\q1\qa\results.md |
| 2026-07-11 14:06 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | security | Security gate remediations + PASS | css preprod | ok | evidence\q1\security\checklist.md |
| 2026-07-11 14:06 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | review | Review PASS ports/F: dual-run | css Q1 | ok | evidence\q1\review\notes.md; H2 waiver |
| 2026-07-11 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | Rules bind Cursor + Antigravity | `AGENTS.md`, CONSCIOUS #11 | ok | Provider-agnostic standing orders |
| 2026-07-11 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | Mandated activity documentation policy | `workflow/activity/` | ok | CONSCIOUS rule 10; `.cursor/rules/activity-documentation.mdc` |
| 2026-07-11 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | Locked promote evidence + skills | `workflow/promote/`, `.cursor/skills/promote-*` | ok | User approved |
| 2026-07-11 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | CSS mandatory for apps | `workflow/css/` | ok | `E:\MyWorkspace\centralized-security-system` |
| 2026-07-11 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | DB schema-per-env policy | `workflow/db/` | ok | User approved |
| 2026-07-11 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | Prod deploy wrapper | `E:\Source\Deployment\scripts\deploy-prod-app.ps1` | ok | Zone delena.buzz |
| 2026-07-11 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | Port reservation registry | `workflow/ports/` | ok | User keep |
| 2026-07-11 | `93d977cc-7c3b-4a37-b889-09d2e6676ed5` | cursor | general | Partition Eâ†’F/G/H env drives | Disk 0 | ok | User confirmed; C: untouched |

## Entry template (copy)

```md
| YYYY-MM-DD HH:mm | `<session-id>` | cursor\|antigravity\|other | em\|qa\|security\|review\|ops\|general | Short action | path or app@env | ok\|fail\|blocked\|skipped | path or note |
```

