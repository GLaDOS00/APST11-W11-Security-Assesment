# Function to check the status of: Administrative Templates (Computer) - Device Guard
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
        [string]$description,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to '$recommendation': $status"
}

# Registry Values:
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard"


# 18.9.5.1 Ensure 'Turn On Virtualization Based Security' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableVirtualizationBasedSecurity" -expectedValue 1 -sectionNumber "18.9.5.1" -description "Turn On Virtualization Based Security" -recommendation "Enabled"

# 18.9.5.2 Ensure 'Turn On Virtualization Based Security: Select Platform Security Level' is set to 'Secure Boot' or higher
Check-GPSetting -policyPath $RegPath -valueName "RequirePlatformSecurityFeatures" -expectedValue 3 -sectionNumber "18.9.5.2" -description "Turn On Virtualization Based Security: Select Platform Security Level" -recommendation "Secure Boot or higher"

# 18.9.5.3 Ensure 'Turn On Virtualization Based Security: Virtualization Based Protection of Code Integrity' is set to 'Enabled with UEFI lock'
Check-GPSetting -policyPath $RegPath -valueName "HypervisorEnforcedCodeIntegrity" -expectedValue 1 -sectionNumber "18.9.5.3" -description "Turn On Virtualization Based Security: Virtualization Based Protection of Code Integrity" -recommendation "Enabled with UEFI lock"

# 18.9.5.4 Ensure 'Turn On Virtualization Based Security: Require UEFI Memory Attributes Table' is set to 'True (checked)'
Check-GPSetting -policyPath $RegPath -valueName "HVCIMATRequired" -expectedValue 1 -sectionNumber "18.9.5.4" -description "Turn On Virtualization Based Security: Require UEFI Memory Attributes Table" -recommendation "True (checked)"

# 18.9.5.5 Ensure 'Turn On Virtualization Based Security: Credential Guard Configuration' is set to 'Enabled with UEFI lock'
Check-GPSetting -policyPath $RegPath -valueName "LsaCfgFlags" -expectedValue 1 -sectionNumber "18.9.5.5" -description "Turn On Virtualization Based Security: Credential Guard Configuration" -recommendation "Enabled with UEFI lock"

# 18.9.5.6 Ensure 'Turn On Virtualization Based Security: Secure Launch Configuration' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "ConfigureSystemGuardLaunch" -expectedValue 1 -sectionNumber "18.9.5.6" -description "Turn On Virtualization Based Security: Secure Launch Configuration" -recommendation "Enabled"

# 18.9.5.7 Ensure 'Turn On Virtualization Based Security: Kernel-mode Hardware-enforced Stack Protection' is set to 'Enabled: Enabled in enforcement mode'
Check-GPSetting -policyPath $RegPath -valueName "ConfigureKernelShadowStacksLaunch" -expectedValue 1 -sectionNumber "18.9.5.7" -description "Turn On Virtualization Based Security: Kernel-mode Hardware-enforced Stack Protection" -recommendation "Enabled: Enabled in enforcement mode"
