# Function to check the status of: Administrative Templates (User) - Windows Media Player
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
$RegPath= "Registry::HKEY_USERS\$userSID\Software\Policies\Microsoft\WindowsMediaPlayer"


# 19.7.42.2.1 (L2) Ensure 'Prevent Codec Download' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "PreventCodecDownload" -expectedValue 1 -sectionNumber "19.7.42.2.1" -level "(L2)" -description "Prevent Codec Download" -recommendation "Enabled"