# Function to check the status of:  - 

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
    return $null  # Ensure function returns $null if the policy is not found
}


#
$policyValue = Get-SecPolValue ""
if ($policyValue -eq "") {
    Write-Host ": Compliant"
} else {
    Write-Host ": Non-Compliant"
}