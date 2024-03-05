# Function to check the status of: Administrative Templates (Computer) - Logon
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"


# 18.9.27.1 (L1) Ensure 'Block user from showing account details on sign-in' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "BlockUserFromShowingAccountDetailsOnSignin" -expectedValue 1 -sectionNumber "18.9.27.1" -description "Block user from showing account details on sign-in" -recommendation "Enabled"

# 18.9.27.2 (L1) Ensure 'Do not display network selection UI' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DontDisplayNetworkSelectionUI" -expectedValue 1 -sectionNumber "18.9.27.2" -description "Do not display network selection UI" -recommendation "Enabled"

# 18.9.27.3 (L1) Ensure 'Do not enumerate connected users on domain-joined computers' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DontEnumerateConnectedUsers" -expectedValue 1 -sectionNumber "18.9.27.3" -description "Do not enumerate connected users on domain-joined computers" -recommendation "Enabled"

# 18.9.27.4 (L1) Ensure 'Enumerate local users on domain-joined computers' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "EnumerateLocalUsers" -expectedValue 0 -sectionNumber "18.9.27.4" -description "Enumerate local users on domain-joined computers" -recommendation "Disabled"

# 18.9.27.5 (L1) Ensure 'Turn off app notifications on the lock screen' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DisableLockScreenAppNotifications" -expectedValue 1 -sectionNumber "18.9.27.5" -description "Turn off app notifications on the lock screen" -recommendation "Enabled"

# 18.9.27.6 (L1) Ensure 'Turn off picture password sign-in' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "BlockDomainPicturePassword" -expectedValue 1 -sectionNumber "18.9.27.6" -description "Turn off picture password sign-in" -recommendation "Enabled"

# 18.9.27.7 (L1) Ensure 'Turn on convenience PIN sign-in' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowDomainPINLogon" -expectedValue 0 -sectionNumber "18.9.27.7" -description "Turn on convenience PIN sign-in" -recommendation "Disabled"
