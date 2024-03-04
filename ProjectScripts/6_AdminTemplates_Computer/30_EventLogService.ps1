# Function to check the status of: Administrative Templates (Computer) - Event Log Service
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [int]$expectedValue,
        [string]$sectionNumber,
        [string]$description,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -ge $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to '$recommendation': $status"
}

# Registry Values:
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security"
$RegPath3= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Setup"
$RegPath4= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System"


# 18.10.26.1.1 (L1) Ensure 'Application: Control Event Log behavior when the log file reaches its maximum size' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "Retention" -expectedValue 0 -sectionNumber "18.10.26.1.1" -description "Application: Control Event Log behavior when the log file reaches its maximum size" -recommendation "Disabled"

# 18.10.26.1.2 (L1) Ensure 'Application: Specify the maximum log file size (KB)' is set to 'Enabled: 32,768 or greater'
Check-GPSetting -policyPath $RegPath1 -valueName "MaxSize" -expectedValue 32768 -sectionNumber "18.10.26.1.2" -description "Application: Specify the maximum log file size (KB)" -recommendation "Enabled: 32,768 or greater"

# 18.10.26.2.1 (L1) Ensure 'Security: Control Event Log behavior when the log file reaches its maximum size' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "Retention" -expectedValue 0 -sectionNumber "18.10.26.2.1" -description "Security: Control Event Log behavior when the log file reaches its maximum size" -recommendation "Disabled"

# 18.10.26.2.2 (L1) Ensure 'Security: Specify the maximum log file size (KB)' is set to 'Enabled: 196,608 or greater'
Check-GPSetting -policyPath $RegPath2 -valueName "Maxsize" -expectedValue 196608 -sectionNumber "18.10.26.2.2" -description "Security: Specify the maximum log file size (KB)" -recommendation "Enabled: 196,608 or greater"

# 18.10.26.3.1 (L1) Ensure 'Setup: Control Event Log behavior when the log file reaches its maximum size' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath3 -valueName "Retention" -expectedValue 0 -sectionNumber "18.10.26.3.1" -description "Setup: Control Event Log behavior when the log file reaches its maximum size" -recommendation "Disabled"

# 18.10.26.3.2 (L1) Ensure 'Setup: Specify the maximum log file size (KB)' is set to 'Enabled: 32,768 or greater'
Check-GPSetting -policyPath $RegPath3 -valueName "MazSize" -expectedValue 32768 -sectionNumber "18.10.26.3.2" -description "Setup: Specify the maximum log file size (KB)" -recommendation "Enabled: 32,768 or greater"

# 18.10.26.4.1 (L1) Ensure 'System: Control Event Log behavior when the log file reaches its maximum size' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath4 -valueName "Retention" -expectedValue 0 -sectionNumber "18.10.26.4.1" -description "System: Control Event Log behavior when the log file reaches its maximum size" -recommendation "Disabled"

# 18.10.26.4.2 (L1) Ensure 'System: Specify the maximum log file size (KB)' is set to 'Enabled: 32,768 or greater'
Check-GPSetting -policyPath $RegPath4 -valueName "Maxsize" -expectedValue 32768 -sectionNumber "18.10.26.4.2" -description "System: Specify the maximum log file size (KB)" -recommendation "Enabled: 32,768 or greater"