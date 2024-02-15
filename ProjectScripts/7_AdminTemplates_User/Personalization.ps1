# PowerShell Script to Check Administrative Templates (User) - Personalization Policies Against CIS Benchmarks for Windows 11 Enterprise

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
Write-Host "Checking Administrative Templates (User) - Personalization Policies against CIS Benchmarks..."

# Enable screen saver
$enableScreenSaver = Get-SecPolValue "EnableScreenSaver"
if ($enableScreenSaver -eq "1") {
    Write-Host "19.1.3.1 (L1) Ensure 'Enable screen saver' is set to 'Enabled': Compliant"
} else {
    Write-Host "19.1.3.1 (L1) Ensure 'Enable screen saver' is set to 'Enabled': Non-Compliant"
}

# Password protect the screen saver
$passwordProtectScreenSaver = Get-SecPolValue "ScreenSaverIsSecure"
if ($passwordProtectScreenSaver -eq "1") {
    Write-Host "19.1.3.2 (L1) Ensure 'Password protect the screen saver' is set to 'Enabled': Compliant"
} else {
    Write-Host "19.1.3.2 (L1) Ensure 'Password protect the screen saver' is set to 'Enabled': Non-Compliant"
}

# Screen saver timeout
$screenSaverTimeout = Get-SecPolValue "ScreenSaveTimeOut"
if ($screenSaverTimeout -le 900 -and $screenSaverTimeout -ne 0) {
    Write-Host "19.1.3.3 (L1) Ensure 'Screen saver timeout' is set to 'Enabled: 900 seconds or fewer, but not 0': Compliant"
} else {
    Write-Host "19.1.3.3 (L1) Ensure 'Screen saver timeout' is set to 'Enabled: 900 seconds or fewer, but not 0': Non-Compliant"
}

# Cleanup temporary file
Remove-Item $seceditExportPath -ErrorAction SilentlyContinue

# End of script
