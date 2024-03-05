# PowerShell Script to Check Password Policies Against CIS Benchmarks for Windows 11 Enterprise

# Export the security settings to a temporary file
$seceditExportPath = "$env:TEMP\secpol.cfg"
secedit /export /cfg $seceditExportPath /quiet

# Function to parse the exported security settings file for a specific policy value
function Get-SecPolValue {
    param (
        [string]$policyName
    )
    $content = Get-Content -Path $seceditExportPath
    foreach ($line in $content) {
        if ($line.StartsWith($policyName)) {
            return $line.Split('=')[1].Trim()
        }
    }
}

# Enforce password history
$passwordHistory = Get-SecPolValue "PasswordHistorySize"
if ($passwordHistory -ge 24) {
    Write-Host "1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more password(s)': Compliant"
} else {
    Write-Host "1.1.1 (L1) Ensure 'Enforce password history' is set to '24 or more password(s)': Non-Compliant"
}

# Maximum password age
$maximumPasswordAge = Get-SecPolValue "MaximumPasswordAge"
if ($maximumPasswordAge -le 365 -and $maximumPasswordAge -ne 0) {
    Write-Host "1.1.2 (L1) Ensure 'Maximum password age' is set to '365 or fewer days, but not 0': Compliant"
} else {
    Write-Host "1.1.2 (L1) Ensure 'Maximum password age' is set to '365 or fewer days, but not 0': Non-Compliant"
}

# Minimum password age
$minimumPasswordAge = Get-SecPolValue "MinimumPasswordAge"
if ($minimumPasswordAge -ge 1) {
    Write-Host "1.1.3 (L1) Ensure 'Minimum password age' is set to '1 or more day(s)': Compliant"
} else {
    Write-Host "1.1.3 (L1) Ensure 'Minimum password age' is set to '1 or more day(s)': Non-Compliant"
}

# Minimum password length
$minimumPasswordLength = Get-SecPolValue "MinimumPasswordLength"
if ($minimumPasswordLength -ge 14) {
    Write-Host "1.1.4 (L1) Ensure 'Minimum password length' is set to '14 or more character(s)': Compliant"
} else {
    Write-Host "1.1.4 (L1) Ensure 'Minimum password length' is set to '14 or more character(s)': Non-Compliant"
}

# Password must meet complexity requirements
$passwordComplexity = Get-SecPolValue "PasswordComplexity"
if ($passwordComplexity -eq 1) {
    Write-Host "1.1.5 (L1) Ensure 'Password must meet complexity requirements' is set to 'Enabled': Compliant"
} else {
    Write-Host "1.1.5 (L1) Ensure 'Password must meet complexity requirements' is set to 'Enabled': Non-Compliant"
}

# Store passwords using reversible encryption
$storePasswordsReversibly = Get-SecPolValue "ClearTextPassword"
if ($storePasswordsReversibly -eq 0) {
    Write-Host "1.1.7 (L1) Ensure 'Store passwords using reversible encryption' is set to 'Disabled': Compliant"
} else {
    Write-Host "1.1.7 (L1) Ensure 'Store passwords using reversible encryption' is set to 'Disabled': Non-Compliant"
}

# Cleanup temporary file
Remove-Item $seceditExportPath -ErrorAction SilentlyContinue

