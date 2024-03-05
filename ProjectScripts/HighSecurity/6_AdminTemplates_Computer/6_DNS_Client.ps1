# Function to check the status of: Administrative Templates (Computer) - DNS Client
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


# Define the registry path for DNS Client settings
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient"

# 18.6.4.1 (L1) Ensure 'Configure DNS over HTTPS (DoH) name resolution' is set to 'Enabled: Allow DoH' or higher
Check-GPSetting -policyPath $RegPath -valueName "DoHPolicy" -expectedValue 1 -sectionNumber "18.6.4.1" -description "Configure DNS over HTTPS (DoH) name resolution" -recommendation "Enabled: Allow DoH"

# 18.6.4.2 (L1) Ensure 'Configure NetBIOS settings' is set to 'Enabled: Disable NetBIOS name resolution on public networks'
Check-GPSetting -policyPath $RegPath -valueName "EnableNetbios" -expectedValue 2 -sectionNumber "18.6.4.2" -description "Configure NetBIOS settings" -recommendation "Enabled: Disable NetBIOS name resolution on public networks"

# 18.6.4.3 (L1) Ensure 'Turn off multicast name resolution' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableMulticast" -expectedValues 0 -sectionNumber "18.6.4.3" -description "Turn off multicast name resolution" -recommendation "Enabled"
