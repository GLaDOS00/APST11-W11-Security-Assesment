# Function to check the status of: Administrative Templates (Computer) - Biometrics
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics\Facial Features"


# 18.10.8.1.1 (L1) Ensure 'Configure enhanced anti-spoofing' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "EnhancedAntiSpoofing" -expectedValue 1 -sectionNumber "18.10.8.1.1" -description "Configure enhanced anti-spoofing" -recommendation "Enabled"