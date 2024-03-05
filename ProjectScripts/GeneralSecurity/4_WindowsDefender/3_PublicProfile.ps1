# PowerShell Script to Check Windows Defender Firewall with Advanced Security - Public Profile Settings Against CIS Benchmarks for Windows 11 Enterprise

# Function to get the firewall setting value from the registry
function Get-FirewallSetting {
    param (
        [string]$path,
        [string]$name
    )
    return (Get-ItemProperty -Path $path -Name $name -ErrorAction SilentlyContinue).$name
}

# Registry path for the Windows Defender Firewall with Advanced Security - Public Profile
$firewallPublicProfilePath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile"

# 9.3.1 Ensure 'Windows Firewall: Public: Firewall state' is set to 'On (recommended)'
$firewallState = Get-FirewallSetting -path $firewallPublicProfilePath -name "EnableFirewall"
if ($firewallState -eq 1) {
    Write-Host "9.3.1 (L1) Ensure 'Windows Firewall: Public: Firewall state' is set to 'On (recommended)': Compliant"
} else {
    Write-Host "9.3.1 (L1) Ensure 'Windows Firewall: Public: Firewall state' is set to 'On (recommended)': Non-Compliant"
}

# 9.3.2 Ensure 'Windows Firewall: Public: Inbound connections' is set to 'Block (default)'
$inboundConnections = Get-FirewallSetting -path $firewallPublicProfilePath -name "DefaultInboundAction"
if ($inboundConnections -eq 1) {
    Write-Host "9.3.2 (L1) Ensure 'Windows Firewall: Public: Inbound connections' is set to 'Block (default)': Compliant"
} else {
    Write-Host "9.3.2 (L1) Ensure 'Windows Firewall: Public: Inbound connections' is set to 'Block (default)': Non-Compliant"
}

# 9.3.3 Ensure 'Windows Firewall: Public: Outbound connections' is set to 'Allow (default)'
$outboundConnections = Get-FirewallSetting -path $firewallPublicProfilePath -name "DefaultOutboundAction"
if ($outboundConnections -eq 0) {
    Write-Host "9.3.3 (L1) Ensure 'Windows Firewall: Public: Outbound connections' is set to 'Allow (default)': Compliant"
} else {
    Write-Host "9.3.3 (L1) Ensure 'Windows Firewall: Public: Outbound connections' is set to 'Allow (default)': Non-Compliant"
}

# 9.3.4 Ensure 'Windows Firewall: Public: Settings: Display a notification' is set to 'No'
$displayNotification = Get-FirewallSetting -path $firewallPublicProfilePath -name "DisableNotifications"
if ($displayNotification -eq 1) {
    Write-Host "9.3.4 (L1) Ensure 'Windows Firewall: Public: Settings: Display a notification' is set to 'No': Compliant"
} else {
    Write-Host "9.3.4 (L1) Ensure 'Windows Firewall: Public: Settings: Display a notification' is set to 'No': Non-Compliant"
}

# 9.3.5 Ensure 'Windows Firewall: Public: Settings: Apply local firewall rules' is set to 'No'
$applyLocalFirewallRules = Get-FirewallSetting -path $firewallPublicProfilePath -name "AllowLocalPolicyMerge"
if ($applyLocalFirewallRules -eq 0) {
    Write-Host "9.3.5 (L1) Ensure 'Windows Firewall: Public: Settings: Apply local firewall rules' is set to 'No': Compliant"
} else {
    Write-Host "9.3.5 (L1) Ensure 'Windows Firewall: Public: Settings: Apply local firewall rules' is set to 'No': Non-Compliant"
}

# 9.3.6 Ensure 'Windows Firewall: Public: Settings: Apply local connection security rules' is set to 'No'
$applyLocalConnectionSecurityRules = Get-FirewallSetting -path $firewallPublicProfilePath -name "AllowLocalIPsecPolicyMerge"
if ($applyLocalConnectionSecurityRules -eq 0) {
    Write-Host "9.3.6 (L1) Ensure 'Windows Firewall: Public: Settings: Apply local connection security rules' is set to 'No': Compliant"
} else {
    Write-Host "9.3.6 (L1) Ensure 'Windows Firewall: Public: Settings: Apply local connection security rules' is set to 'No': Non-Compliant"
}

# 9.3.7 Ensure 'Windows Firewall: Public: Logging: Name' is set to the specified path
$loggingName = Get-FirewallSetting -path $firewallPublicProfilePath -name "LogFileName"
if ($loggingName -eq "%SystemRoot%\System32\logfiles\firewall\publicfw.log") {
    Write-Host "9.3.7 (L1) Ensure 'Windows Firewall: Public: Logging: Name' is set correctly: Compliant"
} else {
    Write-Host "9.3.7 (L1) Ensure 'Windows Firewall: Public: Logging: Name' is set correctly: Non-Compliant"
}

# 9.3.8 Ensure 'Windows Firewall: Public: Logging: Size limit (KB)' is set to '16,384 KB or greater'
$loggingSize = Get-FirewallSetting -path $firewallPublicProfilePath -name "LogFileSize"
if ($loggingSize -ge 16384) {
    Write-Host "9.3.8 (L1) Ensure 'Windows Firewall: Public: Logging: Size limit (KB)' is set to '16,384 KB or greater': Compliant"
} else {
    Write-Host "9.3.8 (L1) Ensure 'Windows Firewall: Public: Logging: Size limit (KB)' is set to '16,384 KB or greater': Non-Compliant"
}

# 9.3.9 Ensure 'Windows Firewall: Public: Logging: Log dropped packets' is set to 'Yes'
$logDroppedPackets = Get-FirewallSetting -path $firewallPublicProfilePath -name "LogDroppedPackets"
if ($logDroppedPackets -eq 1) {
    Write-Host "9.3.9 (L1) Ensure 'Windows Firewall: Public: Logging: Log dropped packets' is set to 'Yes': Compliant"
} else {
    Write-Host "9.3.9 (L1) Ensure 'Windows Firewall: Public: Logging: Log dropped packets' is set to 'Yes': Non-Compliant"
}

# 9.3.10 Ensure 'Windows Firewall: Public: Logging: Log successful connections' is set to 'Yes'
$logSuccessfulConnections = Get-FirewallSetting -path $firewallPublicProfilePath -name "LogSuccessfulConnections"
if ($logSuccessfulConnections -eq 1) {
    Write-Host "9.3.10 (L1) Ensure 'Windows Firewall: Public: Logging: Log successful connections' is set to 'Yes': Compliant"
} else {
    Write-Host "9.3.10 (L1) Ensure 'Windows Firewall: Public: Logging: Log successful connections' is set to 'Yes': Non-Compliant"
}
