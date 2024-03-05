# Function to check the status of: Administrative Templates (Computer) - Windows Connection Manager
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



# Registry Values:
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy"


# 18.6.21.1 (L1) Ensure 'Minimize the number of simultaneous connections to the Internet or a Windows Domain' is set to 'Enabled: 3 = Prevent Wi-Fi when on Ethernet'
Check-GPSetting -policyPath $RegPath -valueName "fMinimizeConnections" -expectedValue 3 -sectionNumber "18.6.21.1" -description "Minimize the number of simultaneous connections to the Internet or a Windows Domain" -recommendation "Enabled: 3 = Prevent Wi-Fi when on Ethernet"

# 18.6.21.2 (L1) Ensure 'Prohibit connection to non-domain networks when connected to domain authenticated network' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "fBlockNonDomain" -expectedValue 1 -sectionNumber "18.6.21.2" -description "Prohibit connection to non-domain networks when connected to domain authenticated network" -recommendation "Enabled"
