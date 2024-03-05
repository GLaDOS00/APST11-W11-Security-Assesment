# Function to check the status of: Administrative Templates (Computer) - LAPS
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
$RegPath1= "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{D76B9641-3288-4f75-942D-087DE603E3EA}:DllName"
$RegPath2 = "HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd\Policies"


# 18.3.1 (L1) Ensure LAPS AdmPwd GPO Extension / CSE is installed
Check-GPSetting -policyPath $RegPath1 -valueName "AdmPwdEnabled" -expectedValue 1 -sectionNumber "18.3.1" -description "LAPS AdmPwd GPO Extension / CSE" -recommendation "Installed"

# 18.3.2 (L1) Ensure 'Do not allow password expiration time longer than required by policy' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "AdmPwdUsePasswordExpPolicy" -expectedValue 1 -sectionNumber "18.3.2" -description "Do not allow password expiration time longer than required by policy" -recommendation "Enabled"

# 18.3.3 (L1) Ensure 'Enable Local Admin Password Management' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "AdmPwdEnabled" -expectedValue 1 -sectionNumber "18.3.3" -description "Enable Local Admin Password Management" -recommendation "Enabled"

# 18.3.4 (L1) Ensure 'Password Settings: Password Complexity' is set to 'Enabled: Large letters + small letters + numbers + special characters'
Check-GPSetting -policyPath $RegPath2 -valueName "AdmPwdPwdComplexity" -expectedValue 1 -sectionNumber "18.3.4" -description "Password Settings: Password Complexity" -recommendation "Enabled: Large letters + small letters + numbers + special characters"

# 18.3.5 (L1) Ensure 'Password Settings: Password Length' is set to 'Enabled: 15 or more'
Check-GPSetting -policyPath $RegPath2 -valueName "AdmPwdPwdLength" -expectedValue 15 -sectionNumber "18.3.5" -description "Password Settings: Password Length" -recommendation "Enabled: 15 or more"

# 18.3.6 (L1) Ensure 'Password Settings: Password Age (Days)' is set to 'Enabled: 30 or fewer'
Check-GPSetting -policyPath $RegPath2 -valueName "AdmPwdPwdAge" -expectedValue 30 -sectionNumber "18.3.6" -description "Password Settings: Password Age (Days)" -recommendation "Enabled: 30 or fewer"
