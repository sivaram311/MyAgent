# Prod deploy wrapper

Zone: **`delena.buzz`** (unchanged).  
Script: `E:\Source\Deployment\scripts\deploy-prod-app.ps1`

## What it does

1. Reserves a **PROD** port (`5000–5999`) in `workflow/ports`
2. Copies `H:\releases\<ReleaseId>` → `G:\apps\<AppId>` (optional)
3. Upserts Cloudflare DNS: `<subdomain>.delena.buzz` → `PUBLIC_HOST` (proxied)
4. Writes nginx conf from template → reloads nginx

Default is **dry-run**. Pass **`-Execute`** to apply.

## Usage

```powershell
cd E:\Source\Deployment\scripts

# Plan
.\deploy-prod-app.ps1 -AppId my-shop -Subdomain my-shop -Port 5010 -ReleaseId 2026-07-11-v1.0.0

# Apply
.\deploy-prod-app.ps1 -AppId my-shop -Subdomain my-shop -Port 5010 -ReleaseId 2026-07-11-v1.0.0 -Execute

# Auto port, DNS + nginx only
.\deploy-prod-app.ps1 -AppId my-shop -Subdomain my-shop -AutoPort -SkipReleaseCopy -Execute
```

## Paths

| Piece | Location |
|-------|----------|
| Wrapper | `E:\Source\Deployment\scripts\deploy-prod-app.ps1` |
| Nginx template | `E:\Source\Deployment\conf\templates\app.subdomain.conf.template` |
| Generated conf (repo) | `E:\Source\Deployment\conf\apps\<host>.conf` |
| Generated conf (live) | `C:\nginx-1.30.3\conf\apps\<host>.conf` |
| Cloudflare helper | `E:\MyWorkspace\agent-portal\scripts\cloudflare-dns.ps1` |
| Credentials | `E:\MyWorkspace\agent-portal\.env` (never commit) |
| Prod runtime | `G:\apps\<AppId>\` |
| Releases | `H:\releases\<ReleaseId>\` |

## Safety

- No overwrite of existing `G:\apps\<AppId>` without your confirmation
- Reserved names blocked: `www`, `control`, `auth`
- **Exception — Stack Pilot:** public host is `control.delena.buzz` → `:5091`. Because the wrapper blocks `control`, create/repair DNS manually:  
  `E:\MyWorkspace\agent-portal\scripts\cloudflare-dns.ps1 -Upsert -Name control -Proxied`  
  (Missing CF A caused NXDOMAIN outage 2026-07-11; nginx was already correct.)
- DNS delete is **not** in this wrapper (use cloudflare-dns.ps1 `-Delete` only when you confirm)
- Always dry-run first
- If the app uses Postgres: prod datasource must use schema **`prod`** in `app_<appId>` only — see `workflow/db/conventions.md`
- Auth: register CSS `clientId` and validate JWTs via CSS (`workflow/css/`) — do not add a private login stack
