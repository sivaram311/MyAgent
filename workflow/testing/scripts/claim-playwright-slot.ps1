<#
.SYNOPSIS
  Claim the machine-wide Playwright slot (max 1 runner).
.DESCRIPTION
  Exit 0 = claimed. Exit 2 = busy. Exit 1 = error.
#>
param(
  [Parameter(Mandatory = $true)][string]$SessionId,
  [ValidateSet("cursor", "antigravity", "claude-code", "grok", "other")][string]$Provider = "cursor",
  [Parameter(Mandatory = $true)][string]$AppId,
  [string]$Project = "all",
  [string]$AgentRole = "e2e",
  [switch]$ForceStale
)

$ErrorActionPreference = "Stop"
$slotPath = "E:\MyAgent\workflow\testing\playwright-slot.json"
$lockPath = "E:\MyAgent\workflow\testing\playwright-slot.lock"

function Read-Slot {
  if (-not (Test-Path $slotPath)) { throw "missing playwright-slot.json" }
  return (Get-Content $slotPath -Raw -Encoding UTF8 | ConvertFrom-Json)
}

function Write-Slot($obj) {
  $obj.updated = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssK")
  $utf8 = New-Object System.Text.UTF8Encoding $false
  [IO.File]::WriteAllText($slotPath, (($obj | ConvertTo-Json -Depth 8) + "`n"), $utf8)
}

# Exclusive file lock around claim
$fs = $null
try {
  $fs = [System.IO.File]::Open($lockPath, [System.IO.FileMode]::OpenOrCreate, [System.IO.FileAccess]::ReadWrite, [System.IO.FileShare]::None)
} catch {
  Write-Error "Could not acquire claim lock file (another claim in progress). Retry shortly."
  exit 1
}

try {
  $slot = Read-Slot
  $now = Get-Date
  if ($slot.status -eq "held" -and $null -ne $slot.holder) {
    $claimedAt = $null
    try { $claimedAt = [DateTime]::Parse($slot.holder.claimedAt) } catch { $claimedAt = $now.AddHours(-2) }
    $ageMin = ($now - $claimedAt).TotalMinutes
    $staleLimit = if ($slot.staleAfterMinutes) { [double]$slot.staleAfterMinutes } else { 15 }
    $isStale = $ageMin -ge $staleLimit
    
    # PID liveness auto-heal: check if holding process has terminated
    $pidDead = $false
    if ($slot.holder.pid -and -not (Get-Process -Id $slot.holder.pid -ErrorAction SilentlyContinue)) {
      $pidDead = $true
    }

    if (-not $isStale -and -not $pidDead -and -not $ForceStale) {
      Write-Output ("BUSY holder.sessionId={0} appId={1} project={2} role={3} claimedAt={4} pid={5}" -f `
        $slot.holder.sessionId, $slot.holder.appId, $slot.holder.project, $slot.holder.agentRole, $slot.holder.claimedAt, $slot.holder.pid)
      exit 2
    }
    if ($pidDead) {
      Write-Output ("PID_DEAD clearing orphaned holder sessionId={0} (pid={1} no longer running)" -f $slot.holder.sessionId, $slot.holder.pid)
    } else {
      Write-Output ("STALE_OR_FORCE clearing previous holder sessionId={0}" -f $slot.holder.sessionId)
    }
  }

  $slot.status = "held"
  $slot.holder = [pscustomobject]@{
    sessionId = $SessionId
    provider  = $Provider
    appId     = $AppId
    project   = $Project
    agentRole = $AgentRole
    claimedAt = $now.ToString("yyyy-MM-ddTHH:mm:ssK")
    pid       = $PID
  }
  Write-Slot $slot
  Write-Output ("CLAIMED sessionId={0} appId={1} project={2}" -f $SessionId, $AppId, $Project)
  $slot | ConvertTo-Json -Depth 8
  exit 0
}
finally {
  if ($fs) { $fs.Dispose() }
}
