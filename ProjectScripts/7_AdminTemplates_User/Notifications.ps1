# PowerShell Script to Check Administrative Templates (User) - Notifications Policies Against CIS Benchmarks for Windows 11 Enterprise

# Export the security settings to a temporary file
$seceditExportPath = "$env:TEMP\secpol.cfg"
secedit /export /cfg $seceditExportPath

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
Write-Host "Checking Administrative Templates (User) - Notifications Policies against CIS Benchmarks..."

# Turn off toast notifications on the lock screen
$turnOffToastNotifications = Get-SecPolValue "HKEY_USERS\[USER SID]\Software\Policies\Microsoft\Windows\Control Panel\Notifications\TurnOffToastNotificationsOnLockScreen"
if ($turnOffToastNotifications -eq "1") {
    Write-Host "19.5.1.1 (L1) Ensure 'Turn off toast notifications on the lock screen' is set to 'Enabled': Compliant"
} else {
    Write-Host "19.5.1.1 (L1) Ensure 'Turn off toast notifications on the lock screen' is set to 'Enabled': Non-Compliant"
}

# Cleanup temporary file
Remove-Item $seceditExportPath -ErrorAction SilentlyContinue

# End of script
