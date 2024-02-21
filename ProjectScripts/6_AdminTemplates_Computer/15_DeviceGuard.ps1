# Function to check the status of Group Policy setting
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
        [string]$description,
        [string]$recommendation # Adjusted to include recommendation dynamically
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to '$recommendation': $status"
}

# Device Guard settings checks
$deviceGuardPath = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard"
$hecipPath = "$deviceGuardPath\Scenarios\HypervisorEnforcedCodeIntegrity"
$codeIntegrityPath = "$deviceGuardPath\Scenarios\CodeIntegrity"
$memoryIntegrityPath = "$deviceGuardPath\Scenarios\MemoryIntegrity"
$credentialGuardPath = "$deviceGuardPath\Scenarios\CredentialGuard"
$secureLaunchPath = "$deviceGuardPath\Scenarios\SecureLaunch"
$hecipMemoryIntegrityPath = "$hecipPath\MemoryIntegrity"

# 18.9.5.1 Ensure 'Turn On Virtualization Based Security' is set to 'Enabled'
Check-GPSetting -policyPath $deviceGuardPath -valueName "EnableVirtualizationBasedSecurity" -expectedValue 1 -sectionNumber "18.9.5.1" -description "Turn On Virtualization Based Security" -recommendation "Enabled"

# 18.9.5.2 Ensure 'Turn On Virtualization Based Security: Select Platform Security Level' is set to 'Secure Boot' or higher
Check-GPSetting -policyPath $hecipPath -valueName "PlatformSecurityLevel" -expectedValue 2 -sectionNumber "18.9.5.2" -description "Turn On Virtualization Based Security: Select Platform Security Level" -recommendation "Secure Boot or higher"

# 18.9.5.3 Ensure 'Turn On Virtualization Based Security: Virtualization Based Protection of Code Integrity' is set to 'Enabled with UEFI lock'
Check-GPSetting -policyPath $hecipPath -valueName "RequirePlatformSecurityFeatures" -expectedValue 1 -sectionNumber "18.9.5.3" -description "Turn On Virtualization Based Security: Virtualization Based Protection of Code Integrity" -recommendation "Enabled with UEFI lock"

# 18.9.5.4 Ensure 'Turn On Virtualization Based Security: Require UEFI Memory Attributes Table' is set to 'True (checked)'
Check-GPSetting -policyPath $memoryIntegrityPath -valueName "RequireMATS" -expectedValue 1 -sectionNumber "18.9.5.4" -description "Turn On Virtualization Based Security: Require UEFI Memory Attributes Table" -recommendation "True (checked)"

# 18.9.5.5 Ensure 'Turn On Virtualization Based Security: Credential Guard Configuration' is set to 'Enabled with UEFI lock'
Check-GPSetting -policyPath $credentialGuardPath -valueName "Enabled" -expectedValue 1 -sectionNumber "18.9.5.5" -description "Turn On Virtualization Based Security: Credential Guard Configuration" -recommendation "Enabled with UEFI lock"

# 18.9.5.6 Ensure 'Turn On Virtualization Based Security: Secure Launch Configuration' is set to 'Enabled'
Check-GPSetting -policyPath $secureLaunchPath -valueName "SecureLaunchEnabled" -expectedValue 1 -sectionNumber "18.9.5.6" -description "Turn On Virtualization Based Security: Secure Launch Configuration" -recommendation "Enabled"

# 18.9.5.7 Ensure 'Turn On Virtualization Based Security: Kernel-mode Hardware-enforced Stack Protection' is set to 'Enabled: Enabled in enforcement mode'
Check-GPSetting -policyPath $hecipPath -valueName "HypervisorEnforcedCodeIntegrity" -expectedValue 1 -sectionNumber "18.9.5.7" -description "Turn On Virtualization Based Security: Kernel-mode Hardware-enforced Stack Protection" -recommendation "Enabled: Enabled in enforcement mode"
