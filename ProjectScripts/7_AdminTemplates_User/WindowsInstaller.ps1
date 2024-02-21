# PowerShell Script to Check Administrative Templates (User) - Windows Installer Policies Against CIS Benchmarks for Windows 11 Enterprise

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

# Always install with elevated privileges
$alwaysInstallElevated = Get-SecPolValue "HKEY_USERS\[USER SID]\Software\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated"
if ($alwaysInstallElevated -eq "0") {
    Write-Host "19.7.40.1 (L1) Ensure 'Always install with elevated privileges' is set to 'Disabled': Compliant"
} else {
    Write-Host "19.7.40.1 (L1) Ensure 'Always install with elevated privileges' is set to 'Disabled': Non-Compliant"
}

# Cleanup temporary file
Remove-Item $seceditExportPath -ErrorAction SilentlyContinue

# End of script
