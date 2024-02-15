# PowerShell Script to Check Administrative Templates (User) - Network Sharing Policies Against CIS Benchmarks for Windows 11 Enterprise

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
Write-Host "Checking Administrative Templates (User) - Network Sharing Policies against CIS Benchmarks..."

# Prevent users from sharing files within their profile
$preventFileSharing = Get-SecPolValue "HKEY_USERS\[USER SID]\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoInplaceSharing"
if ($preventFileSharing -eq "1") {
    Write-Host "19.7.25.1 (L1) Ensure 'Prevent users from sharing files within their profile.' is set to 'Enabled': Compliant"
} else {
    Write-Host "19.7.25.1 (L1) Ensure 'Prevent users from sharing files within their profile.' is set to 'Enabled': Non-Compliant"
}

# Cleanup temporary file
Remove-Item $seceditExportPath -ErrorAction SilentlyContinue

# End of script
