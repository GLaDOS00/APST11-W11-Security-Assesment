# Function to check the status of MSS (Legacy) Group Policy settings and output compliance
function Check-MSS-Legacy-GPSettings {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
        [string]$description,
        [string]$settingStatus # "Enabled" or "Disabled", matching the expected outcome in the description
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to '$settingStatus': $status"
}

# Define Group Policy paths and expected values for MSS (Legacy) settings
# Note: The expected values and paths are illustrative and may need adjustment to fit your environment

# AutoAdminLogon
Check-MSS-Legacy-GPSettings -policyPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -valueName "AutoAdminLogon" -expectedValue 0 -sectionNumber "18.5.1" -description "MSS: (AutoAdminLogon) Enable Automatic Logon (not recommended)" -settingStatus "Disabled"

# DisableIPSourceRouting IPv6
Check-MSS-Legacy-GPSettings -policyPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Rpc" -valueName "DisableIPSourceRouting" -expectedValue 0 -sectionNumber "18.5.2" -description "MSS: (DisableIPSourceRouting IPv6) IP source routing protection level (protects against packet spoofing)" -settingStatus "Enabled: Highest protection, source routing is completely disabled"

# DisableIPSourceRouting
Check-MSS-Legacy-GPSettings -policyPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Rpc" -valueName "DisableIPSourceRouting" -expectedValue 0 -sectionNumber "18.5.3" -description "MSS: (DisableIPSourceRouting) IP source routing protection level (protects against packet spoofing)" -settingStatus "Enabled: Highest protection, source routing is completely disabled"

# EnableICMPRedirect
Check-MSS-Legacy-GPSettings -policyPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Rpc" -valueName "EnableICMPRedirect" -expectedValue 0 -sectionNumber "18.5.5" -description "MSS: (EnableICMPRedirect) Allow ICMP redirects to override OSPF generated routes" -settingStatus "Disabled"

# NoNameReleaseOnDemand
Check-MSS-Legacy-GPSettings -policyPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Netlogon\Parameters" -valueName "NoNameReleaseOnDemand" -expectedValue 1 -sectionNumber "18.5.7" -description "MSS: (NoNameReleaseOnDemand) Allow the computer to ignore NetBIOS name release requests except from WINS servers" -settingStatus "Enabled"

# SafeDllSearchMode
Check-MSS-Legacy-GPSettings -policyPath "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" -valueName "SafeDllSearchMode" -expectedValue 1 -sectionNumber "18.5.9" -description "MSS: (SafeDllSearchMode) Enable Safe DLL search mode (recommended)" -settingStatus "Enabled"

# ScreenSaverGracePeriod
Check-MSS-Legacy-GPSettings -policyPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop" -valueName "ScreenSaverGracePeriod" -expectedValue "5" -sectionNumber "18.5.10" -description "MSS: (ScreenSaverGracePeriod) The time in seconds before the screen saver grace period expires (0 recommended)" -settingStatus "Enabled: 5 or fewer seconds"

# WarningLevel
Check-MSS-Legacy-GPSettings -policyPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security" -valueName "WarningLevel" -expectedValue 90 -sectionNumber "18.5.13" -description "MSS: (WarningLevel) Percentage threshold for the security event log at which the system will generate a warning" -settingStatus "Enabled: 90% or less"
