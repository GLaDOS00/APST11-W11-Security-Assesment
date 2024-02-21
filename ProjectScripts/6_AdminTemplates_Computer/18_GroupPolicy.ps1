# Function to check the status of Group Policy setting
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

# Define the registry path for settings
$GroupPolicyPath= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy"
	
# 18.9.19.2 Ensure 'Configure registry policy processing: Do not apply during periodic background processing' is set to 'Enabled: FALSE'
Check-GPSetting -policyPath $GroupPolicyPath -valueName "DisablePeriodicPolicy" -expectedValue 0 -sectionNumber "18.9.19.2" -description "Configure registry policy processing: Do not apply during periodic background processing" -recommendation "Enabled: FALSE"

# 18.9.19.3 Ensure 'Configure registry policy processing: Process even if the Group Policy objects have not changed' is set to 'Enabled: TRUE'
Check-GPSetting -policyPath $GroupPolicyPath -valueName "NoGPOListChanges" -expectedValue 1 -sectionNumber "18.9.19.3" -description "Configure registry policy processing: Process even if the Group Policy objects have not changed" -recommendation "Enabled: TRUE"

# 18.9.19.4 Ensure 'Continue experiences on this device' is set to 'Disabled'
Check-GPSetting -policyPath $GroupPolicyPath -valueName "NoConnectedUser" -expectedValue 1 -sectionNumber "18.9.19.4" -description "Continue experiences on this device" -recommendation "Disabled"

# 18.9.19.5 Ensure 'Turn off background refresh of Group Policy' is set to 'Disabled'
Check-GPSetting -policyPath $GroupPolicyPath -valueName "NoBackgroundPolicy" -expectedValue 0 -sectionNumber "18.9.19.5" -description "Turn off background refresh of Group Policy" -recommendation "Disabled"
