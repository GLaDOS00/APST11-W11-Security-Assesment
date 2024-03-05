# Function to check the status of: Administrative Templates (Computer) - WLAN Service
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
$RegPath = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"


# 18.6.23.2.1 (L1) Ensure 'Allow Windows to automatically connect to suggested open hotspots, to networks shared by contacts, and to hotspots offering paid services' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AutoConnectAllowedOEM" -expectedValue 0 -sectionNumber "18.6.23.2.1" -description "Allow Windows to automatically connect to suggested open hotspots, to networks shared by contacts, and to hotspots offering paid services" -recommendation "Disabled"
