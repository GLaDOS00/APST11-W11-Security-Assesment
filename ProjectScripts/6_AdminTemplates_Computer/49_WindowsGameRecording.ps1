# Function to check the status of: Administrative Templates (Computer) - Windows Game Recording & Broadcasting
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
$RegPath= "HKLM:\"


# 18.10.78.1 (L1) Ensure 'Enables or disables Windows Game Recording and Broadcasting' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowGameDVR" -expectedValue 0 -sectionNumber "18.10.78.1" -description "Enables or disables Windows Game Recording and Broadcasting" -recommendation "Disabled"