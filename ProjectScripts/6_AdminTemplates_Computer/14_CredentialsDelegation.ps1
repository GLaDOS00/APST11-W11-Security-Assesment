# Function to check the status of Group Policy setting
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

# Define the registry path for Credentials Delegation settings
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"

# Encryption Oracle Remediation - 'Enabled: Force Updated Clients'
Check-GPSetting -policyPath $RegPath -valueName "AllowEncryptionOracle" -expectedValue 2 -sectionNumber "18.9.4.1" -description "Encryption Oracle Remediation" -recommendation "Enabled: Force Updated Clients"

# Remote host allows delegation of non-exportable credentials - 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowDelegatingNonExportableCredentials" -expectedValue 1 -sectionNumber "18.9.4.2" -description "Remote host allows delegation of non-exportable credentials" -recommendation "Enabled"
