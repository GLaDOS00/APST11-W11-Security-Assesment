# Define function to check App Privacy setting
function Check-AppPrivacySetting {
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

# 18.10.4.1 Ensure 'Let Windows apps activate with voice while the system is locked' is set to 'Enabled: Force Deny'
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"
$valueName = "LetAppsActivateWithVoice"
$expectedValue = "2"
$recommendation = "Enabled: Force Deny"
Check-AppPrivacySetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation
