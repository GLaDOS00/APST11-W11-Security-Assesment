# Define Group Policy paths for DNS Client
$dnsClientPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient"

# Define Group Policy values for DNS Client
$dnsOverHttpsValueName = "EnableAutoDoh"
$netBiosSettingsValueName = "EnableMulticast"
$turnOffMulticastValueName = "EnableMulticast"

# Function to check the status of DNS Client Group Policy settings
function Check-DNS-Client-GPSettings {
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

# Check the status of 'Configure DNS over HTTPS (DoH) name resolution'
Check-DNS-Client-GPSettings -policyPath $dnsClientPolicyPath -valueName $dnsOverHttpsValueName -expectedValue 2 -recommendation "Enable: Allow DoH or higher"

# Check the status of 'Configure NetBIOS settings'
Check-DNS-Client-GPSettings -policyPath $dnsClientPolicyPath -valueName $netBiosSettingsValueName -expectedValue 2 -recommendation "Enable: Disable NetBIOS name resolution on public networks"

# Check the status of 'Turn off multicast name resolution'
Check-DNS-Client-GPSettings -policyPath $dnsClientPolicyPath -valueName $turnOffMulticastValueName -expectedValue 1 -recommendation "Enable"
