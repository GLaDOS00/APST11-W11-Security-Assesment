# Define function to check printer settings
function Check-PrinterSetting {
    param (
        [string]$registryPath,
        [string]$valueName,
        [int]$expectedValue,
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

# 18.7.1 Ensure 'Allow Print Spooler to accept client connections' is set to 'Disabled'
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Spooler"
$valueName = "Start"
$expectedValue = 4
$recommendation = "Disabled"
Check-PrinterSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.7.2 Ensure 'Configure Redirection Guard' is set to 'Enabled: Redirection Guard Enabled'
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint"
$valueName = "RestrictDriverInstallationToAdministrators"
$expectedValue = 1
$recommendation = "Enabled: Redirection Guard Enabled"
Check-PrinterSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.7.3 Ensure 'Configure RPC connection settings: Protocol to use for outgoing RPC connections' is set to 'Enabled: RPC over TCP'
$valueName = "NoWarningNoElevationOnInstall"
$expectedValue = 1
$recommendation = "Enabled: RPC over TCP"
Check-PrinterSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.7.4 Ensure 'Configure RPC connection settings: Use authentication for outgoing RPC connections' is set to 'Enabled: Default'
$valueName = "UpdatePromptSettings"
$expectedValue = 0
$recommendation = "Enabled: Default"
Check-PrinterSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.7.5 Ensure 'Configure RPC listener settings: Protocols to allow for incoming RPC connections' is set to 'Enabled: RPC over TCP'
$valueName = "NoWarningNoElevationOnUpdate"
$expectedValue = 1
$recommendation = "Enabled: RPC over TCP"
Check-PrinterSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.7.6 Ensure 'Configure RPC listener settings: Authentication protocol to use for incoming RPC connections:' is set to 'Enabled: Negotiate' or higher
$valueName = "InForest"
$expectedValue = 1
$recommendation = "Enabled: Negotiate or higher"
Check-PrinterSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.7.7 Ensure 'Configure RPC over TCP port' is set to 'Enabled: 0'
$valueName = "RpcTcpPort"
$expectedValue = 0
$recommendation = "Enabled: 0"
Check-PrinterSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.7.8 Ensure 'Limits print driver installation to Administrators' is set to 'Enabled'
$valueName = "InKerberos"
$expectedValue = 1
$recommendation = "Enabled"
Check-PrinterSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.7.9 Ensure 'Manage processing of Queue-specific files' is set to 'Enabled: Limit Queue-specific files to Color profiles'
$valueName = "DnsOnWire"
$expectedValue = 1
$recommendation = "Enabled: Limit Queue-specific files to Color profiles"
Check-PrinterSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.7.10 Ensure 'Point and Print Restrictions: When installing drivers for a new connection' is set to 'Enabled: Show warning and elevation prompt'
$valueName = "ShowWarningElevationPrompt"
$expectedValue = 1
$recommendation = "Enabled: Show warning and elevation prompt"
Check-PrinterSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.7.11 Ensure 'Point and Print Restrictions: When updating drivers for an existing connection' is set to 'Enabled: Show warning and elevation prompt'
$valueName = "ShowWarningElevationPromptOnUpdate"
$expectedValue = 1
$recommendation = "Enabled: Show warning and elevation prompt"
Check-PrinterSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation
