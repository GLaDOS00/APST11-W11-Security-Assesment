# Define function to check security setting
function Check-SecuritySetting {
    param (
        [string]$registryPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

    if ($currentValue -eq $null) {
        Write-Host "$valueName is not configured. Recommendation: $recommendation"
    } elseif ($currentValue.$valueName -eq $expectedValue) {
        Write-Host "$valueName is set to $expectedValue (Meets the recommendation)"
    } else {
        Write-Host "$valueName is set to $($currentValue.$valueName) (Does not meet the recommendation. Recommendation: $recommendation)"
    }
}

# 18.9.5.1 Ensure 'Turn On Virtualization Based Security' is set to 'Enabled'
$registryPath1 = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard"
$valueName1 = "EnableVirtualizationBasedSecurity"
$expectedValue1 = "1"
$recommendation1 = "Enabled"
Check-SecuritySetting -registryPath $registryPath1 -valueName $valueName1 -expectedValue $expectedValue1 -recommendation $recommendation1

# 18.9.5.2 Ensure 'Turn On Virtualization Based Security: Select Platform Security Level' is set to 'Secure Boot' or higher
$registryPath2 = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"
$valueName2 = "Enabled"
$expectedValue2 = "1"
$recommendation2 = "Enabled"
Check-SecuritySetting -registryPath $registryPath2 -valueName $valueName2 -expectedValue $expectedValue2 -recommendation $recommendation2

# 18.9.5.3 Ensure 'Turn On Virtualization Based Security: Virtualization Based Protection of Code Integrity' is set to 'Enabled with UEFI lock'
$registryPath3 = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CodeIntegrity"
$valueName3 = "Enabled"
$expectedValue3 = "1"
$recommendation3 = "Enabled"
Check-SecuritySetting -registryPath $registryPath3 -valueName $valueName3 -expectedValue $expectedValue3 -recommendation $recommendation3

# 18.9.5.4 Ensure 'Turn On Virtualization Based Security: Require UEFI Memory Attributes Table' is set to 'True (checked)'
$registryPath4 = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\MemoryIntegrity"
$valueName4 = "Enabled"
$expectedValue4 = "1"
$recommendation4 = "Enabled"
Check-SecuritySetting -registryPath $registryPath4 -valueName $valueName4 -expectedValue $expectedValue4 -recommendation $recommendation4

# 18.9.5.5 Ensure 'Turn On Virtualization Based Security: Credential Guard Configuration' is set to 'Enabled with UEFI lock'
$registryPath5 = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard"
$valueName5 = "Enabled"
$expectedValue5 = "1"
$recommendation5 = "Enabled"
Check-SecuritySetting -registryPath $registryPath5 -valueName $valueName5 -expectedValue $expectedValue5 -recommendation $recommendation5

# 18.9.5.6 Ensure 'Turn On Virtualization Based Security: Secure Launch Configuration' is set to 'Enabled'
$registryPath6 = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SecureLaunch"
$valueName6 = "Enabled"
$expectedValue6 = "1"
$recommendation6 = "Enabled"
Check-SecuritySetting -registryPath $registryPath6 -valueName $valueName6 -expectedValue $expectedValue6 -recommendation $recommendation6

# 18.9.5.7 Ensure 'Turn On Virtualization Based Security: Kernel-mode Hardware-enforced Stack Protection' is set to 'Enabled: Enabled in enforcement mode'
$registryPath7 = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity\MemoryIntegrity"
$valueName7 = "Enabled"
$expectedValue7 = "1"
$recommendation7 = "Enabled"
Check-SecuritySetting -registryPath $registryPath7 -valueName $valueName7 -expectedValue $expectedValue7 -recommendation $recommendation7
