# Function to check the status of: Administrative Templates (Computer) - Windows Hello for Business
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
$RegPath= "HKLM:\SOFTWARE\Microsoft\Policies\PassportForWork\Biometrics"


# 18.10.79.1 (L1) Ensure 'Enable ESS with Supported Peripherals' is set to 'Enabled: 1'
Check-GPSetting -policyPath $RegPath -valueName "EnableESSwithSupportedPeripherals" -expectedValue 1 -sectionNumber "18.10.79.1" -description "Enable ESS with Supported Peripherals" -recommendation "Enabled: 1"