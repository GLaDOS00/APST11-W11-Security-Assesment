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
        [string]$sectionNumber
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber Ensure '$valueName' is set to 'Enabled' : $status"
}

# Check the status of LAPS AdmPwd GPO Extension / CSE installation
Check-LAPS-GPSettings -policyPath $lapsAdmPwdPolicyPath -valueName $lapsAdmPwdGPOExtensionValueName -expectedValue 1 -sectionNumber "18.3.1 (L1)"

# Check the status of 'Do not allow password expiration time longer than required by policy'
Check-LAPS-GPSettings -policyPath $lapsPasswordPolicyPath -valueName $allowPasswordExpirationValueName -expectedValue 1 -sectionNumber "18.3.2 (L1)"

# Check the status of 'Enable Local Admin Password Management'
Check-LAPS-GPSettings -policyPath $lapsPasswordPolicyPath -valueName $enableLocalAdminPasswordManagementValueName -expectedValue 1 -sectionNumber "18.3.3 (L1)"

# Check the status of 'Password Settings: Password Complexity'
# Note: The expectedValue might need adjustment based on how complexity is stored/checked
Check-LAPS-GPSettings -policyPath $lapsPasswordPolicyPath -valueName $passwordComplexityValueName -expectedValue 1 -sectionNumber "18.3.4 (L1)"

# Check the status of 'Password Settings: Password Length'
Check-LAPS-GPSettings -policyPath $lapsPasswordPolicyPath -valueName $passwordLengthValueName -expectedValue 15 -sectionNumber "18.3.5 (L1)"

# Check the status of 'Password Settings: Password Age (Days)'
Check-LAPS-GPSettings -policyPath $lapsPasswordPolicyPath -valueName $passwordAgeDaysValueName -expectedValue 30 -sectionNumber "18.3.6 (L1)"
