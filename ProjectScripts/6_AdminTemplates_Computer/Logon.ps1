# Define function to check Logon setting
function Check-LogonSetting {
    param (
        [string]$registryPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

    if ($currentValue -eq $null) {
        Write-Host "$valueName is not configured. Recommendation: $recommendation"
    } elseif ($currentValue.$valueName -eq $expectedValue) {
        Write-Host "$valueName is set to $expectedValue (Meets the recommendation)"
    } else {
        Write-Host "$valueName is set to $($currentValue.$valueName) (Does not meet the recommendation. Recommendation: $recommendation)"
    }
}

# 18.9.27.1 Ensure 'Block user from showing account details on sign-in' is set to 'Enabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "BlockUserFromShowingAccountDetailsOnSignin"
$expectedValue = "1"
$recommendation = "Enabled"
Check-LogonSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.27.2 Ensure 'Do not display network selection UI' is set to 'Enabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "DontDisplayNetworkSelectionUI"
$expectedValue = "1"
$recommendation = "Enabled"
Check-LogonSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.27.3 Ensure 'Do not enumerate connected users on domain-joined computers' is set to 'Enabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "DontEnumerateConnectedUsers"
$expectedValue = "1"
$recommendation = "Enabled"
Check-LogonSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.27.4 Ensure 'Enumerate local users on domain-joined computers' is set to 'Disabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "EnumerateLocalUsers"
$expectedValue = "0"
$recommendation = "Disabled"
Check-LogonSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.27.5 Ensure 'Turn off app notifications on the lock screen' is set to 'Enabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "DisableLockScreenAppNotifications"
$expectedValue = "1"
$recommendation = "Enabled"
Check-LogonSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.27.6 Ensure 'Turn off picture password sign-in' is set to 'Enabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "NoChangingLockScreenPicture"
$expectedValue = "1"
$recommendation = "Enabled"
Check-LogonSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.27.7 Ensure 'Turn on convenience PIN sign-in' is set to 'Disabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "AllowDomainPINLogon"
$expectedValue = "0"
$recommendation = "Disabled"
Check-LogonSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation
