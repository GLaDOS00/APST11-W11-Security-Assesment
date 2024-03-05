# Function to check the status of: Administrative Templates (Computer) - Power Management
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\f15576e8-98b7-4186-b944-eafa664402d9"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"


# 18.9.32.6.1 (L1) Ensure 'Allow network connectivity during connected-standby (on battery)' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "DCSettingIndex" -expectedValue 0 -sectionNumber "18.9.32.6.1" -description "Allow network connectivity during connected-standby (on battery)" -recommendation "Disabled"

# 18.9.32.6.2 (L1) Ensure 'Allow network connectivity during connected-standby (plugged in)' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "ACSettingIndex" -expectedValue 0 -sectionNumber "18.9.32.6.2" -description "Allow network connectivity during connected-standby (plugged in)" -recommendation "Disabled"

# 18.9.32.6.5 (L1) Ensure 'Require a password when a computer wakes (on battery)' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "DCSettingIndex" -expectedValue 1 -sectionNumber "18.9.32.6.5" -description "Require a password when a computer wakes (on battery)" -recommendation "Enabled"

# 18.9.32.6.6 (L1) Ensure 'Require a password when a computer wakes (plugged in)' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "ACSettingIndex" -expectedValue 1 -sectionNumber "18.9.32.6.6" -description "Require a password when a computer wakes (plugged in)" -recommendation "Enabled"
