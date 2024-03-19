# Function to check the status of: Administrative Templates (Computer) - Start Menu & Taskbar
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"


# 18.8.1.1 (L2) Ensure 'Turn off notifications network usage' is set to 'Enabled' 
Check-GPSetting -policyPath $RegPath -valueName "NoCloudApplicationNotification" -expectedValue 1 -sectionNumber "18.8.1.1" -level "(L2)" -description "Turn off notifications network usage" -recommendation "Enabled"