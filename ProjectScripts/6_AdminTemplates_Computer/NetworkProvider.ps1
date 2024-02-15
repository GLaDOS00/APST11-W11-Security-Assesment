# Define Group Policy path for Network Provider
$networkProviderPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths"

# Define Group Policy value for Network Provider
$hardenedUNCPathsValueName = "\\*\NETLOGON,RequireMutualAuthentication=1,RequireIntegrity=1 \\*\SYSVOL,RequireMutualAuthentication=1,RequireIntegrity=1"

# Function to check the status of Network Provider Group Policy setting
function Check-Network-Provider-GPSetting {
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

# Check the status of 'Hardened UNC Paths'
Check-Network-Provider-GPSetting -policyPath $networkProviderPolicyPath -valueName $hardenedUNCPathsValueName -expectedValue $hardenedUNCPathsValueName -recommendation "Enable, with 'Require Mutual Authentication' and 'Require Integrity' set for all NETLOGON and SYSVOL shares"
