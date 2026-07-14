# Port registry (source of truth)

**Mandatory:** update this file **before** binding a new port.  
Mirror every change in `registry.json`.

Status values: `active` | `reserved` | `legacy` | `retired`

---

## Shared infra

| Port | App ID | Env | Role | Status | Bind | Notes |
|------|--------|-----|------|--------|------|-------|
| 80 | nginx | shared | http | active | 0.0.0.0 | Reverse proxy |
| 443 | nginx | shared | https | reserved | â€” | TLS when enabled |
| 5432 | postgres | shared | db | active | :: | Shared PostgreSQL |
| 9000 | css | shared | http | active | :: | Centralized Security System (`E:\MyWorkspace\centralized-security-system`) |
| 3389 | rdp | shared | other | active | :: | Remote desktop |

---

## DEV (E:) â€” range 3000â€“3999

| Port | App ID | Role | Status | Path / process | Notes |
|------|--------|------|--------|----------------|-------|
| 3010 | h-drive-server | http | active | E:\MyWorkspace\h-drive-server | Exposes H:\ files/folders; open CORS |
| 3080 | agent-portal | http | reserved | E:\MyWorkspace\agent-portal | Preferred DEV API offset (migrate from legacy :8080) |
| 3091 | stack-pilot | http | reserved | E:\Source\stack-pilot | Preferred DEV offset (migrate from legacy :8091) |

| 3310 | agentverse | http | active | E:\MyWorkspace\agentverse-project | Next.js DEV UI (R3F); npm run dev -p 3310 |
| 3311 | agentverse-v2 | http | active | E:\MyWorkspace\agentverse-project | stable-v2 side deploy; feature/stable-v2; npm run next -p 3311; side-by-side — primary DEV may stay 3310 on other branches |
| 3312 | agentverse-upgrade | http | active | E:\MyWorkspace\agentverse-project | upgradation functionality side fleet; feature/upgradation-functionality; npm -p 3312; must NOT use 3310/3311 |
| 3320 | proddeck | http | reserved | E:\MyWorkspace\sandbox\proddeck | ProdDeck Next.js DEV; home.delena.buzz; npm run dev -p 3320 |
| 3330 | library | http | reserved | E:\MyWorkspace\sandbox\library | Library DEV; https://library-dev.delena.buzz → :3330 |

<!-- Add new DEV rows below -->

---

## PREPROD (F:) â€” range 4000â€“4999

| Port | App ID | Role | Status | Path / process | Notes |
|------|--------|------|--------|----------------|-------|
| 4010 | h-drive-server | http | active | F:\apps\h-drive-server | Staging expose of H:\; open CORS |
| 4080 | agent-portal | http | active | F:\apps\agent-portal | API; UI static via nginx; https://agent-portal-staging.delena.buzz |
| 4310 | agentverse | http | active | F:\apps\agentverse | AgentVerse 0.2.2 PREPROD; https://agentverse-staging.delena.buzz |
| 4311 | agentverse-v2 | http | active | F:\apps\agentverse-v2 | stable-v2 side PREPROD; https://agentverse-v2-staging.delena.buzz (must NOT use 4310) |
| 4312 | agentverse-upgrade | http | active | F:\apps\agentverse-upgrade | upgradation side PREPROD; https://agentverse-upgrade-staging.delena.buzz (must NOT use 4310/4311) |
| 4320 | proddeck | http | active | F:\apps\proddeck | ProdDeck PREPROD; https://home-staging.delena.buzz â†’ :4320; Q1 0.1.0 2026-07-13 |
| 4330 | library | http | reserved | F:\apps\library | Library PREPROD; https://library-staging.delena.buzz → :4330 (app not deployed yet) |
| 4900 | css | http | active | F:\apps\css | Preprod classic CSS IdP; keep live; do not replace with css-next |
| 4910 | css-next | http | active | F:\apps\css-next | Side-fleet PREPROD OAuth SSO 0.2.0; https://css-next-staging.delena.buzz → :4910; must NOT use 4900 |
| 4091 | stack-pilot | http | active | F:\apps\stack-pilot | PREPROD; https://control-staging.delena.buzz ? :4091 |

---

## PROD (G:) â€” range 5000â€“5999

| Port | App ID | Role | Status | Path / process | Notes |
|------|--------|------|--------|----------------|-------|
| 5080 | agent-portal | http | active | G:\apps\agent-portal | API; UI static via nginx; https://agent-portal.delena.buzz; authâ†’prod CSS :5900 |
| 5010 | h-drive-server | http | active | G:\apps\h-drive-server | https://hdrive.delena.buzz â†’ 127.0.0.1:5010 |
| 5900 | css | http | active | G:\apps\css | Prod classic CSS IdP; https://css.delena.buzz; keep live; do not replace with css-next |
| 5910 | css-next | http | active | G:\apps\css-next | Side-fleet PROD OAuth SSO 0.2.0; https://css-next.delena.buzz → :5910; must NOT use 5900 |
| 5091 | stack-pilot | http | active | G:\apps\stack-pilot | PROD; https://control.delena.buzz ? :5091; CF via cloudflare-dns.ps1 (wrapper blocks `control`) |

---

| 5310 | agentverse | http | active | G:\apps\agentverse | AgentVerse 0.2.2 PROD; https://agentverse.delena.buzz |
| 5311 | agentverse-v2 | http | active | G:\apps\agentverse-v2 | stable-v2 side PROD; https://agentverse-v2.delena.buzz (must NOT use 5310) |
| 5312 | agentverse-upgrade | http | active | G:\apps\agentverse-upgrade | upgradation side PROD; https://agentverse-upgrade.delena.buzz (must NOT use 5310/5311) |
| 5320 | proddeck | http | active | G:\apps\proddeck | ProdDeck PROD; https://home.delena.buzz |
| 5330 | library | http | reserved | G:\apps\library | Library PROD; https://library.delena.buzz → :5330 (app not deployed yet) |

## Legacy outside scheme (migrate later)

| Port | App ID | Env | Role | Status | Process | Notes |
|------|--------|-----|------|--------|---------|-------|
| 4200 | agent-portal | dev | http | legacy | node/ng | DEV UI (ng serve); public delena.buzz / |
| 8080 | agent-portal | dev | http | legacy | java | DEV API; migrate toward :3080 |
| 8081 | legacy-java-8081 | unknown | http | legacy | java | Identify owner |
| 8082 | legacy-java-8082 | unknown | http | legacy | java | Identify owner |
| 8091 | stack-pilot | dev | http | legacy | java | Stopped 2026-07-11 sole cutover; prod :5091 owns control.delena.buzz |


---

## Template (copy a row)

```md
| 3010 | my-app-web | http | reserved | E:\Source\my-app | block 3010â€“3014 |
```




