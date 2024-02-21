# Function to check the status of WLAN Service Group Policy setting
function Check-WLANService-GPSetting {
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

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to 'Disabled': $status"
}

# Define the registry path for WLAN Service settings
$wlanServicePolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\WlanSvc"

# Check 'Allow Windows to automatically connect to suggested open hotspots, to networks shared by contacts, and to hotspots offering paid services'
Check-WLANService-GPSetting -policyPath $wlanServicePolicyPath -valueName "AutoConnectAllowedOEM" -expectedValue 0 -sectionNumber "18.6.23.2.1" -description "Allow Windows to automatically connect to suggested open hotspots, to networks shared by contacts, and to hotspots offering paid services"
