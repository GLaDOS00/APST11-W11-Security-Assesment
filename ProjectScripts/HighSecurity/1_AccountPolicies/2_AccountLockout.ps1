# PowerShell Script to Check Account Lockout Policies Against CIS Benchmarks for Windows 11 Enterprise

# Export the security settings to a temporary file
$seceditExportPath = "$env:TEMP\secpol.cfg"
secedit /export /cfg $seceditExportPath /quiet

# Function to parse the exported security settings file for a specific policy value
function Get-SecPolValue {
    param (
        [string]$policyName
    )
    $content = Get-Content -Path $seceditExportPath
    foreach ($line in $content) {
        if ($line.StartsWith($policyName)) {
            return $line.Split('=')[1].Trim()
        }
    }
}

# Check each policy

# Account lockout duration
$lockoutDuration = Get-SecPolValue "LockoutDuration"
if ($lockoutDuration -ge 15) {
    Write-Host "1.2.1 (L1) Ensure 'Account lockout duration' is set to '15 or more minute(s)': Compliant"
} else {
    Write-Host "1.2.1 (L1) Ensure 'Account lockout duration' is set to '15 or more minute(s)': Non-Compliant"
}

# Account lockout threshold
$lockoutThreshold = Get-SecPolValue "LockoutBadCount"
if ($lockoutThreshold -le 5 -and $lockoutThreshold -ne 0) {
    Write-Host "1.2.2 (L1) Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0': Compliant"
} else {
    Write-Host "1.2.2 (L1) Ensure 'Account lockout threshold' is set to '5 or fewer invalid logon attempt(s), but not 0': Non-Compliant"
}

# Reset account lockout counter after
$resetLockoutCounter = Get-SecPolValue "ResetLockoutCount"
if ($resetLockoutCounter -ge 15) {
    Write-Host "1.2.4 (L1) Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)': Compliant"
} else {
    Write-Host "1.2.4 (L1) Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)': Non-Compliant"
}

# Cleanup temporary file
Remove-Item $seceditExportPath -ErrorAction SilentlyContinue

# End of script