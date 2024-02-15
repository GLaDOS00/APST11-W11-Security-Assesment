# Define function to check Biometrics setting
function Check-BiometricsSetting {
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

# 18.10.8.1.1 Ensure 'Configure enhanced anti-spoofing' is set to 'Enabled'
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics\Facial Features"
$valueName = "EnhancedAntiSpoofing"

$expectedValue = "1"
$recommendation = "Enabled"

# Call the function to check Biometrics setting
Check-BiometricsSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation
