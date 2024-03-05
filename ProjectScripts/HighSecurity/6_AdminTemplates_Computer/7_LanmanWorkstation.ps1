# Function to check the status of: Administrative Templates (Computer) - Lanman Workstation
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

# Regristry Paths:
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation"


# 18.6.8.1 (L1) Ensure 'Enable insecure guest logons' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowInsecureGuestAuth" -expectedValue 0 -sectionNumber "18.6.8.1" -description "Enable insecure guest logons" -recommendation "Disabled"
