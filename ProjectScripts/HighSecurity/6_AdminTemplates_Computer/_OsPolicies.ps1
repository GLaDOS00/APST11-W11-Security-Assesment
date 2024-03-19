# Function to check the status of: Administrative Templates (Computer) - OS Policies
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"


# 18.9.30.1 (L2) Ensure 'Allow Clipboard synchronization across devices' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowCrossDeviceClipboard" -expectedValue 0 -sectionNumber "18.9.30.1" -level "(L2)" -description "Allow Clipboard synchronization across devices" -recommendation "Disabled"

# 18.9.30.2 (L2) Ensure 'Allow upload of User Activities' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "UploadUserActivities" -expectedValue 0 -sectionNumber "18.9.30.2" -level "(L2)" -description "Allow upload of User Activities" -recommendation "Disabled"