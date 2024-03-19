# Function to check the status of: Administrative Templates (Computer) - Microsoft Store
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"


# 18.10.66.1 (L2) Ensure 'Disable all apps from Microsoft Store' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "DisableStoreApps" -expectedValue 1 -sectionNumber "18.10.66.1" -level "(L2)" -description "Disable all apps from Microsoft Store" -recommendation "Disabled"

# 18.10.66.2 (L1) Ensure 'Only display the private store within the Microsoft Store' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "RequirePrivateStoreOnly" -expectedValue 1 -sectionNumber "18.10.66.2" -level "(L1)" -description "Only display the private store within the Microsoft Store" -recommendation "Enabled"

# 18.10.66.3 (L1) Ensure 'Turn off Automatic Download and Install of updates' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AutoDownload" -expectedValue 4 -sectionNumber "18.10.66.3" -level "(L1)" -description "Turn off Automatic Download and Install of updates" -recommendation "Disabled"

# 18.10.66.4 (L1) Ensure 'Turn off the offer to update to the latest version of Windows' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DisableOSUpgrade" -expectedValue 1 -sectionNumber "18.10.66.4" -level "(L1)" -description "Turn off the offer to update to the latest version of Windows" -recommendation "Enabled"

# 18.10.66.5 (L2) Ensure 'Turn off the Store application' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "RemoveWindowsStore" -expectedValue 1 -sectionNumber "18.10.66.5" -level "(L2)" -description "Turn off the Store application" -recommendation "Enabled"