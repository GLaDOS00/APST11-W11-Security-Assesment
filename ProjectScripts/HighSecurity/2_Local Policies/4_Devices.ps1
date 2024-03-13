# Function to check the status of Local Policy - Devices
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

# Registry Value:
$RegPath1= "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$RegPath2= "HKLM:\SYSTEM\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers"

# 2.3.4.1 (L1) Ensure 'Devices: Allowed to format and eject removable media' is set to 'Administrators and Interactive Users'
Check-GPSetting -policyPath $RegPath1 -valueName "AllocateDASD" -expectedValue 2 -sectionNumber "2.3.4.1" -description "Devices: Allowed to format and eject removable media" -recommendation "Administrators and Interactive Users"

# 2.3.4.2 (L2) Ensure 'Devices: Prevent users from installing printer drivers' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "AddPrinterDrivers" -expectedValue 1 -sectionNumber "2.3.4.2" -description "Devices: Prevent users from installing printer drivers" -recommendation "Enabled"

