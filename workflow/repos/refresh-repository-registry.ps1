[CmdletBinding()]
param(
    [string]$Owner = "sivaram311"
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$registryDir = $PSScriptRoot
$jsonPath = Join-Path $registryDir "registry.json"
$markdownPath = Join-Path $registryDir "REGISTRY.md"

$repos = gh repo list $Owner --limit 1000 --json `
    name,nameWithOwner,visibility,isPrivate,isArchived,isFork,defaultBranchRef,url,description,updatedAt |
    ConvertFrom-Json

if (-not $repos) {
    throw "No repositories returned for GitHub owner '$Owner'. Check gh authentication."
}

function Resolve-LocalRepositoryPath {
    param([Parameter(Mandatory)][string]$Name)

    $candidates = @(
        "E:\MyWorkspace\$Name",
        "E:\MyWorkspace\sandbox\$Name",
        "E:\Source\$Name",
        "E:\GitBackup\$Name"
    )

    if ($Name -eq "MyAgent") {
        $candidates = @("E:\MyAgent") + $candidates
    }
    if ($Name -eq "MyMachine") {
        $candidates = @("E:\MyWorkspace\MyMachine") + $candidates
    }

    foreach ($candidate in $candidates) {
        if (-not (Test-Path -LiteralPath $candidate -PathType Container)) {
            continue
        }

        $top = git -C $candidate rev-parse --show-toplevel 2>$null
        if ($LASTEXITCODE -ne 0) {
            continue
        }

        $remote = git -C $candidate remote get-url origin 2>$null
        if ($LASTEXITCODE -eq 0 -and $remote -match "/$([regex]::Escape($Name))(?:\.git)?$") {
            return ($top -replace "/", "\")
        }
    }

    return $null
}

$generatedAt = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$entries = @(
    foreach ($repo in ($repos | Sort-Object name)) {
        [ordered]@{
            name          = $repo.name
            owner         = $Owner
            url           = $repo.url
            visibility    = $repo.visibility
            defaultBranch = $repo.defaultBranchRef.name
            archived      = [bool]$repo.isArchived
            fork          = [bool]$repo.isFork
            localPath     = Resolve-LocalRepositoryPath -Name $repo.name
            description   = $repo.description
            updatedAt     = $repo.updatedAt
        }
    }
)

$snapshot = [ordered]@{
    schemaVersion = 1
    generatedAt   = $generatedAt
    owner         = $Owner
    source        = "gh repo list"
    total         = $entries.Count
    counts        = [ordered]@{
        public   = @($entries | Where-Object visibility -eq "PUBLIC").Count
        private  = @($entries | Where-Object visibility -eq "PRIVATE").Count
        internal = @($entries | Where-Object visibility -eq "INTERNAL").Count
        archived = @($entries | Where-Object archived).Count
        forks    = @($entries | Where-Object fork).Count
        local    = @($entries | Where-Object localPath).Count
    }
    repositories = $entries
}

$snapshot | ConvertTo-Json -Depth 6 | Set-Content -Path $jsonPath -Encoding utf8

$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add("# Repository registry")
$lines.Add("")
$lines.Add("Authoritative visibility inventory for GitHub owner **$Owner**.")
$lines.Add("")
$lines.Add("**Generated:** $generatedAt  ")
$lines.Add("**Source:** authenticated ``gh repo list``  ")
$lines.Add("**Total:** $($snapshot.total) | Public $($snapshot.counts.public) | Private $($snapshot.counts.private) | Internal $($snapshot.counts.internal) | Archived $($snapshot.counts.archived) | Forks $($snapshot.counts.forks) | Local paths found $($snapshot.counts.local)")
$lines.Add("")
$lines.Add("> Visibility is fetched from GitHub, not inferred from clone URLs. Regenerate after creating, deleting, transferring, archiving, renaming, or changing repository visibility.")
$lines.Add("")
$lines.Add("| Repository | Visibility | Default | Archived | Fork | Local path | Updated (UTC) |")
$lines.Add("|------------|------------|---------|----------|------|------------|---------------|")

foreach ($entry in $entries) {
    $localPath = if ($entry.localPath) { $entry.localPath } else { "-" }
    $lines.Add(('| [{0}]({1}) | **{2}** | `{3}` | {4} | {5} | `{6}` | {7} |' -f $entry.name, $entry.url, $entry.visibility, $entry.defaultBranch, $entry.archived, $entry.fork, $localPath, $entry.updatedAt))
}

$lines.Add("")
$lines.Add("## Refresh")
$lines.Add("")
$lines.Add("``````powershell")
$lines.Add("cd E:\MyAgent")
$lines.Add(".\workflow\repos\refresh-repository-registry.ps1")
$lines.Add("``````")
$lines.Add("")
$lines.Add("Review the diff, ensure no credentials are present, log the activity, then follow the reviewer-before-push rule.")

$lines | Set-Content -Path $markdownPath -Encoding utf8

Write-Host "Updated $markdownPath and $jsonPath"
Write-Host "Repositories: $($snapshot.total) (public=$($snapshot.counts.public), private=$($snapshot.counts.private), internal=$($snapshot.counts.internal))"
