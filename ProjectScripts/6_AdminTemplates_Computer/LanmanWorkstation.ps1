# Function to check the status of Lanman Workstation Group Policy setting
function Check-LanmanWorkstation-GPSetting {
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

# Define the registry path for Lanman Workstation settings
$lanmanWorkstationPolicyPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"

# Check 'Enable insecure guest logons'
Check-LanmanWorkstation-GPSetting -policyPath $lanmanWorkstationPolicyPath -valueName "AllowInsecureGuestAuth" -expectedValue 0 -sectionNumber "18.6.8.1" -description "Enable insecure guest logons"
