# Define function to check App Package Deployment setting
function Check-AppPackageDeploymentSetting {
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

# 18.10.3.2 Ensure 'Prevent non-admin users from installing packaged Windows apps' is set to 'Enabled'
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$valueName = "DisableWindowsConsumerFeatures"
$expectedValue = "1"
$recommendation = "Enabled"
Check-AppPackageDeploymentSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation
