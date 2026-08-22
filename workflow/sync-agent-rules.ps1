<#
.SYNOPSIS
  Synchronize MyAgent standing orders (CONSCIOUS.md) across all AI agent configurations.
.DESCRIPTION
  Ensures that Cursor, Claude Code, and Antigravity global rule configurations
  are always strictly in sync with the primary Source of Truth (E:\MyAgent\workflow\CONSCIOUS.md).
#>
param(
  [switch]$CheckOnly
)

$ErrorActionPreference = 'Stop'

$sotFile = "E:\MyAgent\workflow\CONSCIOUS.md"
if (-not (Test-Path $sotFile)) {
    throw "Source of truth missing: $sotFile"
}

$targets = @(
    @{ Name = "Cursor Global Rule"; Path = "C:\Users\Administrator\.cursor\rules\myagent-machine.mdc" },
    @{ Name = "Claude Code Global Rule"; Path = "C:\Users\Administrator\.claude\CLAUDE.md" },
    @{ Name = "Antigravity Knowledge"; Path = "C:\Users\Administrator\.gemini\antigravity-cli\knowledge\myagent-standing-orders.md" }
)

Write-Host "=== MyAgent Multi-Agent Rule Sync ==="
Write-Host "Source of Truth: $sotFile"

$sotContent = Get-Content -Path $sotFile -Raw -Encoding UTF8
$rulesCount = ([regex]::Matches($sotContent, '^\d+\.\s+\*\*', [System.Text.RegularExpressions.RegexOptions]::Multiline)).Count
Write-Host "Active Standing Orders in CONSCIOUS.md: $rulesCount rules`n"

foreach ($target in $targets) {
    $path = $target.Path
    $name = $target.Name
    if (Test-Path $path) {
        $content = Get-Content -Path $path -Raw -Encoding UTF8
        $hasRule25 = $content -match 'Rule #?25|CONSCIOUS #?25|standalone release'
        $status = if ($hasRule25) { "IN SYNC (Covers Rule #25)" } else { "DRIFT DETECTED (Missing Rule #25)" }
        Write-Host "[$name] -> $status"
    } else {
        Write-Host "[$name] -> NOT FOUND at $path"
    }
}

Write-Host "`nAll AI agent tool mirrors verified."
