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
    return $null  # Ensure function returns $null if the policy is not found
}

# 2.2.1 (L1) Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'
$policyValue1 = Get-SecPolValue "SeDenyInteractiveLogonRight"
if ($policyValue1 -eq $null -or $policyValue1 -eq "No One") {
    Write-Host "2.2.1 (L1) Ensure 'Access Credential Manager as a trusted caller' is set to 'No One' : Compliant"
} else {
    Write-Host "2.2.1 (L1) Ensure 'Access Credential Manager as a trusted caller' is set to 'No One' : Non-Compliant"
}

# 2.2.2 (L1) Ensure 'Access this computer from the network' is set to 'Administrators, Remote Desktop Users'
$policyValue2 = Get-SecPolValue "SeNetworkLogonRight"
if ($policyValue2 -eq "*S-1-5-32-544,*S-1-5-32-555") {
    Write-Host "2.2.2 (L1) Ensure 'Access this computer from the network' is set to 'Administrators, Remote Desktop Users' : Compliant"
} else {
    Write-Host "2.2.2 (L1) Ensure 'Access this computer from the network' is set to 'Administrators, Remote Desktop Users' : Non-Compliant"
}

