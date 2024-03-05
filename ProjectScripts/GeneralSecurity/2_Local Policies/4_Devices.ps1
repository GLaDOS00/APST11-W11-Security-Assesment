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
$RegPath= "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

# 2.3.4.1 (L1) Ensure 'Devices: Allowed to format and eject removable media' is set to 'Administrators and Interactive Users'
Check-GPSetting -policyPath $RegPath -valueName "AllocateDASD" -expectedValue 2 -sectionNumber "2.3.4.1" -description "Devices: Allowed to format and eject removable media" -recommendation "Administrators and Interactive Users"

