# Function to check the status of: Administrative Templates (Computer) - Widgets
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Dsh"


# 18.10.72.1 (L1) Ensure 'Allow widgets' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowNewsAndInterests" -expectedValue 0 -sectionNumber "18.10.72.1" -description "Allow widgets" -recommendation "Disabled"