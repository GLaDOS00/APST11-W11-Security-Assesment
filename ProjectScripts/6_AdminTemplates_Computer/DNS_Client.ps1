# Function to check the status of DNS Client Group Policy settings
function Check-DNSClient-GPSettings {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValues, # Note: This is plural because some settings may have multiple acceptable values
        [string]$sectionNumber,
        [string]$description
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"

    # Check if the current value matches any of the expected values
    foreach ($expectedValue in $expectedValues) {
        if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
            $status = "Compliant"
            break
        }
    }

    $expectedValueString = $expectedValues -join " or "
    Write-Host "$sectionNumber (L1) Ensure '$description' is set to '$expectedValueString': $status"
}

# Define the registry path for DNS Client settings
$dnsClientPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient"

# Check 'Configure DNS over HTTPS (DoH) name resolution'
Check-DNSClient-GPSettings -policyPath $dnsClientPolicyPath -valueName "EnableAutoDoh" -expectedValues @("2") -sectionNumber "18.6.4.1" -description "Configure DNS over HTTPS (DoH) name resolution"

# Check 'Configure NetBIOS settings'
Check-DNSClient-GPSettings -policyPath $dnsClientPolicyPath -valueName "NetBIOSOptions" -expectedValues @("2") -sectionNumber "18.6.4.2" -description "Configure NetBIOS settings"

# Check 'Turn off multicast name resolution'
Check-DNSClient-GPSettings -policyPath $dnsClientPolicyPath -valueName "EnableMulticast" -expectedValues @("0") -sectionNumber "18.6.4.3" -description "Turn off multicast name resolution"
