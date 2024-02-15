# PowerShell Script to Check Advanced Audit Policy Configuration - Account Management Against CIS Benchmarks for Windows 11 Enterprise

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

# Check the 'Audit Application Group Management' setting
Write-Host "Checking Advanced Audit Policy Configuration - Account Management against CIS Benchmarks..."

# Audit Application Group Management
$auditAppGroupManagement = Get-AuditPolicySetting "Application Group Management"
if ($auditAppGroupManagement."Inclusion Setting" -eq "Success and Failure") {
    Write-Host "17.2.1 (L1) Ensure 'Audit Application Group Management' is set to 'Success and Failure': Compliant"
} else {
    Write-Host "17.2.1 (L1) Ensure 'Audit Application Group Management' is set to 'Success and Failure': Non-Compliant"
}

# Audit Security Group Management
$auditSecGroupManagement = Get-AuditPolicySetting "Security Group Management"
if ($auditSecGroupManagement."Inclusion Setting" -match "Success") {
    Write-Host "17.2.2 (L1) Ensure 'Audit Security Group Management' is set to include 'Success': Compliant"
} else {
    Write-Host "17.2.2 (L1) Ensure 'Audit Security Group Management' is set to include 'Success': Non-Compliant"
}

# Audit User Account Management
$auditUserAccountManagement = Get-AuditPolicySetting "User Account Management"
if ($auditUserAccountManagement."Inclusion Setting" -eq "Success and Failure") {
    Write-Host "17.2.3 (L1) Ensure 'Audit User Account Management' is set to 'Success and Failure': Compliant"
} else {
    Write-Host "17.2.3 (L1) Ensure 'Audit User Account Management' is set to 'Success and Failure': Non-Compliant"
}

# End of script
