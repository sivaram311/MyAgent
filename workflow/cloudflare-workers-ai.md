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

```powershell
Get-Content E:\MyAgent\workflow\secrets\cloudflare-workers-ai.env | ForEach-Object {
  if ($_ -match '^(CLOUDFLARE_[A-Z0-9_]+)=(.*)$') {
    Set-Item -Path "Env:$($Matches[1])" -Value $Matches[2]
  }
}
```

## Verify token

```powershell
curl.exe -sS "https://api.cloudflare.com/client/v4/user/tokens/verify" `
  -H "Authorization: Bearer $env:CLOUDFLARE_WORKERS_AI_TOKEN"
```

Expect `"success":true` and `"status":"active"`.

## Fetch available models

Catalog endpoint (Workers AI token works):

```powershell
$acct = $env:CLOUDFLARE_ACCOUNT_ID
$tok  = $env:CLOUDFLARE_WORKERS_AI_TOKEN
$j = curl.exe -sS "https://api.cloudflare.com/client/v4/accounts/$acct/ai/models/search?per_page=100" `
  -H "Authorization: Bearer $tok" | ConvertFrom-Json
"total=$($j.result_info.total_count) success=$($j.success)"
$j.result | Group-Object { $_.task.name } | Sort-Object Count -Descending |
  ForEach-Object { "{0,4}  {1}" -f $_.Count, $_.Name }
# filter one task, e.g. Text Generation:
$j.result | Where-Object { $_.task.name -eq 'Text Generation' } |
  Sort-Object name | ForEach-Object { $_.name }
```

- As of 2026-07-19: **~275** models in catalog.
- Task buckets include Text Generation, Text-to-Image, Text Embeddings, ASR, TTS, Translation, classification, vision.
- Prefer listing live from the API over hardcoding model names in docs or code.

## Usage quota (neurons)

| Fact | Value |
|------|-------|
| Free daily allocation | **10,000 neurons / day** |
| Reset | **00:00 UTC** |
| Paid overage | Workers Paid · ~$0.011 / 1,000 neurons above free |
| Dashboard | Cloudflare → Workers AI (authoritative remaining balance) |

### Per-request neurons (always available with Workers AI token)

Every successful `ai/run` response includes header **`cf-ai-neurons`** (neurons consumed by that call). Capture it:

```powershell
$acct = $env:CLOUDFLARE_ACCOUNT_ID
$tok  = $env:CLOUDFLARE_WORKERS_AI_TOKEN
$hdr  = Join-Path $env:TEMP 'cf-ai-run.hdr'
$body = '{"messages":[{"role":"user","content":"hi"}]}'
Set-Content (Join-Path $env:TEMP 'cf-ai-run.json') $body -Encoding ascii -NoNewline
curl.exe -sS -D $hdr -X POST `
  "https://api.cloudflare.com/client/v4/accounts/$acct/ai/run/@cf/meta/llama-3.2-1b-instruct" `
  -H "Authorization: Bearer $tok" -H "Content-Type: application/json" `
  --data-binary "@$(Join-Path $env:TEMP 'cf-ai-run.json')" | Out-Null
Select-String -Path $hdr -Pattern 'cf-ai-neurons'
```

If inference fails with Workers AI error **4006**, the **daily free neuron allocation is exhausted** until the next UTC midnight (or Workers Paid is enabled).

### Account-level remaining quota (GraphQL)

Preferred query (needs a token with **Account Analytics** / Workers AI analytics read — **not** granted on the inference-only `cfut_` token alone):

```powershell
$acct = $env:CLOUDFLARE_ACCOUNT_ID
$tok  = $env:CLOUDFLARE_WORKERS_AI_TOKEN   # or a broader analytics-capable token
$dayStart = (Get-Date).ToUniversalTime().Date.ToString("yyyy-MM-dd'T'HH:mm:ss'Z'")
$end      = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd'T'HH:mm:ss'Z'")
$q = '{"query":"query { viewer { accounts(filter:{accountTag:\"'+$acct+'\"}) { aiInferenceAdaptiveGroups(limit:1, filter:{datetime_geq:\"'+$dayStart+'\", datetime_leq:\"'+$end+'\"}) { sum { totalNeurons } } } } }"}'
Set-Content (Join-Path $env:TEMP 'cf-ai-gql.json') $q -Encoding ascii -NoNewline
curl.exe -sS -X POST "https://api.cloudflare.com/client/v4/graphql" `
  -H "Authorization: Bearer $tok" -H "Content-Type: application/json" `
  --data-binary "@$(Join-Path $env:TEMP 'cf-ai-gql.json')"
```

- On success: `sum.totalNeurons` = neurons used today (UTC). Remaining ≈ `10000 - totalNeurons` on Free / free tier of Paid.
- If response is **`not authorized for that account`**: token lacks analytics — use the dashboard, or create/add an Account Analytics–capable token (store separately; still never commit).
- There is **no** working REST route `…/ai/usage` for this account (returns no-route / 400). Do not rely on it.

### Agent checklist when asked “what’s left?”

1. Load env secrets.
2. Fetch models via `ai/models/search` (live list).
3. Try GraphQL `aiInferenceAdaptiveGroups` for today’s `totalNeurons`.
4. If GraphQL unauthorized → report free allotment (10k/day) + that remaining must come from dashboard / analytics token; smoke `ai/run` and read `cf-ai-neurons`; note whether calls still succeed (not 4006).
5. Redact tokens in ACTIVITY-LOG.

## Sample Workers AI call

```powershell
$acct = $env:CLOUDFLARE_ACCOUNT_ID
$bodyPath = Join-Path $env:TEMP 'cf-ai-smoke.json'
Set-Content $bodyPath '{"messages":[{"role":"user","content":"Reply with exactly: ok"}]}' -Encoding ascii -NoNewline
curl.exe -sS -X POST "https://api.cloudflare.com/client/v4/accounts/$acct/ai/run/@cf/meta/llama-3.1-8b-instruct" `
  -H "Authorization: Bearer $env:CLOUDFLARE_WORKERS_AI_TOKEN" `
  -H "Content-Type: application/json" `
  --data-binary "@$bodyPath"
```

On Windows PowerShell, prefer `--data-binary @file` so JSON is not mangled.

## Related

- Zone / DNS credentials: `workflow/secrets/cloudflare.token` + `agent-portal/.env` (`CLOUDFLARE_API_TOKEN`, `CLOUDFLARE_ZONE_*`)
- Prod DNS wrapper: `workflow/prod-deploy.md`
- Pricing: https://developers.cloudflare.com/workers-ai/platform/pricing/
- Mindmap awareness: `E:\MyWorkspace\sandbox\mindmap\docs\CLOUDFLARE-WORKERS-AI.md`
