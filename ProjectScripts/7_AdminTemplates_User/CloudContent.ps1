# PowerShell Script to Check Administrative Templates (User) - Cloud Content Policies Against CIS Benchmarks for Windows 11 Enterprise

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
Write-Host "Checking Administrative Templates (User) - Cloud Content Policies against CIS Benchmarks..."

# Configure Windows spotlight on lock screen
$configureWindowsSpotlight = Get-SecPolValue "HKEY_USERS\[USER SID]\Software\Policies\Microsoft\Windows\CloudContent\ConfigureWindowsSpotlight"
if ($configureWindowsSpotlight -eq "0") {
    Write-Host "19.7.7.1 (L1) Ensure 'Configure Windows spotlight on lock screen' is set to 'Disabled': Compliant"
} else {
    Write-Host "19.7.7.1 (L1) Ensure 'Configure Windows spotlight on lock screen' is set to 'Disabled': Non-Compliant"
}

# Do not suggest third-party content in Windows spotlight
$suggestThirdPartyContent = Get-SecPolValue "HKEY_USERS\[USER SID]\Software\Policies\Microsoft\Windows\CloudContent\DisableThirdPartySuggestions"
if ($suggestThirdPartyContent -eq "1") {
    Write-Host "19.7.7.2 (L1) Ensure 'Do not suggest third-party content in Windows spotlight' is set to 'Enabled': Compliant"
} else {
    Write-Host "19.7.7.2 (L1) Ensure 'Do not suggest third-party content in Windows spotlight' is set to 'Enabled': Non-Compliant"
}

# Turn off Spotlight collection on Desktop
$turnOffSpotlightCollection = Get-SecPolValue "HKEY_USERS\[USER SID]\Software\Policies\Microsoft\Windows\CloudContent\DisableWindowsSpotlightFeatures"
if ($turnOffSpotlightCollection -eq "1") {
    Write-Host "19.7.7.5 (L1) Ensure 'Turn off Spotlight collection on Desktop' is set to 'Enabled': Compliant"
} else {
    Write-Host "19.7.7.5 (L1) Ensure 'Turn off Spotlight collection on Desktop' is set to 'Enabled': Non-Compliant"
}

# Cleanup temporary file
Remove-Item $seceditExportPath -ErrorAction SilentlyContinue

# End of script
