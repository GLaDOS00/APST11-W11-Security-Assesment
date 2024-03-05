# PowerShell Script to Check Windows Defender Firewall with Advanced Security - Private Profile Settings Against CIS Benchmarks for Windows 11 Enterprise

# Function to get the firewall setting value from the registry
function Get-FirewallSetting {
    param (
        [string]$path,
        [string]$name
    )
    return (Get-ItemProperty -Path $path -Name $name -ErrorAction SilentlyContinue).$name
}

# Registry path for the Windows Defender Firewall with Advanced Security - Private Profile
$firewallPrivateProfilePath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile"

# 9.2.1 Ensure 'Windows Firewall: Private: Firewall state' is set to 'On (recommended)'
$firewallState = Get-FirewallSetting -path $firewallPrivateProfilePath -name "EnableFirewall"
if ($firewallState -eq 1) {
    Write-Host "9.2.1 (L1) Ensure 'Windows Firewall: Private: Firewall state' is set to 'On (recommended)': Compliant"
} else {
    Write-Host "9.2.1 (L1) Ensure 'Windows Firewall: Private: Firewall state' is set to 'On (recommended)': Non-Compliant"
}

# 9.2.2 Ensure 'Windows Firewall: Private: Inbound connections' is set to 'Block (default)'
$inboundConnections = Get-FirewallSetting -path $firewallPrivateProfilePath -name "DefaultInboundAction"
if ($inboundConnections -eq 1) {
    Write-Host "9.2.2 (L1) Ensure 'Windows Firewall: Private: Inbound connections' is set to 'Block (default)': Compliant"
} else {
    Write-Host "9.2.2 (L1) Ensure 'Windows Firewall: Private: Inbound connections' is set to 'Block (default)': Non-Compliant"
}

# 9.2.3 Ensure 'Windows Firewall: Private: Outbound connections' is set to 'Allow (default)'
$outboundConnections = Get-FirewallSetting -path $firewallPrivateProfilePath -name "DefaultOutboundAction"
if ($outboundConnections -eq 0) {
    Write-Host "9.2.3 (L1) Ensure 'Windows Firewall: Private: Outbound connections' is set to 'Allow (default)': Compliant"
} else {
    Write-Host "9.2.3 (L1) Ensure 'Windows Firewall: Private: Outbound connections' is set to 'Allow (default)': Non-Compliant"
}

# 9.2.4 Ensure 'Windows Firewall: Private: Settings: Display a notification' is set to 'No'
$displayNotification = Get-FirewallSetting -path $firewallPrivateProfilePath -name "DisableNotifications"
if ($displayNotification -eq 1) {
    Write-Host "9.2.4 (L1) Ensure 'Windows Firewall: Private: Settings: Display a notification' is set to 'No': Compliant"
} else {
    Write-Host "9.2.4 (L1) Ensure 'Windows Firewall: Private: Settings: Display a notification' is set to 'No': Non-Compliant"
}

# 9.2.5 Ensure 'Windows Firewall: Private: Logging: Name' is set to the specified path
$loggingName = Get-FirewallSetting -path $firewallPrivateProfilePath -name "LogFileName"
if ($loggingName -eq "%SystemRoot%\System32\logfiles\firewall\privatefw.log") {
    Write-Host "9.2.5 (L1) Ensure 'Windows Firewall: Private: Logging: Name' is set correctly: Compliant"
} else {
    Write-Host "9.2.5 (L1) Ensure 'Windows Firewall: Private: Logging: Name' is set correctly: Non-Compliant"
}

# 9.2.6 Ensure 'Windows Firewall: Private: Logging: Size limit (KB)' is set to '16,384 KB or greater'
$loggingSize = Get-FirewallSetting -path $firewallPrivateProfilePath -name "LogFileSize"
if ($loggingSize -ge 16384) {
    Write-Host "9.2.6 (L1) Ensure 'Windows Firewall: Private: Logging: Size limit (KB)' is set to '16,384 KB or greater': Compliant"
} else {
    Write-Host "9.2.6 (L1) Ensure 'Windows Firewall: Private: Logging: Size limit (KB)' is set to '16,384 KB or greater': Non-Compliant"
}

# 9.2.7 Ensure 'Windows Firewall: Private: Logging: Log dropped packets' is set to 'Yes'
$logDroppedPackets = Get-FirewallSetting -path $firewallPrivateProfilePath -name "LogDroppedPackets"
if ($logDroppedPackets -eq 1) {
    Write-Host "9.2.7 (L1) Ensure 'Windows Firewall: Private: Logging: Log dropped packets' is set to 'Yes': Compliant"
} else {
    Write-Host "9.2.7 (L1) Ensure 'Windows Firewall: Private: Logging: Log dropped packets' is set to 'Yes': Non-Compliant"
}

# 9.2.8 Ensure 'Windows Firewall: Private: Logging: Log successful connections' is set to 'Yes'
$logSuccessfulConnections = Get-FirewallSetting -path $firewallPrivateProfilePath -name "LogSuccessfulConnections"
if ($logSuccessfulConnections -eq 1) {
    Write-Host "9.2.8 (L1) Ensure 'Windows Firewall: Private: Logging: Log successful connections' is set to 'Yes': Compliant"
} else {
    Write-Host "9.2.8 (L1) Ensure 'Windows Firewall: Private: Logging: Log successful connections' is set to 'Yes': Non-Compliant"
}

