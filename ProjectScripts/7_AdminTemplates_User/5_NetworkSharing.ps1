# Function to check the status of: Administrative Templates (User) - Network Sharing
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
$RegPath= "Registry::HKEY_USERS\$userSID\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"


# 19.7.25.1 (L1) Ensure 'Prevent users from sharing files within their profile' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "NoInplaceSharing" -expectedValue 1 -sectionNumber "19.7.25.1" -description "Prevent users from sharing files within their profile" -recommendation "Enabled"