# PowerShell Script to Check Advanced Audit Policy Configuration - Account Logon Against CIS Benchmarks for Windows 11 Enterprise

# Function to get the audit policy setting for a specific subcategory
function Get-AuditPolicySetting {
    param (
        [string]$subcategoryName
    )
    $auditPolicy = auditpol /get /subcategory:$subcategoryName | Out-String
    return $auditPolicy
}

# Check the 'Audit Credential Validation' setting

# Audit Credential Validation
$auditCredentialValidation = Get-AuditPolicySetting "Credential Validation"
if ($auditCredentialValidation -match "Success and Failure") {
    Write-Host "17.1.1 (L1) Ensure 'Audit Credential Validation' is set to 'Success and Failure': Compliant"
} else {
    Write-Host "17.1.1 (L1) Ensure 'Audit Credential Validation' is set to 'Success and Failure': Non-Compliant"
}

