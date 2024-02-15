# PowerShell Script to Check Advanced Audit Policy Configuration - System Against CIS Benchmarks for Windows 11 Enterprise

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

# Check the System settings
Write-Host "Checking Advanced Audit Policy Configuration - System against CIS Benchmarks..."

# Audit IPsec Driver
$auditIPsecDriver = Get-AuditPolicySetting "IPsec Driver"
if ($auditIPsecDriver."Inclusion Setting" -eq "Success and Failure") {
    Write-Host "17.9.1 (L1) Ensure 'Audit IPsec Driver' is set to 'Success and Failure': Compliant"
} else {
    Write-Host "17.9.1 (L1) Ensure 'Audit IPsec Driver' is set to 'Success and Failure': Non-Compliant"
}

# Audit Other System Events
$auditOtherSystemEvents = Get-AuditPolicySetting "Other System Events"
if ($auditOtherSystemEvents."Inclusion Setting" -eq "Success and Failure") {
    Write-Host "17.9.2 (L1) Ensure 'Audit Other System Events' is set to 'Success and Failure': Compliant"
} else {
    Write-Host "17.9.2 (L1) Ensure 'Audit Other System Events' is set to 'Success and Failure': Non-Compliant"
}

# Audit Security State Change
$auditSecurityStateChange = Get-AuditPolicySetting "Security State Change"
if ($auditSecurityStateChange."Inclusion Setting" -match "Success") {
    Write-Host "17.9.3 (L1) Ensure 'Audit Security State Change' is set to include 'Success': Compliant"
} else {
    Write-Host "17.9.3 (L1) Ensure 'Audit Security State Change' is set to include 'Success': Non-Compliant"
}

# Audit Security System Extension
$auditSecuritySystemExtension = Get-AuditPolicySetting "Security System Extension"
if ($auditSecuritySystemExtension."Inclusion Setting" -match "Success") {
    Write-Host "17.9.4 (L1) Ensure 'Audit Security System Extension' is set to include 'Success': Compliant"
} else {
    Write-Host "17.9.4 (L1) Ensure 'Audit Security System Extension' is set to include 'Success': Non-Compliant"
}

# Audit System Integrity
$auditSystemIntegrity = Get-AuditPolicySetting "System Integrity"
if ($auditSystemIntegrity."Inclusion Setting" -eq "Success and Failure") {
    Write-Host "17.9.5 (L1) Ensure 'Audit System Integrity' is set to 'Success and Failure': Compliant"
} else {
    Write-Host "17.9.5 (L1) Ensure 'Audit System Integrity' is set to 'Success and Failure': Non-Compliant"
}

# End of script
