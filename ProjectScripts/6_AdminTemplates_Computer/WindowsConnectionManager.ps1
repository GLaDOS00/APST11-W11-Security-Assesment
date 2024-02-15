# Define Group Policy paths for Windows Connection Manager
$connectionManagerPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc"

# Define Group Policy values for Windows Connection Manager
$minimizeSimultaneousConnectionsValueName = "fMinimizeConnections"
$prohibitNonDomainNetworksValueName = "fBlockNonDomain"
$minimizeSimultaneousConnectionsExpectedValue = "3"
$prohibitNonDomainNetworksExpectedValue = "1"

# Function to check the status of Windows Connection Manager Group Policy settings
function Check-Connection-Manager-GPSettings {
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

# Check the status of 'Minimize the number of simultaneous connections to the Internet or a Windows Domain'
Check-Connection-Manager-GPSettings -policyPath $connectionManagerPolicyPath -valueName $minimizeSimultaneousConnectionsValueName -expectedValue $minimizeSimultaneousConnectionsExpectedValue -recommendation "Enable: 3 = Prevent Wi-Fi when on Ethernet"

# Check the status of 'Prohibit connection to non-domain networks when connected to domain authenticated network'
Check-Connection-Manager-GPSettings -policyPath $connectionManagerPolicyPath -valueName $prohibitNonDomainNetworksValueName -expectedValue $prohibitNonDomainNetworksExpectedValue -recommendation "Enable"
