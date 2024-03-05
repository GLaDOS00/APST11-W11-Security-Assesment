# Function to check the status of: Administrative Templates (Computer) - MSS
function Check-MSS-Legacy-GPSettings {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
        [string]$description,
        [string]$settingStatus
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to '$settingStatus': $status"
}

#Registry Values:
$RegPath1= "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$RegPath2= "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$RegPath3= "HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters"
$RegPath4= "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager"
$RegPath5= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security"


# 18.5.1 (L1) Ensure 'MSS: (AutoAdminLogon) Enable Automatic Logon (not recommended)' is set to 'Disabled'
Check-MSS-Legacy-GPSettings -policyPath $RegPath1 -valueName "AutoAdminLogon" -expectedValue 0 -sectionNumber "18.5.1" -description "MSS: (AutoAdminLogon) Enable Automatic Logon (not recommended)" -settingStatus "Disabled"

# 18.5.2 (L1) Ensure 'MSS: (DisableIPSourceRouting IPv6) IP source routing protection level (protects against packet spoofing)' is set to 'Enabled: Highest protection, source routing is completely disabled'
Check-MSS-Legacy-GPSettings -policyPath $RegPath2 -valueName "DisableIPSourceRouting" -expectedValue 0 -sectionNumber "18.5.2" -description "MSS: (DisableIPSourceRouting IPv6) IP source routing protection level (protects against packet spoofing)" -settingStatus "Enabled: Highest protection, source routing is completely disabled"

# 18.5.3 (L1) Ensure 'MSS: (DisableIPSourceRouting) IP source routing protection level (protects against packet spoofing)' is set to 'Enabled: Highest protection, source routing is completely disabled'
Check-MSS-Legacy-GPSettings -policyPath $RegPath2 -valueName "DisableIPSourceRouting" -expectedValue 0 -sectionNumber "18.5.3" -description "MSS: (DisableIPSourceRouting) IP source routing protection level (protects against packet spoofing)" -settingStatus "Enabled: Highest protection, source routing is completely disabled"

# 18.5.5 (L1) Ensure 'MSS: (EnableICMPRedirect) Allow ICMP redirects to override OSPF generated routes' is set to 'Disabled'
Check-MSS-Legacy-GPSettings -policyPath $RegPath2 -valueName "EnableICMPRedirect" -expectedValue 0 -sectionNumber "18.5.5" -description "MSS: (EnableICMPRedirect) Allow ICMP redirects to override OSPF generated routes" -settingStatus "Disabled"

# 18.5.7 (L1) Ensure 'MSS: (NoNameReleaseOnDemand) Allow the computer to ignore NetBIOS name release requests except from WINS servers' is set to 'Enabled'
Check-MSS-Legacy-GPSettings -policyPath $RegPath3 -valueName "NoNameReleaseOnDemand" -expectedValue 1 -sectionNumber "18.5.7" -description "MSS: (NoNameReleaseOnDemand) Allow the computer to ignore NetBIOS name release requests except from WINS servers" -settingStatus "Enabled"

# 18.5.9 (L1) Ensure 'MSS: (SafeDllSearchMode) Enable Safe DLL search mode (recommended)' is set to 'Enabled'
Check-MSS-Legacy-GPSettings -policyPath $RegPath4 -valueName "SafeDllSearchMode" -expectedValue 1 -sectionNumber "18.5.9" -description "MSS: (SafeDllSearchMode) Enable Safe DLL search mode (recommended)" -settingStatus "Enabled"

# 18.5.10 (L1) Ensure 'MSS: (ScreenSaverGracePeriod) The time in seconds before the screen saver grace period expires (0 recommended)' is set to 'Enabled: 5 or fewer seconds'
Check-MSS-Legacy-GPSettings -policyPath $RegPath1 -valueName "ScreenSaverGracePeriod" -expectedValue "5" -sectionNumber "18.5.10" -description "MSS: (ScreenSaverGracePeriod) The time in seconds before the screen saver grace period expires (0 recommended)" -settingStatus "Enabled: 5 or fewer seconds"

# 18.5.13 (L1) Ensure 'MSS: (WarningLevel) Percentage threshold for the security event log at which the system will generate a warning' is set to 'Enabled: 90% or less'
Check-MSS-Legacy-GPSettings -policyPath $RegPath5 -valueName "WarningLevel" -expectedValue 90 -sectionNumber "18.5.13" -description "MSS: (WarningLevel) Percentage threshold for the security event log at which the system will generate a warning" -settingStatus "Enabled: 90% or less"
