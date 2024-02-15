# Define function to check App Runtime setting
function Check-AppRuntimeSetting {
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

# 18.10.5.1 Ensure 'Allow Microsoft accounts to be optional' is set to 'Enabled'
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\RuntimeBroker"
$valueName = "AllowMicrosoftAccountsToBeOptional"
$expectedValue = "1"
$recommendation = "Enabled"
Check-AppRuntimeSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation
