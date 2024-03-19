# Function to check the status of: Administrative Templates (Computer) - Printers
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


# Registry Values:
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC"
$RegPath3= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint"


# 18.7.1 (L1) Ensure 'Allow Print Spooler to accept client connections' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "RegisterSpoolerRemoteRpcEndPoint" -expectedValue 2 -sectionNumber "18.7.1" -description "Allow Print Spooler to accept client connections" -recommendation "Disabled"

# 18.7.2 (L1) Ensure 'Configure Redirection Guard' is set to 'Enabled: Redirection Guard Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "RedirectionguardPolicy" -expectedValue 1 -sectionNumber "18.7.2" -description "Configure Redirection Guard" -recommendation "Enabled: Redirection Guard Enabled"


# 18.7.3 (L1) Ensure 'Configure RPC connection settings: Protocol to use for outgoing RPC connections' is set to 'Enabled: RPC over TCP' 
Check-GPSetting -policyPath $RegPath2 -valueName "RpcUseNamedPipeProtocol" -expectedValue 1 -sectionNumber "18.7.3" -description "Configure RPC connection settings: Protocol to use for outgoing RPC connections" -recommendation "Enabled: RPC over TCP"


# 18.7.4 (L1) Ensure 'Configure RPC connection settings: Use authentication for outgoing RPC connections' is set to 'Enabled: Default'
Check-GPSetting -policyPath $RegPath2 -valueName "RpcAuthentication" -expectedValue 1 -sectionNumber "18.7.4" -description "Configure RPC connection settings: Use authentication for outgoing RPC connections" -recommendation "Enabled: Default"


# 18.7.5 (L1) Ensure 'Configure RPC listener settings: Protocols to allow for incoming RPC connections' is set to 'Enabled: RPC over TCP'
Check-GPSetting -policyPath $RegPath2 -valueName "RpcProtocols" -expectedValue 1 -sectionNumber "18.7.5" -description "Configure RPC listener settings: Protocols to allow for incoming RPC connections" -recommendation "Enabled: RPC over TCP"


# 18.7.6 (L1) Ensure 'Configure RPC listener settings: Authentication protocol to use for incoming RPC connections' is set to 'Enabled: Negotiate' or higher
Check-GPSetting -policyPath $RegPath2 -valueName "ForceKerberosForRpc" -expectedValue 1 -sectionNumber "18.7.6" -description "Configure RPC listener settings: Authentication protocol to use for incoming RPC connections" -recommendation "Enabled: Negotiate"


# 18.7.7 (L1) Ensure 'Configure RPC over TCP port' is set to 'Enabled: 0'
Check-GPSetting -policyPath $RegPath2 -valueName "RpcTcpPort" -expectedValue 0 -sectionNumber "18.7.7" -description "Configure RPC over TCP port" -recommendation "Enabled: 0"


# 18.7.8 (L1) Ensure 'Limits print driver installation to Administrators' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath3 -valueName "RestrictDriverInstallationToAdministrators" -expectedValue 1 -sectionNumber "18.7.8" -description "Limits print driver installation to Administrators" -recommendation "Enabled"


# 18.7.9 (L1) Ensure 'Manage processing of Queue-specific files' is set to 'Enabled: Limit Queue-specific files to Color profiles'
Check-GPSetting -policyPath $RegPath1 -valueName "CopyFilesPolicy" -expectedValue 1 -sectionNumber "18.7.9" -description "Manage processing of Queue-specific files" -recommendation "Enabled: Limit Queue-specific files to Color profiles"


# 18.7.10 (L1) Ensure 'Point and Print Restrictions: When installing drivers for a new connection' is set to 'Enabled: Show warning and elevation prompt'
Check-GPSetting -policyPath $RegPath3 -valueName "NoWarningNoElevationOnInstall" -expectedValue 0 -sectionNumber "18.7.10" -description "Point and Print Restrictions: When installing drivers for a new connection" -recommendation "Enabled: Show warning and elevation prompt"


# 18.7.11 (L1) Ensure 'Point and Print Restrictions: When updating drivers for an existing connection' is set to 'Enabled: Show warning and elevation prompt'
Check-GPSetting -policyPath $RegPath3 -valueName "UpdatePromptSettings" -expectedValue 0 -sectionNumber "18.7.11" -description "Point and Print Restrictions: When updating drivers for an existing connection" -recommendation "Enabled: Show warning and elevation prompt"
 
