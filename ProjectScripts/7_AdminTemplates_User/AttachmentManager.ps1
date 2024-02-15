# PowerShell Script to Check Administrative Templates (User) - Attachment Manager Policies Against CIS Benchmarks for Windows 11 Enterprise

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
Write-Host "Checking Administrative Templates (User) - Attachment Manager Policies against CIS Benchmarks..."

# Do not preserve zone information in file attachments
$preserveZoneInformation = Get-SecPolValue "HKEY_USERS\[USER SID]\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments\SaveZoneInformation"
if ($preserveZoneInformation -eq "2") {
    Write-Host "19.7.4.1 (L1) Ensure 'Do not preserve zone information in file attachments' is set to 'Disabled': Compliant"
} else {
    Write-Host "19.7.4.1 (L1) Ensure 'Do not preserve zone information in file attachments' is set to 'Disabled': Non-Compliant"
}

# Notify antivirus programs when opening attachments
$notifyAntivirusPrograms = Get-SecPolValue "HKEY_USERS\[USER SID]\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments\ScanWithAntivirus"
if ($notifyAntivirusPrograms -eq "1") {
    Write-Host "19.7.4.2 (L1) Ensure 'Notify antivirus programs when opening attachments' is set to 'Enabled': Compliant"
} else {
    Write-Host "19.7.4.2 (L1) Ensure 'Notify antivirus programs when opening attachments' is set to 'Enabled': Non-Compliant"
}

# Cleanup temporary file
Remove-Item $seceditExportPath -ErrorAction SilentlyContinue

# End of script
