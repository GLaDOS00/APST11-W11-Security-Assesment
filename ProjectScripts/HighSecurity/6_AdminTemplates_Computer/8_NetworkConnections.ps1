# Function to check the status of: Administrative Templates (Computer) - Network Connections
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
        [string]$description,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to '$recommendation': $status"
}


# Regristry Values:
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections"


# 18.6.11.2 (L1) Ensure 'Prohibit installation and configuration of Network Bridge on your DNS domain network' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "NC_AllowNetBridge_NLA" -expectedValue 0 -sectionNumber "18.6.11.2" -description "Prohibit installation and configuration of Network Bridge on your DNS domain network" -recommendation "Enabled"

# 18.6.11.3 (L1) Ensure 'Prohibit use of Internet Connection Sharing on your DNS domain network' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "NC_ShowSharedAccessUI" -expectedValue 0 -sectionNumber "18.6.11.3" -description "Prohibit use of Internet Connection Sharing on your DNS domain network" -recommendation "Enabled"

# 18.6.11.4 (L1) Ensure 'Require domain users to elevate when setting a network's location' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "NC_StdDomainUserSetLocation" -expectedValue 1 -sectionNumber "18.6.11.4" -description "Require domain users to elevate when setting a network's location" -recommendation "Enabled"
