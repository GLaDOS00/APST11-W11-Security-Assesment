# Define function to check Group Policy setting
function Check-GroupPolicySetting {
    param (
        [string]$registryPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

    if ($currentValue -eq $null) {
        Write-Host "$valueName is not configured. Recommendation: $recommendation"
    } elseif ($currentValue.$valueName -eq $expectedValue) {
        Write-Host "$valueName is set to $expectedValue (Meets the recommendation)"
    } else {
        Write-Host "$valueName is set to $($currentValue.$valueName) (Does not meet the recommendation. Recommendation: $recommendation)"
    }
}

# 18.9.19.2 Ensure 'Configure registry policy processing: Do not apply during periodic background processing' is set to 'Enabled: FALSE'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\"
$valueName = "DisablePeriodicPolicy"
$expectedValue = "0"
$recommendation = "Enabled: FALSE"
Check-GroupPolicySetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.19.3 Ensure 'Configure registry policy processing: Process even if the Group Policy objects have not changed' is set to 'Enabled: TRUE'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\"
$valueName = "NoGPOListChanges"
$expectedValue = "1"
$recommendation = "Enabled: TRUE"
Check-GroupPolicySetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.19.4 Ensure 'Continue experiences on this device' is set to 'Disabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\"
$valueName = "NoConnectedUser"
$expectedValue = "1"
$recommendation = "Disabled"
Check-GroupPolicySetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.19.5 Ensure 'Turn off background refresh of Group Policy' is set to 'Disabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\"
$valueName = "NoBackgroundPolicy"
$expectedValue = "0"
$recommendation = "Disabled"
Check-GroupPolicySetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation
