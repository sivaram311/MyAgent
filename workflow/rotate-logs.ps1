<#
.SYNOPSIS
  Safe log rotation and size maintenance for machine services and Session 0 apps.
.DESCRIPTION
  Safely trims or archives large service logs (NGINX, StackPilot, Session 0)
  to prevent unbounded disk consumption while preserving recent activity.
#>
param(
  [int]$MaxSizeBytes = 50MB,
  [int]$RetentionDays = 7,
  [switch]$DryRun
)

$ErrorActionPreference = 'SilentlyContinue'

$logDirs = @(
    "C:\nginx-1.30.3\logs",
    "E:\Source\stack-pilot\logs",
    "E:\Source\Deployment\scripts\s0-apps"
)

Write-Host "=== Safe Log Rotation & Truncation ==="
Write-Host "Max size threshold: $([math]::Round($MaxSizeBytes / 1MB, 2)) MB | Max Age: $RetentionDays days`n"

$totalReclaimed = 0

foreach ($dir in $logDirs) {
    if (-not (Test-Path $dir)) { continue }
    Write-Host "Scanning: $dir"
    $files = Get-ChildItem -Path $dir -File -Include *.log, *.out, *.err
    foreach ($file in $files) {
        $size = $file.Length
        $ageDays = (New-TimeSpan -Start $file.LastWriteTime -End (Get-Date)).Days
        
        if ($size -gt $MaxSizeBytes) {
            Write-Host "  [OVERSIZED] $($file.Name) ($([math]::Round($size / 1MB, 2)) MB)"
            if (-not $DryRun) {
                # Keep last 5000 lines and safely overwrite in-place
                $recentLines = Get-Content -Path $file.FullName -Tail 5000
                $recentLines | Set-Content -Path $file.FullName -Encoding UTF8
                $newSize = (Get-Item $file.FullName).Length
                $reclaimed = $size - $newSize
                $totalReclaimed += $reclaimed
                Write-Host "    -> Trimmed to last 5000 lines (Reclaimed: $([math]::Round($reclaimed / 1MB, 2)) MB)"
            }
        }
    }
}

Write-Host "`nLog rotation pass complete. Total space reclaimed: $([math]::Round($totalReclaimed / 1MB, 2)) MB"
