# Function to check the status of: Administrative Templates (Computer) - Home Group
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\HomeGroup"


# 18.10.33.1 (L1) Ensure 'Prevent the computer from joining a homegroup' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DisableHomeGroup" -expectedValue 1 -sectionNumber "18.10.33.1" -description "Prevent the computer from joining a homegroup" -recommendation "Enabled"