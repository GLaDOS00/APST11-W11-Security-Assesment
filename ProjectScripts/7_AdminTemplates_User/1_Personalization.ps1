# Function to check the status of: Administrative Templates (User) - Personalization
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
        [string]$description,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName 
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to '$recommendation': $status"
}

# Automatically get the current username
$currentUserName = $env:USERNAME

# Get the SID for the current user
$userSID = (Get-WmiObject -Class Win32_UserAccount -Filter "Name = '$currentUserName'").SID

# Corrected Registry Path:
$RegPath= "Registry::HKEY_USERS\$userSID\Software\Policies\Microsoft\Windows\Control Panel\Desktop"

# 19.1.3.1 (L1) Ensure 'Enable screen saver' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "ScreenSaveActive" -expectedValue 1 -sectionNumber "19.1.3.1" -description "Enable screen saver" -recommendation "Enabled"

# 19.1.3.2 (L1) Ensure 'Password protect the screen saver' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "ScreenSaverIsSecure" -expectedValue 1 -sectionNumber "19.1.3.2" -description "Password protect the screen saver" -recommendation "Enabled"

# 19.1.3.3 (L1) Ensure 'Screen saver timeout' is set to 'Enabled: 900 seconds or fewer, but not 0'
Check-GPSetting -policyPath $RegPath -valueName "ScreenSaveTimeOut" -expectedValue 900 -sectionNumber "19.1.3.3" -description "Screen saver timeout" -recommendation "Enabled: 900 seconds or fewer, but not 0"