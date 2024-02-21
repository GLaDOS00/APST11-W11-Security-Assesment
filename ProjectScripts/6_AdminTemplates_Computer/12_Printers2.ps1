# Function to check the status of printer setting
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
        [string]$description,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to '$recommendation': $status"
}

# Define the registry path for settings
$PrinterPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$PointAndPrintPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint"
$RcpPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RCP"

# 18.7.1 Ensure 'Allow Print Spooler to accept client connections' is set to 'Disabled'
Check-GPSetting -policyPath $PrinterPath -valueName "RegisterSpoolerRemoteRpcEndPoint" -expectedValue 0 -sectionNumber "18.7.1" -description "Allow Print Spooler to accept client connections" -recommendation "Disabled"

# 18.7.2 Ensure 'Configure Redirection Guard' is set to 'Enabled: Redirection Guard Enabled'
Check-GPSetting -policyPath $PrinterPath -valueName "RedirectionguardPolicy" -expectedValue 1 -sectionNumber "18.7.2" -description "Configure Redirection Guard" -recommendation "Enabled: Redirection Guard Enabled"

# 18.7.3 Ensure 'Configure RPC connection settings: Protocol to use for outgoing RPC connections' is set to 'Enabled: RPC over TCP'
Check-GPSetting -policyPath $RcpPath -valueName "RpcUseNamedPipeProtocol" -expectedValue 1 -sectionNumber "18.7.3" -description "Configure RPC connection settings: Protocol to use for outgoing RPC connections" -recommendation "Enabled: RPC over TCP"

# 18.7.4 Ensure 'Configure RPC connection settings: Use authentication for outgoing RPC connections' is set to 'Enabled: Default'
Check-GPSetting -policyPath $RcpPath -valueName "RpcAuthentication" -expectedValue 1 -sectionNumber "18.7.4" -description "Configure RPC connection settings: Use authentication for outgoing RPC connections" -recommendation "Enabled: Default"

# 18.7.5 Ensure 'Configure RPC listener settings: Protocols to allow for incoming RPC connections' is set to 'Enabled: RPC over TCP'
Check-GPSetting -policyPath $RcpPath -valueName "RpcProtocols" -expectedValue 1 -sectionNumber "18.7.5" -description "Configure RPC listener settings: Protocols to allow for incoming RPC connections" -recommendation "Enabled: RPC over TCP"

# 18.7.6 Ensure 'Configure RPC listener settings: Authentication protocol to use for incoming RPC connections:' is set to 'Enabled: Negotiate' or higher
Check-GPSetting -policyPath $RcpPath -valueName "ForceKerberosForRpc" -expectedValue 1 -sectionNumber "18.7.6" -description "Configure RPC listener settings: Authentication protocol to use for incoming RPC connections:" -recommendation "Enabled: Negotiate' or higher"

# 18.7.7 Ensure 'Configure RPC over TCP port' is set to 'Enabled: 0'
Check-GPSetting -policyPath $RcpPath -valueName "RpcTcpPort" -expectedValue 0 -sectionNumber "18.7.7" -description "Configure RPC over TCP port" -recommendation "Enabled: 0"

# 18.7.8 Ensure 'Limits print driver installation to Administrators' is set to 'Enabled'
Check-GPSetting -policyPath $PointAndPrintPath -valueName "RestrictDriverInstallationToAdministrators" -expectedValue 1 -sectionNumber "18.7.8" -description "Limits print driver installation to Administrators" -recommendation "Enabled"

# 18.7.9 Ensure 'Manage processing of Queue-specific files' is set to 'Enabled: Limit Queue-specific files to Color profiles'
Check-GPSetting -policyPath $PointAndPrintPath -valueName "CopyFilesPolicy" -expectedValue 1 -sectionNumber "18.7.9" -description "Manage processing of Queue-specific files" -recommendation "Enabled: Show warning and elevation prompt"

# 18.7.10 Ensure 'Point and Print Restrictions: When installing drivers for a new connection' is set to 'Enabled: Show warning and elevation prompt'
Check-GPSetting -policyPath $PointAndPrintPath -valueName "NoWarningNoElevationOnInstall" -expectedValue 1 -sectionNumber "18.7.10" -description "Point and Print Restrictions: When installing drivers for a new connection" -recommendation "Enabled: Show warning and elevation prompt"

# 18.7.11 Ensure 'Point and Print Restrictions: When updating drivers for an existing connection' is set to 'Enabled: Show warning and elevation prompt'
Check-GPSetting -policyPath $PointAndPrintPath -valueName "UpdatePromptSettings" -expectedValue 1 -sectionNumber "18.7.11" -description "Point and Print Restrictions: When updating drivers for an existing connection" -recommendation "Enabled: Show warning and elevation prompt"