# Function to check the status of: Administrative Templates (Computer) - Microsoft Solutions for Security Guide
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
$RegPath1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$RegPath2 = "HKLM:\SYSTEM\CurrentControlSet\Control\Print"
$RegPath3 = "HKLM:\SYSTEM\CurrentControlSet\Services\mrxsmb10"
$RegPath4 = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"
$RegPath5 = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"
$RegPath6 = "HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters"
$RegPath7 = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest"


# 18.4.1 (L1) Ensure 'Apply UAC restrictions to local accounts on network logons' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "LocalAccountTokenFilterPolicy" -expectedValue 1 -sectionNumber "18.4.1" -description "Apply UAC restrictions to local accounts on network logons" -recommendation "Enabled"

# 18.4.2 (L1) Ensure 'Configure RPC packet level privacy setting for incoming connections' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "RpcAuthnLevelPrivacyEnabled" -expectedValue 1 -sectionNumber "18.4.2" -description "Configure RPC packet level privacy setting for incoming connections" -recommendation "Enabled"

# 18.4.3 (L1) Ensure 'Configure SMB v1 client driver' is set to 'Enabled: Disable driver (recommended)'
Check-GPSetting -policyPath $RegPath3 -valueName "Start" -expectedValue 0 -sectionNumber "18.4.3" -description "Configure SMB v1 client driver" -recommendation "Enabled: Disable driver"

# 18.4.4 (L1) Ensure 'Configure SMB v1 server' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath4 -valueName "SMB1" -expectedValue 0 -sectionNumber "18.4.4" -description "Configure SMB v1 server" -recommendation "Disabled"

# 18.4.5 (L1) Ensure 'Enable Structured Exception Handling Overwrite Protection (SEHOP)' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath5 -valueName "DisableExceptionChainValidation" -expectedValue 1 -sectionNumber "18.4.5" -description "Enable Structured Exception Handling Overwrite Protection (SEHOP)" -recommendation "Enabled"

# 18.4.6 (L1) Ensure 'NetBT NodeType configuration' is set to 'Enabled: P-node (recommended)'
Check-GPSetting -policyPath $RegPath6 -valueName "NodeType" -expectedValue 4 -sectionNumber "18.4.6" -description "NetBT NodeType configuration" -recommendation "Enabled: P-node"

# 18.4.7 (L1) Ensure 'WDigest Authentication' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath7 -valueName "UseLogonCredential" -expectedValue 0 -sectionNumber "18.4.7" -description "WDigest Authentication" -recommendation "Disabled"