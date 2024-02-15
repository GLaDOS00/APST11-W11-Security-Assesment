# PowerShell Script to Check Windows Defender Firewall with Advanced Security - Domain Profile Settings Against CIS Benchmarks for Windows 11 Enterprise

Write-Host "Checking Windows Defender Firewall with Advanced Security - Domain Profile settings against CIS Benchmarks..."

# Function to get the firewall setting value from the registry
function Get-FirewallSetting {
    param (
        [string]$path,
        [string]$name
    )
    return (Get-ItemProperty -Path $path -Name $name -ErrorAction SilentlyContinue).$name
}

# Registry path for the Windows Defender Firewall with Advanced Security - Domain Profile
$firewallDomainProfilePath = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile"

# 9.1.1 Ensure 'Windows Firewall: Domain: Firewall state' is set to 'On (recommended)'
$firewallState = Get-FirewallSetting -path $firewallDomainProfilePath -name "EnableFirewall"
if ($firewallState -eq 1) {
    Write-Host "9.1.1 (L1) Ensure 'Windows Firewall: Domain: Firewall state' is set to 'On (recommended)': Compliant"
} else {
    Write-Host "9.1.1 (L1) Ensure 'Windows Firewall: Domain: Firewall state' is set to 'On (recommended)': Non-Compliant"
}

# 9.1.2 Ensure 'Windows Firewall: Domain: Inbound connections' is set to 'Block (default)'
$inboundConnections = Get-FirewallSetting -path $firewallDomainProfilePath -name "DefaultInboundAction"
if ($inboundConnections -eq 1) {
    Write-Host "9.1.2 (L1) Ensure 'Windows Firewall: Domain: Inbound connections' is set to 'Block (default)': Compliant"
} else {
    Write-Host "9.1.2 (L1) Ensure 'Windows Firewall: Domain: Inbound connections' is set to 'Block (default)': Non-Compliant"
}

# 9.1.3 Ensure 'Windows Firewall: Domain: Outbound connections' is set to 'Allow (default)'
$outboundConnections = Get-FirewallSetting -path $firewallDomainProfilePath -name "DefaultOutboundAction"
if ($outboundConnections -eq 0) {
    Write-Host "9.1.3 (L1) Ensure 'Windows Firewall: Domain: Outbound connections' is set to 'Allow (default)': Compliant"
} else {
    Write-Host "9.1.3 (L1) Ensure 'Windows Firewall: Domain: Outbound connections' is set to 'Allow (default)': Non-Compliant"
}

# 9.1.4 Ensure 'Windows Firewall: Domain: Settings: Display a notification' is set to 'No'
$displayNotification = Get-FirewallSetting -path $firewallDomainProfilePath -name "DisableNotifications"
if ($displayNotification -eq 1) {
    Write-Host "9.1.4 (L1) Ensure 'Windows Firewall: Domain: Settings: Display a notification' is set to 'No': Compliant"
} else {
    Write-Host "9.1.4 (L1) Ensure 'Windows Firewall: Domain: Settings: Display a notification' is set to 'No': Non-Compliant"
}

# 9.1.5 Ensure 'Windows Firewall: Domain: Logging: Name' is set to the specified path
$loggingName = Get-FirewallSetting -path $firewallDomainProfilePath -name "LogFileName"
if ($loggingName -eq "%SystemRoot%\System32\logfiles\firewall\domainfw.log") {
    Write-Host "9.1.5 (L1) Ensure 'Windows Firewall: Domain: Logging: Name' is set correctly: Compliant"
} else {
    Write-Host "9.1.5 (L1) Ensure 'Windows Firewall: Domain: Logging: Name' is set correctly: Non-Compliant"
}

# 9.1.6 Ensure 'Windows Firewall: Domain: Logging: Size limit (KB)' is set to '16,384 KB or greater'
$loggingSize = Get-FirewallSetting -path $firewallDomainProfilePath -name "LogFileSize"
if ($loggingSize -ge 16384) {
    Write-Host "9.1.6 (L1) Ensure 'Windows Firewall: Domain: Logging: Size limit (KB)' is set to '16,384 KB or greater': Compliant"
} else {
    Write-Host "9.1.6 (L1) Ensure 'Windows Firewall: Domain: Logging: Size limit (KB)' is set to '16,384 KB or greater': Non-Compliant"
}

# 9.1.7 Ensure 'Windows Firewall: Domain: Logging: Log dropped packets' is set to 'Yes'
$logDroppedPackets = Get-FirewallSetting -path $firewallDomainProfilePath -name "LogDroppedPackets"
if ($logDroppedPackets -eq 1) {
    Write-Host "9.1.7 (L1) Ensure 'Windows Firewall: Domain: Logging: Log dropped packets' is set to 'Yes': Compliant"
} else {
    Write-Host "9.1.7 (L1) Ensure 'Windows Firewall: Domain: Logging: Log dropped packets' is set to 'Yes': Non-Compliant"
}

# 9.1.8 Ensure 'Windows Firewall: Domain: Logging: Log successful connections' is set to 'Yes'
$logSuccessfulConnections = Get-FirewallSetting -path $firewallDomainProfilePath -name "LogSuccessfulConnections"
if ($logSuccessfulConnections -eq 1) {
    Write-Host "9.1.8 (L1) Ensure 'Windows Firewall: Domain: Logging: Log successful connections' is set to 'Yes': Compliant"
} else {
    Write-Host "9.1.8 (L1) Ensure 'Windows Firewall: Domain: Logging: Log successful connections' is set to 'Yes': Non-Compliant"
}