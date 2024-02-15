# Define function to check security setting
function Check-SecuritySetting {
    param (
        [string]$registryPath,
        [string]$valueName,
        [int]$expectedValue,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

    if ($currentValue -eq $null) {
        Write-Host "$valueName is not configured. Recommendation: $recommendation"
    } elseif ($currentValue.$valueName -eq $expectedValue) {
        Write-Host "$valueName is set to $expectedValue (Meets the recommendation)"
    } else {
        Write-Host "$valueName is set to $($currentValue.$valueName) (Does not meet the recommendation. Recommendation: $recommendation)"
    }
}

# 18.9.4.1 Ensure 'Encryption Oracle Remediation' is set to 'Enabled: Force Updated Clients'
$registryPath1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters"
$valueName1 = "AllowEncryptionOracle"
$expectedValue1 = 2
$recommendation1 = "Enabled: Force Updated Clients"
Check-SecuritySetting -registryPath $registryPath1 -valueName $valueName1 -expectedValue $expectedValue1 -recommendation $recommendation1

# 18.9.4.2 Ensure 'Remote host allows delegation of non-exportable credentials' is set to 'Enabled’
$registryPath2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"
$valueName2 = "AllowProtectedCreds"
$expectedValue2 = 1
$recommendation2 = "Enabled"
Check-SecuritySetting -registryPath $registryPath2 -valueName $valueName2 -expectedValue $expectedValue2 -recommendation $recommendation2
