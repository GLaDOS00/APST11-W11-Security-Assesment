# PowerShell Script to Check Advanced Audit Policy Configuration - Privilege Use Against CIS Benchmarks for Windows 11 Enterprise

# Function to get the audit policy setting for a specific subcategory
function Get-AuditPolicySetting {
    param (
        [string]$subcategoryName
    )
    $auditPolicy = auditpol /get /subcategory:"$subcategoryName" /r | ConvertFrom-Csv
    foreach ($line in $auditPolicy) {
        if ($line.SubcategoryName -eq $subcategoryName) {
            return $line
        }
    }
}

# Check the Privilege Use settings

# Audit Sensitive Privilege Use
$auditSensitivePrivilegeUse = Get-AuditPolicySetting "Sensitive Privilege Use"
if ($auditSensitivePrivilegeUse."Inclusion Setting" -eq "Success and Failure") {
    Write-Host "17.8.1 (L1) Ensure 'Audit Sensitive Privilege Use' is set to 'Success and Failure': Compliant"
} else {
    Write-Host "17.8.1 (L1) Ensure 'Audit Sensitive Privilege Use' is set to 'Success and Failure': Non-Compliant"
}

# End of script
