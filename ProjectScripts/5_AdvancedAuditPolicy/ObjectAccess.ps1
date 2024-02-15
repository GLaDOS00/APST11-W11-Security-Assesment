# PowerShell Script to Check Advanced Audit Policy Configuration - Object Access Against CIS Benchmarks for Windows 11 Enterprise

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

# Check the Object Access settings
Write-Host "Checking Advanced Audit Policy Configuration - Object Access against CIS Benchmarks..."

# Audit Detailed File Share
$auditDetailedFileShare = Get-AuditPolicySetting "Detailed File Share"
if ($auditDetailedFileShare."Inclusion Setting" -match "Failure") {
    Write-Host "17.6.1 (L1) Ensure 'Audit Detailed File Share' is set to include 'Failure': Compliant"
} else {
    Write-Host "17.6.1 (L1) Ensure 'Audit Detailed File Share' is set to include 'Failure': Non-Compliant"
}

# Audit File Share
$auditFileShare = Get-AuditPolicySetting "File Share"
if ($auditFileShare."Inclusion Setting" -eq "Success and Failure") {
    Write-Host "17.6.2 (L1) Ensure 'Audit File Share' is set to 'Success and Failure': Compliant"
} else {
    Write-Host "17.6.2 (L1) Ensure 'Audit File Share' is set to 'Success and Failure': Non-Compliant"
}

# Audit Other Object Access Events
$auditOtherObjectAccessEvents = Get-AuditPolicySetting "Other Object Access Events"
if ($auditOtherObjectAccessEvents."Inclusion Setting" -eq "Success and Failure") {
    Write-Host "17.6.3 (L1) Ensure 'Audit Other Object Access Events' is set to 'Success and Failure': Compliant"
} else {
    Write-Host "17.6.3 (L1) Ensure 'Audit Other Object Access Events' is set to 'Success and Failure': Non-Compliant"
}

# Audit Removable Storage
$auditRemovableStorage = Get-AuditPolicySetting "Removable Storage"
if ($auditRemovableStorage."Inclusion Setting" -eq "Success and Failure") {
    Write-Host "17.6.4 (L1) Ensure 'Audit Removable Storage' is set to 'Success and Failure': Compliant"
} else {
    Write-Host "17.6.4 (L1) Ensure 'Audit Removable Storage' is set to 'Success and Failure': Non-Compliant"
}

# End of script
