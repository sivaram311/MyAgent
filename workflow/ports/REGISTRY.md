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

<!-- Add new DEV rows below -->

---

## PREPROD (F:) â€” range 4000â€“4999

| Port | App ID | Role | Status | Path / process | Notes |
|------|--------|------|--------|----------------|-------|
| 4010 | h-drive-server | http | active | F:\apps\h-drive-server | Staging expose of H:\; open CORS |
| 4080 | agent-portal | http | active | F:\apps\agent-portal | API; UI static via nginx; https://agent-portal-staging.delena.buzz |
| 4310 | agentverse | http | active | F:\apps\agentverse | AgentVerse 0.1.0 PREPROD; https://agentverse-staging.delena.buzz |
| 4900 | css | http | active | F:\apps\css | Preprod CSS IdP (Q1 GO 2026-07-11); DEV shared remains :9000; host plan css-staging.delena.buzz |
| 4091 | stack-pilot | http | active | F:\apps\stack-pilot | Installed; process stopped 2026-07-11 sole cutover → prod :5091 |

---

## PROD (G:) â€” range 5000â€“5999

| Port | App ID | Role | Status | Path / process | Notes |
|------|--------|------|--------|----------------|-------|
| 5080 | agent-portal | http | active | G:\apps\agent-portal | API; UI static via nginx; https://agent-portal.delena.buzz; authâ†’prod CSS :5900 |
| 5010 | h-drive-server | http | active | G:\apps\h-drive-server | https://hdrive.delena.buzz â†’ 127.0.0.1:5010 |
| 5900 | css | http | active | G:\apps\css | Prod CSS IdP Q2 GO 2026-07-11; https://css.delena.buzz; keep :4900 and :9000 live |
| 5091 | stack-pilot | http | active | G:\apps\stack-pilot | Prod control plane; https://control.delena.buzz → :5091; CF A created 2026-07-11 (wrapper blocks `control` — DNS via cloudflare-dns.ps1) |

---

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




