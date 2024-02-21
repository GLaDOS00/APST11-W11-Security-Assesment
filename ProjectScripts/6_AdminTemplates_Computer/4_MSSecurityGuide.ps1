# Define Group Policy paths for MS Security Guide
$securityOptionsPolicyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$rpcPrivacyPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Rpc"
$smbV1ClientPolicyPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
$smbV1ServerPolicyPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"
$sehopPolicyPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options"
$netBTNodeTypePolicyPath = "HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters"
$wdigestPolicyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

# Define Group Policy values for MS Security Guide
$uacLocalAccountsValueName = "LocalAccountTokenFilterPolicy"
$rpcPacketPrivacyValueName = "RestrictRemoteClients"
$smbV1ClientDriverValueName = "SMB1"
$smbV1ServerValueName = "SMB1"
$sehopValueName = "EnableExceptionChainValidation"
$netBTNodeTypeValueName = "NodeType"
$wdigestValueName = "UseLogonCredential"

# Function to check the status of MS Security Guide Group Policy settings
function Check-MS-Security-Guide-GPSettings {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
        [string]$settingDescription
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber (L1) Ensure '$settingDescription' is set to '$expectedValue': $status"
}

# Implementing the checks with section numbers and specific compliance messages
Check-MS-Security-Guide-GPSettings -policyPath $securityOptionsPolicyPath -valueName $uacLocalAccountsValueName -expectedValue 1 -sectionNumber "18.4.1" -settingDescription "Apply UAC restrictions to local accounts on network logons"
Check-MS-Security-Guide-GPSettings -policyPath $rpcPrivacyPolicyPath -valueName $rpcPacketPrivacyValueName -expectedValue 1 -sectionNumber "18.4.2" -settingDescription "Configure RPC packet level privacy setting for incoming connections"
Check-MS-Security-Guide-GPSettings -policyPath $smbV1ClientPolicyPath -valueName $smbV1ClientDriverValueName -expectedValue 0 -sectionNumber "18.4.3" -settingDescription "Configure SMB v1 client driver: Disable driver (recommended)"
Check-MS-Security-Guide-GPSettings -policyPath $smbV1ServerPolicyPath -valueName $smbV1ServerValueName -expectedValue 0 -sectionNumber "18.4.4" -settingDescription "Configure SMB v1 server"
Check-MS-Security-Guide-GPSettings -policyPath $sehopPolicyPath -valueName $sehopValueName -expectedValue 1 -sectionNumber "18.4.5" -settingDescription "Enable Structured Exception Handling Overwrite Protection (SEHOP)"
Check-MS-Security-Guide-GPSettings -policyPath $netBTNodeTypePolicyPath -valueName $netBTNodeTypeValueName -expectedValue 4 -sectionNumber "18.4.6" -settingDescription "NetBT NodeType configuration: P-node (recommended)"
Check-MS-Security-Guide-GPSettings -policyPath $wdigestPolicyPath -valueName $wdigestValueName -expectedValue 0 -sectionNumber "18.4.7" -settingDescription "WDigest Authentication"