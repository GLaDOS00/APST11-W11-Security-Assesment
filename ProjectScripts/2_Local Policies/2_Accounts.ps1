# Function to check the status of Local Policy - Accounts
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

# Regristry Value Paths:
$RegPath1= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$RegPath2= "HKLM:\SAM\SAM\Domains\Account\Users\Names\Guest"
$RegPath3= "HKLM:\System\CurrentControlSet\Control\Lsa"


# 2.3.1.1 (L1) Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts'
Check-GPSetting -policyPath $RegPath1 -valueName "NoConnectedUser" -expectedValue 3 -sectionNumber "2.3.1.1" -description "Accounts: Block Microsoft accounts" -recommendation "Users can't add or log on with Microsoft accounts"

# 2.3.1.2 (L1) Ensure 'Accounts: Guest account status' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2-valueName "UserAccountControl" -expectedValue 2 -sectionNumber "2.3.1.2" -description "Accounts: Guest account status" -recommendation "Disabled"

# 2.3.1.3 (L1) Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath3 -valueName "LimitBlankPasswordUse" -expectedValue 1 -sectionNumber "2.3.1.3" -description "Accounts: Limit local account use of blank passwords to console logon only" -recommendation "Enabled"
