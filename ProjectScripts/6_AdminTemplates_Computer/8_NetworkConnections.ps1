# Function to check the status of Network Connections Group Policy settings
function Check-NetworkConnections-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
        [string]$description
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to 'Enabled': $status"
}

# Define the registry path for Network Connections settings
$networkConnectionsPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections"

# Check 'Prohibit installation and configuration of Network Bridge on your DNS domain network'
Check-NetworkConnections-GPSetting -policyPath $networkConnectionsPolicyPath -valueName "NC_AllowNetBridge_NLA" -expectedValue 0 -sectionNumber "18.6.11.2" -description "Prohibit installation and configuration of Network Bridge on your DNS domain network"

# Check 'Prohibit use of Internet Connection Sharing on your DNS domain network'
Check-NetworkConnections-GPSetting -policyPath $networkConnectionsPolicyPath -valueName "NC_ShowSharedAccessUI" -expectedValue 0 -sectionNumber "18.6.11.3" -description "Prohibit use of Internet Connection Sharing on your DNS domain network"

# Check 'Require domain users to elevate when setting a network's location'
Check-NetworkConnections-GPSetting -policyPath $networkConnectionsPolicyPath -valueName "NC_StdDomainUserSetLocation" -expectedValue 0 -sectionNumber "18.6.11.4" -description "Require domain users to elevate when setting a network's location"
