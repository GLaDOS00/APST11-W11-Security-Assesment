# Function to check the status of: Administrative Templates (Computer) - Credentials Delegation
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
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"

# 18.9.4.1 (L1) Ensure 'Encryption Oracle Remediation' is set to 'Enabled: Force Updated Clients'
Check-GPSetting -policyPath $RegPath -valueName "AllowEncryptionOracle" -expectedValue 2 -sectionNumber "18.9.4.1" -description "Encryption Oracle Remediation" -recommendation "Enabled: Force Updated Clients"

# 18.9.4.2 (L1) Ensure 'Remote host allows delegation of non-exportable credentials' is set to 'Enabled’
Check-GPSetting -policyPath $RegPath -valueName "AllowDelegatingNonExportableCredentials" -expectedValue 1 -sectionNumber "18.9.4.2" -description "Remote host allows delegation of non-exportable credentials" -recommendation "Enabled"
