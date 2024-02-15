# Define function to check Power Management setting
function Check-PowerManagementSetting {
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

# 18.9.32.6.1 Ensure 'Allow network connectivity during connected-standby (on battery)' is set to 'Disabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "DCSettingIndex"
$expectedValue = "0"
$recommendation = "Disabled"
Check-PowerManagementSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.32.6.2 Ensure 'Allow network connectivity during connected-standby (plugged in)' is set to 'Disabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "ACSettingIndex"
$expectedValue = "0"
$recommendation = "Disabled"
Check-PowerManagementSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.32.6.5 Ensure 'Require a password when a computer wakes (on battery)' is set to 'Enabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "InactivityTimeoutSecs"
$expectedValue = "60"
$recommendation = "Enabled"
Check-PowerManagementSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.32.6.6 Ensure 'Require a password when a computer wakes (plugged in)' is set to 'Enabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "InactivityTimeoutSecs"
$expectedValue = "60"
$recommendation = "Enabled"
Check-PowerManagementSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation
