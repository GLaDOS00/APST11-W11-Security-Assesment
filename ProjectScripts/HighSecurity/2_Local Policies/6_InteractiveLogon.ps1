# Function to check the status of Local Policy - Interactive Logon settings
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
$RegPath1= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$RegPath2= "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

# 2.3.7.1 (L1) Ensure 'Interactive logon: Do not require CTRL+ALT+DEL' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "DisableCAD" -expectedValue 0 -sectionNumber "2.3.7.1" -level "(L1)" -description "Interactive logon: Do not require CTRL+ALT+DEL" -recommendation "Disabled"

# 2.3.7.2 (L1) Ensure 'Interactive logon: Don't display last signed-in' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "DontDisplayLastUserName" -expectedValue 1 -sectionNumber "2.3.7.2" -level "(L1)" -description "Interactive logon: Don't display last signed-in" -recommendation "Enabled"

# 2.3.7.4 (L1) Ensure 'Interactive logon: Machine inactivity limit' is set to '900 or fewer second(s), but not 0'
Check-GPSetting -policyPath $RegPath1 -valueName "InactivityTimeoutSecs" -expectedValue 900 -sectionNumber "2.3.7.4" -level "(L1)" -description "Interactive logon: Machine inactivity limit" -recommendation "900 or fewer second(s), but not 0"

# 2.3.7.5 (L1) Configure 'Interactive logon: Message text for users attempting to log on'
Check-GPSetting -policyPath $RegPath1 -valueName "LegalNoticeText" -sectionNumber "2.3.7.5" -level "(L1)" -description "Interactive logon: Message text for users attempting to log on" -recommendation "Configured"

# 2.3.7.6 (L1) Configure 'Interactive logon: Message title for users attempting to log on'
Check-GPSetting -policyPath $RegPath1 -valueName "LegalNoticeCaption" -sectionNumber "2.3.7.6" -level "(L1)" -description "Interactive logon: Message title for users attempting to log on" -recommendation "Configured"

# 2.3.7.7 (L2) Ensure 'Interactive logon: Number of previous logons to cache (in case domain controller is not available)' is set to '4 or fewer logon(s)'
Check-GPSetting -policyPath $RegPath2 -valueName "CachedLogonsCount" -expectedValue 4 -sectionNumber "2.3.7.7" -level "(L2)" -description "Interactive logon: Number of previous logons to cache (in case domain controller is not available)" -recommendation "4 or fewer logon(s)"

# 2.3.7.8 (L1) Ensure 'Interactive logon: Prompt user to change password before expiration' is set to 'Between 5 and 14 days'
Check-GPSetting -policyPath $RegPath2 -valueName "PasswordExpiryWarning" -expectedValue 14 -sectionNumber "2.3.7.8" -level "(L1)" -description "Interactive logon: Prompt user to change password before expiration" -recommendation "Between 5 and 14 days"

# 2.3.7.9 (L1) Ensure 'Interactive logon: Smart card removal behavior' is set to 'Lock Workstation' or higher
Check-GPSetting -policyPath $RegPath2 -valueName "ScRemoveOption" -expectedValue 1 -sectionNumber "2.3.7.9" -level "(L1)" -description "Interactive logon: Smart card removal behavior" -recommendation "Lock Workstation"