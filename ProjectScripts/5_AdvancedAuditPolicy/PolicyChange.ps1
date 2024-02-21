# PowerShell Script to Check Advanced Audit Policy Configuration - Policy Change Against CIS Benchmarks for Windows 11 Enterprise

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

# Check the Policy Change settings

# Audit Audit Policy Change
$auditAuditPolicyChange = Get-AuditPolicySetting "Audit Policy Change"
if ($auditAuditPolicyChange."Inclusion Setting" -match "Success") {
    Write-Host "17.7.1 (L1) Ensure 'Audit Audit Policy Change' is set to include 'Success': Compliant"
} else {
    Write-Host "17.7.1 (L1) Ensure 'Audit Audit Policy Change' is set to include 'Success': Non-Compliant"
}

# Audit Authentication Policy Change
$auditAuthenticationPolicyChange = Get-AuditPolicySetting "Authentication Policy Change"
if ($auditAuthenticationPolicyChange."Inclusion Setting" -match "Success") {
    Write-Host "17.7.2 (L1) Ensure 'Audit Authentication Policy Change' is set to include 'Success': Compliant"
} else {
    Write-Host "17.7.2 (L1) Ensure 'Audit Authentication Policy Change' is set to include 'Success': Non-Compliant"
}

# Audit Authorization Policy Change
$auditAuthorizationPolicyChange = Get-AuditPolicySetting "Authorization Policy Change"
if ($auditAuthorizationPolicyChange."Inclusion Setting" -match "Success") {
    Write-Host "17.7.3 (L1) Ensure 'Audit Authorization Policy Change' is set to include 'Success': Compliant"
} else {
    Write-Host "17.7.3 (L1) Ensure 'Audit Authorization Policy Change' is set to include 'Success': Non-Compliant"
}

# Audit MPSSVC Rule-Level Policy Change
$auditMPSSVCRuleLevelPolicyChange = Get-AuditPolicySetting "MPSSVC Rule-Level Policy Change"
if ($auditMPSSVCRuleLevelPolicyChange."Inclusion Setting" -eq "Success and Failure") {
    Write-Host "17.7.4 (L1) Ensure 'Audit MPSSVC Rule-Level Policy Change' is set to 'Success and Failure': Compliant"
} else {
    Write-Host "17.7.4 (L1) Ensure 'Audit MPSSVC Rule-Level Policy Change' is set to 'Success and Failure': Non-Compliant"
}

# Audit Other Policy Change Events
$auditOtherPolicyChangeEvents = Get-AuditPolicySetting "Other Policy Change Events"
if ($auditOtherPolicyChangeEvents."Inclusion Setting" -match "Failure") {
    Write-Host "17.7.5 (L1) Ensure 'Audit Other Policy Change Events' is set to include 'Failure': Compliant"
} else {
    Write-Host "17.7.5 (L1) Ensure 'Audit Other Policy Change Events' is set to include 'Failure': Non-Compliant"
}

# End of script
