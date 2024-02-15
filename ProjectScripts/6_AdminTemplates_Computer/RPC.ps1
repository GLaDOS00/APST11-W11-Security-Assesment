# Define function to check RPC setting
function Check-RPCSetting {
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

# 18.9.35.1 Ensure 'Enable RPC Endpoint Mapper Client Authentication' is set to 'Enabled'
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Rpc"
$valueName = "EnableAuthEpResolution"
$expectedValue = "1"
$recommendation = "Enabled"
Check-RPCSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.35.2 Ensure 'Restrict Unauthenticated RPC clients' is set to 'Enabled: Authenticated'
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Rpc"
$valueName = "RestrictRemoteClients"
$expectedValue = "1"
$recommendation = "Enabled: Authenticated"
Check-RPCSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation
