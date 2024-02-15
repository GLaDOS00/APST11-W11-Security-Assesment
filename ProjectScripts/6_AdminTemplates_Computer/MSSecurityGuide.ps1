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
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue

    if ($currentValue -eq $null) {
        Write-Host "$valueName is not configured. Recommendation: $recommendation"
    } elseif ($currentValue.$valueName -eq $expectedValue) {
        Write-Host "$valueName is set to $expectedValue (Meets the recommendation)"
    } else {
        Write-Host "$valueName is set to $($currentValue.$valueName) (Does not meet the recommendation. Recommendation: $recommendation)"
    }
}

# Check the status of 'Apply UAC restrictions to local accounts on network logons'
Check-MS-Security-Guide-GPSettings -policyPath $securityOptionsPolicyPath -valueName $uacLocalAccountsValueName -expectedValue 1 -recommendation "Enable"

# Check the status of 'Configure RPC packet level privacy setting for incoming connections'
Check-MS-Security-Guide-GPSettings -policyPath $rpcPrivacyPolicyPath -valueName $rpcPacketPrivacyValueName -expectedValue 1 -recommendation "Enable"

# Check the status of 'Configure SMB v1 client driver'
Check-MS-Security-Guide-GPSettings -policyPath $smbV1ClientPolicyPath -valueName $smbV1ClientDriverValueName -expectedValue 2 -recommendation "Enable: Disable driver (recommended)"

# Check the status of 'Configure SMB v1 server'
Check-MS-Security-Guide-GPSettings -policyPath $smbV1ServerPolicyPath -valueName $smbV1ServerValueName -expectedValue 0 -recommendation "Disable"

# Check the status of 'Enable Structured Exception Handling Overwrite Protection (SEHOP)'
Check-MS-Security-Guide-GPSettings -policyPath $sehopPolicyPath -valueName $sehopValueName -expectedValue 1 -recommendation "Enable"

# Check the status of 'NetBT NodeType configuration'
Check-MS-Security-Guide-GPSettings -policyPath $netBTNodeTypePolicyPath -valueName $netBTNodeTypeValueName -expectedValue 4 -recommendation "Enable: P-node (recommended)"

# Check the status of 'WDigest Authentication'
Check-MS-Security-Guide-GPSettings -policyPath $wdigestPolicyPath -valueName $wdigestValueName -expectedValue 0 -recommendation "Disable"
