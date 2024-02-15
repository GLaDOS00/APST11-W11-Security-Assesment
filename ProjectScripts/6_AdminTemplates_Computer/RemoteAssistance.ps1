# Define function to check Remote Assistance setting
function Check-RemoteAssistanceSetting {
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

# 18.9.34.1 Ensure 'Configure Offer Remote Assistance' is set to 'Disabled'
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$valueName = "fAllowUnsolicited"
$expectedValue = "0"
$recommendation = "Disabled"
Check-RemoteAssistanceSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.34.2 Ensure 'Configure Solicited Remote Assistance' is set to 'Disabled'
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$valueName = "fAllowToGetHelp"
$expectedValue = "0"
$recommendation = "Disabled"
Check-RemoteAssistanceSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation
