# Function to check the status of: Administrative Templates (Computer) - User Profiles
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo"


# 18.9.48.1 (L2) Ensure 'Turn off the advertising ID' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DisabledByGroupPolicy" -expectedValue 1 -sectionNumber "18.9.48.1" -level "(L2)" -description "Turn off the advertising ID" -recommendation "Enabled"