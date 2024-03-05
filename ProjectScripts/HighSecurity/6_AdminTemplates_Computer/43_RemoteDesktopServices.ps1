# Function to check the status of: Administrative Templates (Computer) - Remote Desktop Services
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"


# 18.10.57.2.3 (L1) Ensure 'Do not allow passwords to be saved' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DisablePasswordSaving" -expectedValue 1 -sectionNumber "18.10.57.2.3" -description "Do not allow passwords to be saved" -recommendation "Enabled"

# 18.10.57.3.3.3 (L1) Ensure 'Do not allow drive redirection' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "fDisableCdm" -expectedValue 1 -sectionNumber "18.10.57.3.3.3" -description "Do not allow drive redirection" -recommendation "Enabled"

# 18.10.57.3.9.1 (L1) Ensure 'Always prompt for password upon connection' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "fPromptForPassword" -expectedValue 1 -sectionNumber "18.10.57.3.9.1" -description "Always prompt for password upon connection" -recommendation "Enabled"

# 18.10.57.3.9.2 (L1) Ensure 'Require secure RPC communication' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "fEncryptRPCTraffic" -expectedValue 1 -sectionNumber "18.10.57.3.9.2" -description "Require secure RPC communication" -recommendation "Enabled"

# 18.10.57.3.9.3 (L1) Ensure 'Require use of specific security layer for remote (RDP) connections' is set to 'Enabled: SSL'
Check-GPSetting -policyPath $RegPath -valueName "SecurityLayer" -expectedValue 2 -sectionNumber "18.10.57.3.9.3" -description "Require use of specific security layer for remote (RDP) connections" -recommendation "Enabled: SSL"

# 18.10.57.3.9.4 (L1) Ensure 'Require user authentication for remote connections by using Network Level Authentication' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "UserAuthentication" -expectedValue 1 -sectionNumber "18.10.57.3.9.4" -description "Require user authentication for remote connections by using Network Level Authentication" -recommendation "Enabled"

# 18.10.57.3.9.5 (L1) Ensure 'Set client connection encryption level' is set to 'Enabled: High Level'
Check-GPSetting -policyPath $RegPath -valueName "MinEncryptionLevel" -expectedValue 3 -sectionNumber "18.10.57.3.9.5" -description "Set client connection encryption level" -recommendation "Enabled: High Level"

# 18.10.57.3.11.1 (L1) Ensure 'Do not delete temp folders upon exit' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "DeleteTempDirsOnExit" -expectedValue 1 -sectionNumber "18.10.57.3.11.1" -description "Do not delete temp folders upon exit" -recommendation "Disable"
