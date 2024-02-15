# Define Group Policy path for Lanman Workstation
$lanmanWorkstationPolicyPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"

# Define Group Policy value for Lanman Workstation
$enableInsecureGuestLogonsValueName = "AllowInsecureGuestAuth"

# Function to check the status of Lanman Workstation Group Policy setting
function Check-Lanman-Workstation-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue

    if ($currentValue -eq $null) {
        Write-Host "$valueName is not configured. Recommendation: $recommendation"
    } elseif ($currentValue.$valueName -eq $expectedValue) {
        Write-Host "$valueName is set to $expectedValue (Meets the recommendation)"
    } else {
        Write-Host "$valueName is set to $($currentValue.$valueName) (Does not meet the recommendation. Recommendation: $recommendation)"
    }
}

# Check the status of 'Enable insecure guest logons'
Check-Lanman-Workstation-GPSetting -policyPath $lanmanWorkstationPolicyPath -valueName $enableInsecureGuestLogonsValueName -expectedValue 0 -recommendation "Disable"
