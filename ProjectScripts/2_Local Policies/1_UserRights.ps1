# Define the desired settings as a hashtable
$desiredSettings = @{
    "SeTrustedCredManAccessPrivilege" = @(); # No One
    "SeNetworkLogonRight" = @("Administrators", "Remote Desktop Users"); # Administrators, Remote Desktop Users
    "SeTcbPrivilege" = @(); # No One
    "SeIncreaseQuotaPrivilege" = @("Administrators", "LOCAL SERVICE", "NETWORK SERVICE"); # Administrators, LOCAL SERVICE, NETWORK SERVICE
    "SeInteractiveLogonRight" = @("Administrators", "Users"); # Administrators, Users
    "SeRemoteInteractiveLogonRight" = @("Administrators", "Remote Desktop Users"); # Administrators, Remote Desktop Users
    "SeBackupPrivilege" = @("Administrators"); # Administrators
    "SeSystemtimePrivilege" = @("Administrators", "LOCAL SERVICE"); # Administrators, LOCAL SERVICE
    "SeTimeZonePrivilege" = @("Administrators", "LOCAL SERVICE", "Users"); # Administrators, LOCAL SERVICE, Users
    "SeCreatePagefilePrivilege" = @("Administrators"); # Administrators
    "SeCreateTokenPrivilege" = @(); # No One
    "SeCreateGlobalPrivilege" = @("Administrators", "LOCAL SERVICE", "NETWORK SERVICE"); # Administrators, LOCAL SERVICE, NETWORK SERVICE
}

# Export the local security policy
$exportPath = "C:\security_policy.inf"
secedit /export /cfg $exportPath

# Read the exported settings into a variable
$policyContent = Get-Content $exportPath

# Function to check policy settings
function Check-PolicySetting {
    param(
        [string]$policyIdentifier,
        [string[]]$correctSettings
    )

    $currentSetting = $policyContent | Where-Object { $_ -match "^$policyIdentifier\s*=\s*(.*)$" } | ForEach-Object {
        $matches[1] -split ","
    }

    $currentSetting = $currentSetting | ForEach-Object { $_.Trim() }

    # Compare arrays regardless of order
    $isCorrect = Compare-Object -ReferenceObject $correctSettings -DifferenceObject $currentSetting -SyncWindow 0

    if ($null -eq $isCorrect) {
        Write-Host "Policy '$policyIdentifier' is set correctly."
    }
    else {
        Write-Host "Policy '$policyIdentifier' is NOT set correctly. Expected: $($correctSettings -join ', ') - Actual: $($currentSetting -join ', ')"
    }
}

# Check each policy setting
foreach ($policy in $desiredSettings.Keys) {
    Check-PolicySetting -policyIdentifier $policy -correctSettings $desiredSettings[$policy]
}

# Clean up the exported file
Remove-Item -Path $exportPath -Force
