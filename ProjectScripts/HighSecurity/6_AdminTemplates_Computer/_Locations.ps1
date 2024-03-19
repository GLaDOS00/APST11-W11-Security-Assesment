# Function to check the status of: Administrative Templates (Computer) - Locations & Sensors
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
		[string]$level,
        [string]$description,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber $level Ensure '$description' is set to '$recommendation': $status"
}


# Registry Values:
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors"


# 18.10.37.2 (L2) Ensure 'Turn off location' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DisableLocation" -expectedValue 1 -sectionNumber "18.10.37.2" -level "(L2)" -description "Turn off location" -recommendation "Enabled"