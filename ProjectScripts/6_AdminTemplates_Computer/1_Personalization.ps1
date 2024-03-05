# Function to check the status of: Administrative Templates (Computer) - Personalization
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

# Registry Paths:
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"


# 18.1.1.1 (L1) Ensure 'Prevent enabling lock screen camera' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "NoLockScreenCamera" -expectedValue 1 -sectionNumber "18.1.1.1" -description "Prevent enabling lock screen camera" -recommendation "Enabled"

# 18.1.1.2 (L1) Ensure 'Prevent enabling lock screen slide show' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "NoLockScreenSlideshow" -expectedValue 1 -sectionNumber "18.1.1.2" -description "Prevent enabling lock screen slide show" -recommendation "Enabled"
