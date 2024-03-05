# Function to check the status of: Administrative Templates (User) - Attachment Manager
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
$RegPath= "Registry::HKEY_USERS\$userSID\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments"


# 19.7.4.1 (L1) Ensure 'Do not preserve zone information in file attachments' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "SaveZoneInformation" -expectedValue 2 -sectionNumber "19.7.4.1" -description "Do not preserve zone information in file attachments" -recommendation "Disabled"

# 19.7.4.2 (L1) Ensure 'Notify antivirus programs when opening attachments' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "ScanWithAntiVirus" -expectedValue 3 -sectionNumber "19.7.4.2" -description "Notify antivirus programs when opening attachments" -recommendation "Enabled"
