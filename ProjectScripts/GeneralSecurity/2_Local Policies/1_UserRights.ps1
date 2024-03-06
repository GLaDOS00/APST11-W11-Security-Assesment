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
if ($policyValue -eq $null) {
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