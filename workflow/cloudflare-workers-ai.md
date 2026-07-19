# Cloudflare Workers AI

Standing instruction for **MyAgent / mindmap / all agents** (see `workflow/CONSCIOUS.md` rule **19**).

## Credentials (secrets)

| Variable | Where | Notes |
|----------|-------|-------|
| `CLOUDFLARE_ACCOUNT_ID` | User env + `workflow/secrets/cloudflare-workers-ai.env` | Account `8fc0ee72771f63e73cb44383215a0786` |
| `CLOUDFLARE_WORKERS_AI_TOKEN` | User env + `workflow/secrets/cloudflare-workers-ai.env` | Workers AI API token (`cfut_…`) |

- Secrets live under **`workflow/secrets/`** (gitignored). Do **not** commit tokens.
- Do **not** overwrite `workflow/secrets/cloudflare.token` / agent-portal `CLOUDFLARE_API_TOKEN` (Zone Edit / DNS) with the Workers AI token — keep them separate.
- Load secrets into a shell:  
  `Get-Content E:\MyAgent\workflow\secrets\cloudflare-workers-ai.env | ForEach-Object { if ($_ -match '^(CLOUDFLARE_[A-Z0-9_]+)=(.*)$') { Set-Item -Path "Env:$($Matches[1])" -Value $Matches[2] } }`

## Verify token

```powershell
curl.exe -sS "https://api.cloudflare.com/client/v4/user/tokens/verify" `
  -H "Authorization: Bearer $env:CLOUDFLARE_WORKERS_AI_TOKEN"
```

Expect `"success":true` and `"status":"active"`.

## Sample Workers AI call

```powershell
$acct = $env:CLOUDFLARE_ACCOUNT_ID
$body = '{"messages":[{"role":"user","content":"Reply with exactly: ok"}]}'
curl.exe -sS -X POST "https://api.cloudflare.com/client/v4/accounts/$acct/ai/run/@cf/meta/llama-3.1-8b-instruct" `
  -H "Authorization: Bearer $env:CLOUDFLARE_WORKERS_AI_TOKEN" `
  -H "Content-Type: application/json" `
  --data $body
```

List models:  
`GET https://api.cloudflare.com/client/v4/accounts/{account_id}/ai/models/search`

## Related

- Zone / DNS credentials: `workflow/secrets/cloudflare.token` + `agent-portal/.env` (`CLOUDFLARE_API_TOKEN`, `CLOUDFLARE_ZONE_*`)
- Prod DNS wrapper: `workflow/prod-deploy.md`
- Mindmap awareness node: `E:\MyWorkspace\sandbox\mindmap` (Public edge / secrets)
