# Function to check the status of: Administrative Templates (User) - Cloud Content
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

# Automatically get the current username
$currentUserName = $env:USERNAME

# Get the SID for the current user
$userSID = (Get-WmiObject -Class Win32_UserAccount -Filter "Name = '$currentUserName'").SID

# Corrected Registry Path:
$RegPath= "Registry::HKEY_USERS\$userSID\Software\Policies\Microsoft\Windows\CloudContent"


# 19.7.7.1 (L1) Ensure 'Configure Windows spotlight on lock screen' is set to Disabled'
Check-GPSetting -policyPath $RegPath -valueName "ConfigureWindowsSpotlight" -expectedValue 2 -sectionNumber "19.7.7.1" -description "Configure Windows spotlight on lock screen" -recommendation "Disabled"


# 19.7.7.2 (L1) Ensure 'Do not suggest third-party content in Windows spotlight' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DisableThirdPartySuggestions" -expectedValue 1 -sectionNumber "19.7.7.2" -description "Do not suggest third-party content in Windows spotlight" -recommendation "Enabled"


# 19.7.7.5 (L1) Ensure 'Turn off Spotlight collection on Desktop' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DisableSpotlightCollectionOnDesktop" -expectedValue 1 -sectionNumber "19.7.7.5" -description "Turn off Spotlight collection on Desktop" -recommendation "Enabled"