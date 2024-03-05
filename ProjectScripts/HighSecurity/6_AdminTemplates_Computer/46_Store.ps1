# Function to check the status of: Administrative Templates (Computer) - Microsoft Store
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"


# 18.10.66.2 (L1) Ensure 'Only display the private store within the Microsoft Store' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "RequirePrivateStoreOnly" -expectedValue 1 -sectionNumber "18.10.66.2" -description "Only display the private store within the Microsoft Store" -recommendation "Enabled"

# 18.10.66.3 (L1) Ensure 'Turn off Automatic Download and Install of updates' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AutoDownload" -expectedValue 4 -sectionNumber "18.10.66.3" -description "Turn off Automatic Download and Install of updates" -recommendation "Disabled"

# 18.10.66.4 (L1) Ensure 'Turn off the offer to update to the latest version of Windows' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DisableOSUpgrade" -expectedValue 1 -sectionNumber "18.10.66.4" -description "Turn off the offer to update to the latest version of Windows" -recommendation "Enabled"
