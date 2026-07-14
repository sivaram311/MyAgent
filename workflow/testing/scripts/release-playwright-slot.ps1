<#
.SYNOPSIS
  Release / confirm the Playwright slot after a test run.
#>
param(
  [Parameter(Mandatory = $true)][string]$SessionId,
  [ValidateSet("pass", "fail", "aborted", "skipped")][string]$Result = "pass",
  [string]$Notes = "",
  [switch]$Force
)

$ErrorActionPreference = "Stop"
$slotPath = "E:\MyAgent\workflow\testing\playwright-slot.json"
$lockPath = "E:\MyAgent\workflow\testing\playwright-slot.lock"

function Read-Slot {
  return (Get-Content $slotPath -Raw -Encoding UTF8 | ConvertFrom-Json)
}

function Write-Slot($obj) {
  $obj.updated = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssK")
  $utf8 = New-Object System.Text.UTF8Encoding $false
  [IO.File]::WriteAllText($slotPath, (($obj | ConvertTo-Json -Depth 8) + "`n"), $utf8)
}

$fs = $null
try {
  $fs = [System.IO.File]::Open($lockPath, [System.IO.FileMode]::OpenOrCreate, [System.IO.FileAccess]::ReadWrite, [System.IO.FileShare]::None)
} catch {
  Write-Error "Could not acquire release lock file. Retry shortly."
  exit 1
}

try {
  $slot = Read-Slot
  $now = Get-Date
  if ($slot.status -eq "held" -and $null -ne $slot.holder) {
    if (-not $Force -and $slot.holder.sessionId -ne $SessionId) {
      Write-Output ("DENIED holder.sessionId={0} your.sessionId={1} (use -Force only as Lead for stale)" -f $slot.holder.sessionId, $SessionId)
      exit 2
    }
  }

  $slot.lastRelease = [pscustomobject]@{
    sessionId  = $SessionId
    releasedAt = $now.ToString("yyyy-MM-ddTHH:mm:ssK")
    result     = $Result
    notes      = $Notes
    wasHolder  = if ($slot.holder) { $slot.holder.sessionId } else { $null }
  }
  $slot.status = "free"
  $slot.holder = $null
  Write-Slot $slot
  Write-Output ("RELEASED sessionId={0} result={1}" -f $SessionId, $Result)
  exit 0
}
finally {
  if ($fs) { $fs.Dispose() }
}
