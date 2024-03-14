# Function to check the status of: Administrative Templates (Computer) - MSS
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
		[string]$level,
        [string]$description,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber $level Ensure '$description' is set to '$recommendation': $status"
}

#Registry Values:
$RegPath1= "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$RegPath2= "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$RegPath3= "HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters"
$RegPath4= "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager"
$RegPath5= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security"
$RegPath6= "HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\Parameters"
$RegPath7= "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"


# 18.5.1 (L1) Ensure 'MSS: (AutoAdminLogon) Enable Automatic Logon (not recommended)' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "AutoAdminLogon" -expectedValue 0 -sectionNumber "18.5.1" -level "(L1)" -description "MSS: (AutoAdminLogon) Enable Automatic Logon (not recommended)" -recommendation "Disabled"

# 18.5.2 (L1) Ensure 'MSS: (DisableIPSourceRouting IPv6) IP source routing protection level (protects against packet spoofing)' is set to 'Enabled: Highest protection, source routing is completely disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "DisableIPSourceRouting" -expectedValue 0 -sectionNumber "18.5.2" -level "(L1)" -description "MSS: (DisableIPSourceRouting IPv6) IP source routing protection level (protects against packet spoofing)" -recommendation "Enabled: Highest protection, source routing is completely disabled"

# 18.5.3 (L1) Ensure 'MSS: (DisableIPSourceRouting) IP source routing protection level (protects against packet spoofing)' is set to 'Enabled: Highest protection, source routing is completely disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "DisableIPSourceRouting" -expectedValue 0 -sectionNumber "18.5.3" -level "(L1)" -description "MSS: (DisableIPSourceRouting) IP source routing protection level (protects against packet spoofing)" -recommendation "Enabled: Highest protection, source routing is completely disabled"

# 18.5.4 (L2) Ensure 'MSS: (DisableSavePassword) Prevent the dial-up password from being saved' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath6 -valueName "DisableSavePassword" -expectedValue 1 -sectionNumber "18.5.4" -level "(L2)" -description "MSS: (DisableSavePassword) Prevent the dial-up password from being saved" -recommendation "Enabled"

# 18.5.5 (L1) Ensure 'MSS: (EnableICMPRedirect) Allow ICMP redirects to override OSPF generated routes' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "EnableICMPRedirect" -expectedValue 0 -sectionNumber "18.5.5" -level "(L1)" -description "MSS: (EnableICMPRedirect) Allow ICMP redirects to override OSPF generated routes" -recommendation "Disabled"

# 18.5.6 (L2) Ensure 'MSS: (KeepAliveTime) How often keep-alive packets are sent in milliseconds' is set to 'Enabled: 300,000 or 5 minutes (recommended)'
Check-GPSetting -policyPath $RegPath7 -valueName "KeepAliveTime" -expectedValue 300,000 -sectionNumber "18.5.6" -level "(L2)" -description "MSS: (KeepAliveTime) How often keep-alive packets are sent in milliseconds" -recommendation "Enabled: 300,000 or 5 minutes"

# 18.5.7 (L1) Ensure 'MSS: (NoNameReleaseOnDemand) Allow the computer to ignore NetBIOS name release requests except from WINS servers' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath3 -valueName "NoNameReleaseOnDemand" -expectedValue 1 -sectionNumber "18.5.7" -level "(L1)" -description "MSS: (NoNameReleaseOnDemand) Allow the computer to ignore NetBIOS name release requests except from WINS servers" -recommendation "Enabled"

# 18.5.8 (L2) Ensure 'MSS: (PerformRouterDiscovery) Allow IRDP to detect and configure Default Gateway addresses (could lead to DoS)' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath7 -valueName "PerformRouterDiscovery" -expectedValue 0 -sectionNumber "18.5.8" -level "(L2)" -description "MSS: (PerformRouterDiscovery) Allow IRDP to detect and configure Default Gateway addresses (could lead to DoS)" -recommendation "Disabled"

# 18.5.9 (L1) Ensure 'MSS: (SafeDllSearchMode) Enable Safe DLL search mode (recommended)' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath4 -valueName "SafeDllSearchMode" -expectedValue 1 -sectionNumber "18.5.9" -level "(L1)" -description "MSS: (SafeDllSearchMode) Enable Safe DLL search mode (recommended)" -recommendation "Enabled"

# 18.5.10 (L1) Ensure 'MSS: (ScreenSaverGracePeriod) The time in seconds before the screen saver grace period expires (0 recommended)' is set to 'Enabled: 5 or fewer seconds'
Check-GPSetting -policyPath $RegPath1 -valueName "ScreenSaverGracePeriod" -expectedValue "5" -sectionNumber "18.5.10" -level "(L1)" -description "MSS: (ScreenSaverGracePeriod) The time in seconds before the screen saver grace period expires (0 recommended)" -recommendation "Enabled: 5 or fewer seconds"

# 18.5.11 (L2) Ensure 'MSS: (TcpMaxDataRetransmissions IPv6) How many times unacknowledged data is retransmitted' is set to 'Enabled: 3'
Check-GPSetting -policyPath $RegPath2 -valueName "TcpMaxDataRetransmissions" -expectedValue 3 -sectionNumber "18.5.11" -level "(L2)" -description "MSS: (TcpMaxDataRetransmissions IPv6) How many times unacknowledged data is retransmitted" -recommendation "Enabled: 3"

# 18.5.12 (L2) Ensure 'MSS: (TcpMaxDataRetransmissions) How many times unacknowledged data is retransmitted' is set to 'Enabled: 3'
Check-GPSetting -policyPath $RegPath2 -valueName "TcpMaxDataRetransmissions" -expectedValue 3 -sectionNumber "18.5.12" -level "(L2)" -description "MSS: (TcpMaxDataRetransmissions) How many times unacknowledged data is retransmitted" -recommendation "Enabled: 3"

# 18.5.13 (L1) Ensure 'MSS: (WarningLevel) Percentage threshold for the security event log at which the system will generate a warning' is set to 'Enabled: 90% or less'
Check-GPSetting -policyPath $RegPath5 -valueName "WarningLevel" -expectedValue 90 -sectionNumber "18.5.13" -level "(L1)" -description "MSS: (WarningLevel) Percentage threshold for the security event log at which the system will generate a warning" -recommendation "Enabled: 90% or less"
