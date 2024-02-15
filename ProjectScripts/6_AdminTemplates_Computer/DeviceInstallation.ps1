# Define function to check security setting
function Check-SecuritySetting {
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

# 18.9.7.2 Ensure 'Prevent device metadata retrieval from the Internet' is set to 'Enabled’
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata"
$valueName = "PreventDeviceMetadataFromNetwork"
$expectedValue = "1"
$recommendation = "Enabled"
Check-SecuritySetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation


