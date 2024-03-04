# Function to check the status of: Administrative Template (Computer) - App Privacy 
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"


# 18.10.4.1 (L1) Ensure 'Let Windows apps activate with voice while the system is locked' is set to 'Enabled: Force Deny'
Check-GPSetting -policyPath $RegPath -valueName "LetAppsActivateWithVoice" -expectedValue 2 -sectionNumber "18.10.4.1" -description "Let Windows apps activate with voice while the system is locked" -recommendation "Enabled: Force Deny"