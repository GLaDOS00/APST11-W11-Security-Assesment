# Define Group Policy paths for Network Connections
$networkConnectionsPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections"

# Define Group Policy values for Network Connections
$prohibitNetworkBridgeValueName = "NC_AllowNetBridge_NLA"
$prohibitICSValueName = "NC_ShowSharedAccessUI"
$requireElevationValueName = "NC_StdDomainUserSetLocation"

# Function to check the status of Network Connections Group Policy settings
function Check-Network-Connections-GPSettings {
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

# Check the status of 'Prohibit installation and configuration of Network Bridge on your DNS domain network'
Check-Network-Connections-GPSettings -policyPath $networkConnectionsPolicyPath -valueName $prohibitNetworkBridgeValueName -expectedValue 1 -recommendation "Enable"

# Check the status of 'Prohibit use of Internet Connection Sharing on your DNS domain network'
Check-Network-Connections-GPSettings -policyPath $networkConnectionsPolicyPath -valueName $prohibitICSValueName -expectedValue 1 -recommendation "Enable"

# Check the status of 'Require domain users to elevate when setting a network's location'
Check-Network-Connections-GPSettings -policyPath $networkConnectionsPolicyPath -valueName $requireElevationValueName -expectedValue 1 -recommendation "Enable"
