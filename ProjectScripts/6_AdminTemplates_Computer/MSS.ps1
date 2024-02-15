# Define Group Policy paths for MSS (Legacy)
$mssAutoAdminLogonPolicyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$mssDisableIPSourceRoutingIPv6PolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\IPsec\Policy\Local"
$mssDisableIPSourceRoutingPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\IPsec\Policy\Local"
$mssEnableICMPRedirectPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\IPsec\Policy\Local"
$mssNoNameReleaseOnDemandPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Netlogon\Parameters"
$mssSafeDllSearchModePolicyPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows"
$mssScreenSaverGracePeriodPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop"
$mssWarningLevelPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security"

# Define Group Policy values for MSS (Legacy)
$autoAdminLogonValueName = "AutoAdminLogon"
$disableIPSourceRoutingIPv6ValueName = "NoDefaultExempt"
$disableIPSourceRoutingValueName = "NoDefaultExempt"
$enableICMPRedirectValueName = "NoDefaultExempt"
$noNameReleaseOnDemandValueName = "NoNameReleaseOnDemand"
$safeDllSearchModeValueName = "SafeDllSearchMode"
$screenSaverGracePeriodValueName = "ScreenSaverGracePeriod"
$warningLevelValueName = "WarningLevel"

# Function to check the status of MSS (Legacy) Group Policy settings
function Check-MSS-Legacy-GPSettings {
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

# Check the status of 'MSS: (AutoAdminLogon) Enable Automatic Logon (not recommended)'
Check-MSS-Legacy-GPSettings -policyPath $mssAutoAdminLogonPolicyPath -valueName $autoAdminLogonValueName -expectedValue 0 -recommendation "Disable"

# Check the status of 'MSS: (DisableIPSourceRouting IPv6) IP source routing protection level'
Check-MSS-Legacy-GPSettings -policyPath $mssDisableIPSourceRoutingIPv6PolicyPath -valueName $disableIPSourceRoutingIPv6ValueName -expectedValue 0 -recommendation "Enable: Highest protection, source routing is completely disabled"

# Check the status of 'MSS: (DisableIPSourceRouting) IP source routing protection level'
Check-MSS-Legacy-GPSettings -policyPath $mssDisableIPSourceRoutingPolicyPath -valueName $disableIPSourceRoutingValueName -expectedValue 0 -recommendation "Enable: Highest protection, source routing is completely disabled"

# Check the status of 'MSS: (EnableICMPRedirect) Allow ICMP redirects to override OSPF generated routes'
Check-MSS-Legacy-GPSettings -policyPath $mssEnableICMPRedirectPolicyPath -valueName $enableICMPRedirectValueName -expectedValue 0 -recommendation "Disable"

# Check the status of 'MSS: (NoNameReleaseOnDemand) Allow the computer to ignore NetBIOS name release requests except from WINS servers'
Check-MSS-Legacy-GPSettings -policyPath $mssNoNameReleaseOnDemandPolicyPath -valueName $noNameReleaseOnDemandValueName -expectedValue 1 -recommendation "Enable"

# Check the status of 'MSS: (SafeDllSearchMode) Enable Safe DLL search mode (recommended)'
Check-MSS-Legacy-GPSettings -policyPath $mssSafeDllSearchModePolicyPath -valueName $safeDllSearchModeValueName -expectedValue 1 -recommendation "Enable"

# Check the status of 'MSS: (ScreenSaverGracePeriod) The time in seconds before the screen saver grace period expires'
Check-MSS-Legacy-GPSettings -policyPath $mssScreenSaverGracePeriodPolicyPath -valueName $screenSaverGracePeriodValueName -expectedValue 5 -recommendation "Enable: 5 or fewer seconds"

# Check the status of 'MSS: (WarningLevel) Percentage threshold for the security event log at which the system will generate a warning'
Check-MSS-Legacy-GPSettings -policyPath $mssWarningLevelPolicyPath -valueName $warningLevelValueName -expectedValue 90 -recommendation "Enable: 90% or less"
