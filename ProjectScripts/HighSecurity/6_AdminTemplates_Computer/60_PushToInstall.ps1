# Function to check the status of: Administrative Templates (Computer) - Push To Install
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\PushToInstall"


# 18.10.56.1 (L2) Ensure 'Turn off Push To Install service' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DisablePushToInstall" -expectedValue 1 -sectionNumber "18.10.56.1" -level "(L2)" -description "Turn off Push To Install service" -recommendation "Enabled"