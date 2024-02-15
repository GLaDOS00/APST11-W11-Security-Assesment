# Define Group Policy paths for LAPS
$lapsAdmPwdPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd"
$lapsPasswordPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd\Policies"

# Define Group Policy values for LAPS
$lapsAdmPwdGPOExtensionValueName = "AdmPwdEnabled"
$allowPasswordExpirationValueName = "AdmPwdUsePasswordExpPolicy"
$enableLocalAdminPasswordManagementValueName = "AdmPwdEnabled"
$passwordComplexityValueName = "AdmPwdPwdComplexity"
$passwordLengthValueName = "AdmPwdPwdLength"
$passwordAgeDaysValueName = "AdmPwdPwdAge"

# Function to check the status of LAPS Group Policy settings
function Check-LAPS-GPSettings {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue

    if ($currentValue -eq $null) {
        Write-Host "$valueName is not configured. Recommendation: $recommendation"
    } elseif ($currentValue.$valueName -eq $expectedValue) {
        Write-Host "$valueName is set to $expectedValue (Meets the recommendation)"
    } else {
        Write-Host "$valueName is set to $($currentValue.$valueName) (Does not meet the recommendation. Recommendation: $recommendation)"
    }
}

# Check the status of LAPS AdmPwd GPO Extension / CSE installation
Check-LAPS-GPSettings -policyPath $lapsAdmPwdPolicyPath -valueName $lapsAdmPwdGPOExtensionValueName -expectedValue 1 -recommendation "Install LAPS AdmPwd GPO Extension / CSE"

# Check the status of 'Do not allow password expiration time longer than required by policy'
Check-LAPS-GPSettings -policyPath $lapsPasswordPolicyPath -valueName $allowPasswordExpirationValueName -expectedValue 1 -recommendation "Enable"

# Check the status of 'Enable Local Admin Password Management'
Check-LAPS-GPSettings -policyPath $lapsPasswordPolicyPath -valueName $enableLocalAdminPasswordManagementValueName -expectedValue 1 -recommendation "Enable"

# Check the status of 'Password Settings: Password Complexity'
Check-LAPS-GPSettings -policyPath $lapsPasswordPolicyPath -valueName $passwordComplexityValueName -expectedValue 1 -recommendation "Enable: Large letters + small letters + numbers + special characters"

# Check the status of 'Password Settings: Password Length'
Check-LAPS-GPSettings -policyPath $lapsPasswordPolicyPath -valueName $passwordLengthValueName -expectedValue 15 -recommendation "Enable: 15 or more"

# Check the status of 'Password Settings: Password Age (Days)'
Check-LAPS-GPSettings -policyPath $lapsPasswordPolicyPath -valueName $passwordAgeDaysValueName -expectedValue 30 -recommendation "Enable: 30 or fewer"
