# Function to check the status of: Local Policies - User Rights Assignment

# Export the security settings to a temporary file
$seceditExportPath = "$env:TEMP\secpol.cfg"
secedit /export /cfg $seceditExportPath /quiet

# Function to parse the exported security settings file for a specific policy value
function Get-SecPolValue {
    param (
        [string]$policyName
    )
    $content = Get-Content -Path $seceditExportPath
    foreach ($line in $content) {
        if ($line.StartsWith($policyName)) {
            return $line.Split('=')[1].Trim()
        }
    }
    return $null
}


# 2.2.1 (L1) Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'
$policyValue1 = Get-SecPolValue "SeTrustedCredManAccessPrivilege"
if ($policyValue1 -eq $null -or $policyValue1 -eq "") {
    Write-Host "2.2.1 (L1) Ensure 'Access Credential Manager as a trusted caller' is set to 'No One': Compliant"
} else {
    Write-Host "2.2.1 (L1) Ensure 'Access Credential Manager as a trusted caller' is set to 'No One': Non-Compliant"
}

# 2.2.2 (L1) Ensure 'Access this computer from the network' is set to 'Administrators, Remote Desktop Users'
$policyValue2 = Get-SecPolValue "SeNetworkLogonRight"
if ($policyValue2 -eq "*S-1-5-32-544,*S-1-5-32-555") {
    Write-Host "2.2.2 (L1) Ensure 'Access this computer from the network' is set to 'Administrators, Remote Desktop Users': Compliant"
} else {
    Write-Host "2.2.2 (L1) Ensure 'Access this computer from the network' is set to 'Administrators, Remote Desktop Users': Non-Compliant"
}

# 2.2.3 (L1) Ensure 'Act as part of the operating system' is set to 'No One'
$policyValue3 = Get-SecPolValue "SeTcbPrivilege"
if ($policyValue3 -eq $null -or $policyValue3 -eq "") {
    Write-Host "2.2.3 (L1) Ensure 'Act as part of the operating system' is set to 'No One': Compliant"
} else {
    Write-Host "2.2.3 (L1) Ensure 'Act as part of the operating system' is set to 'No One': Non-Compliant"
}

# 2.2.4 (L1) Ensure 'Adjust memory quotas for a process' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE'
$policyValue4 = Get-SecPolValue "SeIncreaseQuotaPrivilege"
if ($policyValue4 -eq "*S-1-5-19,*S-1-5-20,*S-1-5-32-544") {
    Write-Host "2.2.4 (L1) Ensure 'Adjust memory quotas for a process' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE': Compliant"
} else {
    Write-Host "2.2.4 (L1) Ensure 'Adjust memory quotas for a process' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE': Non-Compliant"
}

# 2.2.5 (L1) Ensure 'Allow log on locally' is set to 'Administrators, Users'
$policyValue5 = Get-SecPolValue "SeInteractiveLogonRight"
if ($policyValue5 -eq "*S-1-5-32-544,*S-1-5-32-545") {
    Write-Host "2.2.5 (L1) Ensure 'Allow log on locally' is set to 'Administrators, Users' : Compliant"
} else {
    Write-Host "2.2.5 (L1) Ensure 'Allow log on locally' is set to 'Administrators, Users' : Non-Compliant"
}

# 2.2.6 (L1) Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users'
$policyValue6 = Get-SecPolValue "SeRemoteInteractiveLogonRight"
if ($policyValue6 -eq "*S-1-5-32-544,*S-1-5-32-555") {
    Write-Host "2.2.6 (L1) Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users': Compliant"
} else {
    Write-Host "2.2.6 (L1) Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users': Non-Compliant"
}

# 2.2.7 (L1) Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users'
$policyValue7 = Get-SecPolValue "SeBackupPrivilege"
if ($policyValue7 -eq "*S-1-5-32-544") {
    Write-Host "2.2.7 (L1) Ensure 'Back up files and directories' is set to 'Administrators': Compliant"
} else {
    Write-Host "2.2.7 (L1) Ensure 'Back up files and directories' is set to 'Administrators': Non-Compliant"
}

# 2.2.8 (L1) Ensure 'Change the system time' is set to 'Administrators, LOCAL SERVICE'
$policyValue8 = Get-SecPolValue "SeSystemtimePrivilege"
if ($policyValue8 -eq "*S-1-5-19,*S-1-5-32-544") {
    Write-Host "2.2.8 (L1) Ensure 'Change the system time' is set to 'Administrators, LOCAL SERVICE': Compliant"
} else {
    Write-Host "2.2.8 (L1) Ensure 'Change the system time' is set to 'Administrators, LOCAL SERVICE': Non-Compliant"
}

# 2.2.9 (L1) Ensure 'Change the time zone' is set to 'Administrators, LOCAL SERVICE, Users'
$policyValue9 = Get-SecPolValue "SeTimeZonePrivilege"
if ($policyValue9 -eq "*S-1-5-19,*S-1-5-32-544,*S-1-5-32-545") {
    Write-Host "2.2.9 (L1) Ensure 'Change the time zone' is set to 'Administrators, LOCAL SERVICE, Users': Compliant"
} else {
    Write-Host "2.2.9 (L1) Ensure 'Change the time zone' is set to 'Administrators, LOCAL SERVICE, Users': Non-Compliant"
}

# 2.2.10 (L1) Ensure 'Create a pagefile' is set to 'Administrators'
$policyValue10 = Get-SecPolValue "SeCreatePagefilePrivilege"
if ($policyValue10 -eq "*S-1-5-32-544") {
    Write-Host "2.2.10 (L1) Ensure 'Create a pagefile' is set to 'Administrators': Compliant"
} else {
    Write-Host "2.2.10 (L1) Ensure 'Create a pagefile' is set to 'Administrators': Non-Compliant"
}

# 2.2.11 (L1) Ensure 'Create a token object' is set to 'No One'
$policyValue11 = Get-SecPolValue "SeCreateTokenPrivilege"
if ($policyValue11 -eq $null) {
    Write-Host "2.2.11 (L1) Ensure 'Create a token object' is set to 'No One': Compliant"
} else {
    Write-Host "2.2.11 (L1) Ensure 'Create a token object' is set to 'No One': Non-Compliant"
}

# 2.2.12 (L1) Ensure 'Create global objects' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE'
$policyValue12 = Get-SecPolValue "SeCreateGlobalPrivilege"
if ($policyValue12 -eq "*S-1-5-19,*S-1-5-20,*S-1-5-32-544,*S-1-5-6") {
    Write-Host "2.2.12 (L1) Ensure 'Create global objects' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE': Compliant"
} else {
    Write-Host "2.2.12 (L1) Ensure 'Create global objects' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE': Non-Compliant"
}

# 2.2.13 (L1) Ensure 'Create permanent shared objects' is set to 'No One'
$policyValue13 = Get-SecPolValue "SeCreatePermanentPrivilege"
if ($policyValue13 -eq $null) {
    Write-Host "2.2.13 (L1) Ensure 'Create permanent shared objects' is set to 'No One': Compliant"
} else {
    Write-Host "2.2.13 (L1) Ensure 'Create permanent shared objects' is set to 'No One': Non-Compliant"
}

# 2.2.14 (L1) Ensure 'Create symbolic links' is set to 'Administrators'
$policyValue14 = Get-SecPolValue "SeCreateSymbolicLinkPrivilege"
if ($policyValue14 -eq "*S-1-5-32-544") {
    Write-Host "2.2.14 (L1) Ensure 'Create symbolic links' is set to 'Administrators': Compliant"
} else {
    Write-Host "2.2.14 (L1) Ensure 'Create symbolic links' is set to 'Administrators': Non-Compliant"
}

# 2.2.15 (L1) Ensure 'Debug programs' is set to 'Administrators'
$policyValue15 = Get-SecPolValue "SeDebugPrivilege"
if ($policyValue15 -eq "*S-1-5-32-544") {
    Write-Host "2.2.15 (L1) Ensure 'Debug programs' is set to 'Administrators': Compliant"
} else {
    Write-Host "2.2.15 (L1) Ensure 'Debug programs' is set to 'Administrators': Non-Compliant"
}

# 2.2.16 (L1) Ensure 'Deny access to this computer from the network' to include 'Guests, Local account'
$policyValue16 = Get-SecPolValue "SeDenyNetworkLogonRight"
if ($policyValue16 -eq "*S-1-5-113,Guest") {
    Write-Host "2.2.16 (L1) Ensure 'Deny access to this computer from the network' to include 'Guests, Local account': Compliant"
} else {
    Write-Host "2.2.16 (L1) Ensure 'Deny access to this computer from the network' to include 'Guests, Local account': Non-Compliant"
}

# 2.2.17 (L1) Ensure 'Deny log on as a batch job' to include 'Guests'
$policyValue17 = Get-SecPolValue "SeDenyBatchLogonRight"
if ($policyValue17 -eq "Guest") {
    Write-Host "2.2.17 (L1) Ensure 'Deny log on as a batch job' to include 'Guests': Compliant"
} else {
    Write-Host "2.2.17 (L1) Ensure 'Deny log on as a batch job' to include 'Guests': Non-Compliant"
}

# 2.2.18 (L1) Ensure 'Deny log on as a service' to include 'Guests'
$policyValue18 = Get-SecPolValue "SeDenyServiceLogonRight"
if ($policyValue18 -eq "Guest") {
    Write-Host "2.2.18 (L1) Ensure 'Deny log on as a service' to include 'Guests': Compliant"
} else {
    Write-Host "2.2.18 (L1) Ensure 'Deny log on as a service' to include 'Guests': Non-Compliant"
}

# 2.2.19 (L1) Ensure 'Deny log on locally' to include 'Guests'
$policyValue19 = Get-SecPolValue "SeDenyInteractiveLogonRight"
if ($policyValue19 -eq "Guest") {
    Write-Host "2.2.19 (L1) Ensure 'Deny log on locally' to include 'Guests': Compliant"
} else {
    Write-Host "2.2.19 (L1) Ensure 'Deny log on locally' to include 'Guests': Non-Compliant"
}

# 2.2.20 (L1) Ensure 'Deny log on through Remote Desktop Services' to include 'Guests, Local account'
$policyValue20 = Get-SecPolValue "SeDenyRemoteInteractiveLogonRight"
if ($policyValue20 -eq "*S-1-5-113,Guest") {
    Write-Host "2.2.20 (L1) Ensure 'Deny log on through Remote Desktop Services' to include 'Guests, Local account': Compliant"
} else {
    Write-Host "2.2.20 (L1) Ensure 'Deny log on through Remote Desktop Services' to include 'Guests, Local account': Non-Compliant"
}

# 2.2.21 (L1) Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'No One'
$policyValue21 = Get-SecPolValue "SeEnableDelegationPrivilege"
if ($policyValue21 -eq $null) {
    Write-Host "2.2.21 (L1) Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'No One': Compliant"
} else {
    Write-Host "2.2.21 (L1) Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'No One': Non-Compliant"
}

# 2.2.22 (L1) Ensure 'Force shutdown from a remote system' is set to 'Administrators'
$policyValue22 = Get-SecPolValue "SeRemoteShutdownPrivilege"
if ($policyValue22 -eq "*S-1-5-32-544") {
    Write-Host "2.2.22 (L1) Ensure 'Force shutdown from a remote system' is set to 'Administrators': Compliant"
} else {
    Write-Host "2.2.22 (L1) Ensure 'Force shutdown from a remote system' is set to 'Administrators': Non-Compliant"
}

# 2.2.23 (L1) Ensure 'Generate security audits' is set to 'LOCAL SERVICE, NETWORK SERVICE'
$policyValue23 = Get-SecPolValue "SeAuditPrivilege"
if ($policyValue23 -eq "*S-1-5-19,*S-1-5-20") {
    Write-Host "2.2.23 (L1) Ensure 'Generate security audits' is set to 'LOCAL SERVICE, NETWORK SERVICE': Compliant"
} else {
    Write-Host "2.2.23 (L1) Ensure 'Generate security audits' is set to 'LOCAL SERVICE, NETWORK SERVICE': Non-Compliant"
}

# 2.2.24 (L1) Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE'
$policyValue24 = Get-SecPolValue "SeImpersonatePrivilege"
if ($policyValue24 -eq "*S-1-5-19,*S-1-5-20,*S-1-5-32-544,*S-1-5-6") {
    Write-Host "2.2.24 (L1) Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE': Compliant"
} else {
    Write-Host "2.2.24 (L1) Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE': Non-Compliant"
}

# 2.2.25 (L1) Ensure 'Increase scheduling priority' is set to 'Administrators, Window Manager\Window Manager Group’
$policyValue25 = Get-SecPolValue "SeIncreaseBasePriorityPrivilege"
if ($policyValue25 -eq "*S-1-5-32-544,*S-1-5-90-0") {
    Write-Host "2.2.25 (L1) Ensure 'Increase scheduling priority' is set to 'Administrators, Window Manager\Window Manager Group’: Compliant"
} else {
    Write-Host "2.2.25 (L1) Ensure 'Increase scheduling priority' is set to 'Administrators, Window Manager\Window Manager Group’: Non-Compliant"
}

# 2.2.26 (L1) Ensure 'Load and unload device drivers' is set to 'Administrators'
$policyValue26 = Get-SecPolValue "SeLoadDriverPrivilege"
if ($policyValue26 -eq "*S-1-5-32-544") {
    Write-Host "2.2.26 (L1) Ensure 'Load and unload device drivers' is set to 'Administrators': Compliant"
} else {
    Write-Host "2.2.26 (L1) Ensure 'Load and unload device drivers' is set to 'Administrators': Non-Compliant"
}

# 2.2.27 (L1) Ensure 'Lock pages in memory' is set to 'No One'
$policyValue27 = Get-SecPolValue "SeLockMemoryPrivilege"
if ($policyValue27 -eq $null) {
    Write-Host "2.2.27 (L1) Ensure 'Lock pages in memory' is set to 'No One': Compliant"
} else {
    Write-Host "2.2.27 (L1) Ensure 'Lock pages in memory' is set to 'No One': Non-Compliant"
}

# 2.2.28 (L2) Ensure 'Log on as a batch job' is set to 'Administrators'
$policyValue28 = Get-SecPolValue "SeBatchLogonRight"
if ($policyValue28 -eq "*S-1-5-32-544") {
    Write-Host "2.2.28 (L2) Ensure 'Log on as a batch job' is set to 'Administrators': Compliant"
} else {
    Write-Host "2.2.28 (L2) Ensure 'Log on as a batch job' is set to 'Administrators': Non-Compliant"
}

# 2.2.29 (L2) Ensure 'Log on as a service' is set to ‘No One’
$policyValue29 = Get-SecPolValue "SeServiceLogonRight"
if ($policyValue29 -eq $null) {
    Write-Host "2.2.29 (L2) Ensure 'Log on as a service' is set to ‘No One’: Compliant"
} else {
    Write-Host "2.2.29 (L2) Ensure 'Log on as a service' is set to ‘No One’: Non-Compliant"
}

# 2.2.30 (L1) Ensure 'Manage auditing and security log' is set to 'Administrators'
$policyValue30 = Get-SecPolValue "SeSecurityPrivilege"
if ($policyValue30 -eq "*S-1-5-32-544") {
    Write-Host "2.2.30 (L1) Ensure 'Manage auditing and security log' is set to 'Administrators': Compliant"
} else {
    Write-Host "2.2.30 (L1) Ensure 'Manage auditing and security log' is set to 'Administrators': Non-Compliant"
}

# 2.2.31 (L1) Ensure 'Modify an object label' is set to 'No One'
$policyValue31 = Get-SecPolValue "SeRelabelPrivilege"
if ($policyValue31 -eq $null) {
    Write-Host "2.2.31 (L1) Ensure 'Modify an object label' is set to 'No One': Compliant"
} else {
    Write-Host "2.2.31 (L1) Ensure 'Modify an object label' is set to 'No One': Non-Compliant"
}

# 2.2.32 (L1) Ensure 'Modify firmware environment values' is set to 'Administrators'
$policyValue32 = Get-SecPolValue "SeSystemEnvironmentPrivilege"
if ($policyValue32 -eq "*S-1-5-32-544") {
    Write-Host "2.2.32 (L1) Ensure 'Modify firmware environment values' is set to 'Administrators': Compliant"
} else {
    Write-Host "2.2.32 (L1) Ensure 'Modify firmware environment values' is set to 'Administrators': Non-Compliant"
}

# 2.2.33 (L1) Ensure 'Perform volume maintenance tasks' is set to 'Administrators'
$policyValue33 = Get-SecPolValue "SeManageVolumePrivilege"
if ($policyValue33 -eq "*S-1-5-32-544") {
    Write-Host "2.2.33 (L1) Ensure 'Perform volume maintenance tasks' is set to 'Administrators': Compliant"
} else {
    Write-Host "2.2.33 (L1) Ensure 'Perform volume maintenance tasks' is set to 'Administrators': Non-Compliant"
}

# 2.2.34 (L1) Ensure 'Profile single process' is set to 'Administrators'
$policyValue34 = Get-SecPolValue "SeProfileSingleProcessPrivilege"
if ($policyValue34 -eq "*S-1-5-32-544") {
    Write-Host "2.2.34 (L1) Ensure 'Profile single process' is set to 'Administrators': Compliant"
} else {
    Write-Host "2.2.34 (L1) Ensure 'Profile single process' is set to 'Administrators': Non-Compliant"
}

# 2.2.35 (L1) Ensure 'Profile system performance' is set to 'Administrators, NT SERVICE\WdiServiceHost'
$policyValue35 = Get-SecPolValue "SeSystemProfilePrivilege"
if ($policyValue35 -eq "*S-1-5-32-544,*S-1-5-80-3139157870-2983391045-3678747466-658725712-1809340420") {
    Write-Host "2.2.35 (L1) Ensure 'Profile system performance' is set to 'Administrators, NT SERVICE\WdiServiceHost': Compliant"
} else {
    Write-Host "2.2.35 (L1) Ensure 'Profile system performance' is set to 'Administrators, NT SERVICE\WdiServiceHost': Non-Compliant"
}

# 2.2.36 (L1) Ensure 'Replace a process level token' is set to 'LOCAL SERVICE, NETWORK SERVICE'
$policyValue36 = Get-SecPolValue "SeAssignPrimaryTokenPrivilege"
if ($policyValue36 -eq "*S-1-5-19,*S-1-5-20") {
    Write-Host "2.2.36 (L1) Ensure 'Replace a process level token' is set to 'LOCAL SERVICE, NETWORK SERVICE': Compliant"
} else {
    Write-Host "2.2.36 (L1) Ensure 'Replace a process level token' is set to 'LOCAL SERVICE, NETWORK SERVICE': Non-Compliant"
}

# 2.2.37 (L1) Ensure 'Restore files and directories' is set to 'Administrators'
$policyValue37 = Get-SecPolValue "SeRestorePrivilege"
if ($policyValue37 -eq "*S-1-5-32-544") {
    Write-Host "2.2.37 (L1) Ensure 'Restore files and directories' is set to 'Administrators': Compliant"
} else {
    Write-Host "2.2.37 (L1) Ensure 'Restore files and directories' is set to 'Administrators': Non-Compliant"
}

# 2.2.38 (L1) Ensure 'Shut down the system' is set to 'Administrators, Users' 
$policyValue38 = Get-SecPolValue "SeShutdownPrivilege"
if ($policyValue38 -eq "*S-1-5-32-544,*S-1-5-32-545") {
    Write-Host "2.2.38 (L1) Ensure 'Shut down the system' is set to 'Administrators, Users': Compliant"
} else {
    Write-Host "2.2.38 (L1) Ensure 'Shut down the system' is set to 'Administrators, Users': Non-Compliant"
}

# 2.2.39 (L1) Ensure 'Take ownership of files or other objects' is set to 'Administrators'
$policyValue = Get-SecPolValue "SeTakeOwnershipPrivilege"
if ($policyValue -eq "*S-1-5-32-544") {
    Write-Host "2.2.39 (L1) Ensure 'Take ownership of files or other objects' is set to 'Administrators': Compliant"
} else {
    Write-Host "2.2.39 (L1) Ensure 'Take ownership of files or other objects' is set to 'Administrators': Non-Compliant"
}