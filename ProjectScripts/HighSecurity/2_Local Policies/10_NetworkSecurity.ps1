# Function to check the status of: Local Policy - Microsoft Network Security
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
$RegPath1= "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$RegPath2= "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0"
$RegPath3= "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\pku2u"
$RegPath4= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters"
$RegPath5= "HKLM:\SYSTEM\CurrentControlSet\Services\LDAP"


# 2.3.11.1 (L1) Ensure 'Network security: Allow Local System to use computer identity for NTLM' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "UseMachineId" -expectedValue 1 -sectionNumber "2.3.11.1" -description "Network security: Allow Local System to use computer identity for NTLM" -recommendation "Enabled"

# 2.3.11.2 (L1) Ensure 'Network security: Allow LocalSystem NULL session fallback' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "AllowNullSessionFallback" -expectedValue 0 -sectionNumber "2.3.11.2" -description "Network security: Allow LocalSystem NULL session fallback" -recommendation "Disabled"

# 2.3.11.3 (L1) Ensure 'Network Security: Allow PKU2U authentication requests to this computer to use online identities' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath3 -valueName "AllowOnlineID" -expectedValue 0 -sectionNumber "2.3.11.3" -description "Network Security: Allow PKU2U authentication requests to this computer to use online identities" -recommendation "Disabled"

# 2.3.11.4 (L1) Ensure 'Network security: Configure encryption types allowed for Kerberos' is set to 'AES128_HMAC_SHA1, AES256_HMAC_SHA1, Future encryption types'
Check-GPSetting -policyPath $RegPath4 -valueName "SupportedEncryptionTypes" -expectedValue 2147483640 -sectionNumber "2.3.11.4" -description "Network security: Configure encryption types allowed for Kerberos" -recommendation "AES128_HMAC_SHA1, AES256_HMAC_SHA1, Future encryption types"

# 2.3.11.5 (L1) Ensure 'Network security: Do not store LAN Manager hash value on next password change' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "NoLMHash" -expectedValue 1 -sectionNumber "2.3.11.5" -description "Network security: Do not store LAN Manager hash value on next password change" -recommendation "Enabled"

# 2.3.11.7 (L1) Ensure 'Network security: LAN Manager authentication level' is set to 'Send NTLMv2 response only. Refuse LM & NTLM'
Check-GPSetting -policyPath $RegPath1 -valueName "LmCompatibilityLevel" -expectedValue 5 -sectionNumber "2.3.11.7" -description "Network security: LAN Manager authentication level" -recommendation "Send NTLMv2 response only. Refuse LM & NTLM"

# 2.3.11.8 (L1) Ensure 'Network security: LDAP client signing requirements' is set to 'Negotiate signing' or higher
Check-GPSetting -policyPath $RegPath5 -valueName "LDAPClientIntegrity" -expectedValue 1 -sectionNumber "2.3.11.8" -description "Network security: LDAP client signing requirements" -recommendation "Negotiate signing"

# 2.3.11.9 (L1) Ensure 'Network security: Minimum session security for NTLM SSP based (including secure RPC) clients' is set to 'Require NTLMv2 session security, Require 128-bit encryption'
Check-GPSetting -policyPath $RegPath2 -valueName "NTLMMinClientSec" -expectedValue 537395200 -sectionNumber "2.3.11.9" -description "Network security: Minimum session security for NTLM SSP based (including secure RPC) clients" -recommendation "Require NTLMv2 session security, Require 128-bit encryption"

# 2.3.11.10 (L1) Ensure 'Network security: Minimum session security for NTLM SSP based (including secure RPC) servers' is set to 'Require NTLMv2 session security, Require 128-bit encryption'
Check-GPSetting -policyPath $RegPath2 -valueName "NTLMMinServerSec" -expectedValue 537395200 -sectionNumber "2.3.11.10" -description "Network security: Minimum session security for NTLM SSP based (including secure RPC) servers" -recommendation "Require NTLMv2 session security, Require 128-bit encryption"