# Define function to check WLAN Service Group Policy setting
function Check-WLANServiceSetting {
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

# Specify the registry path, value name, expected value, and recommendation
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\WlanSvc"
$valueName = "EnableAutoConnectToWiFiSenseHotspots"
$expectedValue = "0"
$recommendation = "Disable"

# Call the function to check the WLAN Service setting
Check-WLANServiceSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

