# Function to check the status of the "Hardened UNC Paths" Group Policy setting
function Check-HardenedUNCPaths {
    param (
        [string]$policyPath,
        [string]$sectionNumber,
        [string]$description
    )

    $status = "Non-Compliant"
    $hardenedPaths = Get-ItemProperty -Path $policyPath -ErrorAction SilentlyContinue
    $requireMutualAuthAndIntegrity = $true

    # Check if both NETLOGON and SYSVOL shares have the required settings
    foreach ($valueName in $hardenedPaths.PSObject.Properties.Name) {
        $valueData = $hardenedPaths.$valueName
        # The value data should contain "RequireMutualAuthentication=1" and "RequireIntegrity=1"
        if (-not ($valueData -like "*RequireMutualAuthentication=1*" -and $valueData -like "*RequireIntegrity=1*")) {
            $requireMutualAuthAndIntegrity = $false
            break
        }
    }

    if ($requireMutualAuthAndIntegrity -and $hardenedPaths.PSObject.Properties.Count -gt 0) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to 'Enabled, with ""Require Mutual Authentication"" and ""Require Integrity"" set for all NETLOGON and SYSVOL shares': $status"
}

# Define the registry path for Network Provider settings
$networkProviderPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths"

# Check 'Hardened UNC Paths'
Check-HardenedUNCPaths -policyPath $networkProviderPolicyPath -sectionNumber "18.6.14.1" -description "Hardened UNC Paths"
