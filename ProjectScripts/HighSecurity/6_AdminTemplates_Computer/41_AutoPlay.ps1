# Function to check the status of: Administrative Templates (Computer) - Autoplay
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
$RegPath2= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"


# 18.10.7.1 (L1) Ensure 'Disallow Autoplay for non-volume devices' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "NoAutoplayfornonVolume" -expectedValue 1 -sectionNumber "18.10.7.1" -description "" -recommendation "Enabled"

# 18.10.7.2 (L1) Ensure 'Set the default behavior for AutoRun' is set to 'Enabled: Do not execute any autorun commands'
Check-GPSetting -policyPath $RegPath2 -valueName "NoAutorun" -expectedValue 1 -sectionNumber "18.10.7.2" -description "Set the default behavior for AutoRun" -recommendation "Enabled: Do not execute any autorun commands"

# 18.10.7.3 (L1) Ensure 'Turn off Autoplay' is set to 'Enabled: All drives'
Check-GPSetting -policyPath $RegPath2 -valueName "NoDriveTypeAutoRun" -expectedValue 255 -sectionNumber "18.10.7.3" -description "Turn off Autoplay" -recommendation "Enabled: All drives"