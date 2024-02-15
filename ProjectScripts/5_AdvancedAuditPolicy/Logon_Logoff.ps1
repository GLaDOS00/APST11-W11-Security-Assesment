# PowerShell Script to Check Advanced Audit Policy Configuration - Logon/Logoff Against CIS Benchmarks for Windows 11 Enterprise

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

# Check the Logon/Logoff settings
Write-Host "Checking Advanced Audit Policy Configuration - Logon/Logoff against CIS Benchmarks..."

# Audit Account Lockout
$auditAccountLockout = Get-AuditPolicySetting "Account Lockout"
if ($auditAccountLockout."Inclusion Setting" -match "Failure") {
    Write-Host "17.5.1 (L1) Ensure 'Audit Account Lockout' is set to include 'Failure': Compliant"
} else {
    Write-Host "17.5.1 (L1) Ensure 'Audit Account Lockout' is set to include 'Failure': Non-Compliant"
}

# Audit Group Membership
$auditGroupMembership = Get-AuditPolicySetting "Group Membership"
if ($auditGroupMembership."Inclusion Setting" -match "Success") {
    Write-Host "17.5.2 (L1) Ensure 'Audit Group Membership' is set to include 'Success': Compliant"
} else {
    Write-Host "17.5.2 (L1) Ensure 'Audit Group Membership' is set to include 'Success': Non-Compliant"
}

# Audit Logoff
$auditLogoff = Get-AuditPolicySetting "Logoff"
if ($auditLogoff."Inclusion Setting" -match "Success") {
    Write-Host "17.5.3 (L1) Ensure 'Audit Logoff' is set to include 'Success': Compliant"
} else {
    Write-Host "17.5.3 (L1) Ensure 'Audit Logoff' is set to include 'Success': Non-Compliant"
}

# Audit Logon
$auditLogon = Get-AuditPolicySetting "Logon"
if ($auditLogon."Inclusion Setting" -eq "Success and Failure") {
    Write-Host "17.5.4 (L1) Ensure 'Audit Logon' is set to 'Success and Failure': Compliant"
} else {
    Write-Host "17.5.4 (L1) Ensure 'Audit Logon' is set to 'Success and Failure': Non-Compliant"
}

# Audit Other Logon/Logoff Events
$auditOtherLogonLogoffEvents = Get-AuditPolicySetting "Other Logon/Logoff Events"
if ($auditOtherLogonLogoffEvents."Inclusion Setting" -eq "Success and Failure") {
    Write-Host "17.5.5 (L1) Ensure 'Audit Other Logon/Logoff Events' is set to 'Success and Failure': Compliant"
} else {
    Write-Host "17.5.5 (L1) Ensure 'Audit Other Logon/Logoff Events' is set to 'Success and Failure': Non-Compliant"
}

# Audit Special Logon
$auditSpecialLogon = Get-AuditPolicySetting "Special Logon"
if ($auditSpecialLogon."Inclusion Setting" -match "Success") {
    Write-Host "17.5.6 (L1) Ensure 'Audit Special Logon' is set to include 'Success': Compliant"
} else {
    Write-Host "17.5.6 (L1) Ensure 'Audit Special Logon' is set to include 'Success': Non-Compliant"
}

# End of script
