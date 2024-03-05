# PowerShell Script to Check Advanced Audit Policy Configuration - Detailed Tracking Against CIS Benchmarks for Windows 11 Enterprise

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

# Check the 'Audit PNP Activity' setting

# Audit PNP Activity
$auditPnpActivity = Get-AuditPolicySetting "Plug and Play Events"
if ($auditPnpActivity."Inclusion Setting" -match "Success") {
    Write-Host "17.3.1 (L1) Ensure 'Audit PNP Activity' is set to include 'Success': Compliant"
} else {
    Write-Host "17.3.1 (L1) Ensure 'Audit PNP Activity' is set to include 'Success': Non-Compliant"
}

# Audit Process Creation
$auditProcessCreation = Get-AuditPolicySetting "Process Creation"
if ($auditProcessCreation."Inclusion Setting" -match "Success") {
    Write-Host "17.3.2 (L1) Ensure 'Audit Process Creation' is set to include 'Success': Compliant"
} else {
    Write-Host "17.3.2 (L1) Ensure 'Audit Process Creation' is set to include 'Success': Non-Compliant"
}

