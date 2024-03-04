# Function to check the status of: Administrative Templates (Computer) - Windows Update
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
$RegPath2= "HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"


# 18.10.93.1.1 (L1) Ensure 'No auto-restart with logged on users for scheduled automatic updates installations' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "NoAutoRebootWithLoggedOnUsers" -expectedValue 0 -sectionNumber "18.10.93.1.1" -description "No auto-restart with logged on users for scheduled automatic updates installations" -recommendation "Disabled"

# 18.10.93.2.1 (L1) Ensure 'Configure Automatic Updates' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "NoAutoUpdate" -expectedValue 0 -sectionNumber "18.10.93.1.2" -description "Configure Automatic Updates" -recommendation "Enabled"

# 18.10.93.2.2 (L1) Ensure 'Configure Automatic Updates: Scheduled install day' is set to '0 - Every day'
Check-GPSetting -policyPath $RegPath1 -valueName "ScheduledInstallDay" -expectedValue 0 -sectionNumber "18.10.93.2.2" -description "Configure Automatic Updates: Scheduled install day" -recommendation "0 - Every day"

# 18.10.93.2.3 (L1) Ensure 'Remove access to “Pause updates” feature' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "SetDisablePauseUXAccess" -expectedValue 1 -sectionNumber "18.10.93.2.3" -description "Remove access to “Pause updates” feature" -recommendation "Enabled"

# 18.10.93.4.1 (L1) Ensure 'Manage preview builds' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "ManagePreviewBuildsPolicyValue" -expectedValue 1 -sectionNumber "18.10.93.4.1" -description "Manage preview builds" -recommendation "Disabled"

# 18.10.93.4.2 (L1) Ensure 'Select when Preview Builds and Feature Updates are received' is set to 'Enabled: 180 or more days'
Check-GPSetting -policyPath $RegPath2 -valueName "DeferFeatureUpdates" -expectedValue 1 -sectionNumber "18.10.93.4.2" -description "Select when Preview Builds and Feature Updates are received" -recommendation "Enabled: 180 or more days"

# 18.10.93.4.2.1 (L1) Ensure 'Select when Preview Builds and Feature Updates are received' is set to 'Enabled: 180 or more days'
Check-GPSetting -policyPath $RegPath2 -valueName "DeferFeatureUpdatesPeriodInDays" -expectedValue 180 -sectionNumber "18.10.93.4.2" -description "Select when Preview Builds and Feature Updates are received" -recommendation "Enabled: 180 or more days"

# 18.10.93.4.3 (L1) Ensure 'Select when Quality Updates are received' is set to 'Enabled: 0 days'
Check-GPSetting -policyPath $RegPath2 -valueName "DeferQualityUpdates" -expectedValue 1 -sectionNumber "18.10.93.4.3" -description "Select when Quality Updates are received" -recommendation "Enabled: 0 days"

# 18.10.93.4.3.1 (L1) Ensure 'Select when Quality Updates are received' is set to 'Enabled: 0 days'
Check-GPSetting -policyPath $RegPath2 -valueName "DeferQualityUpdatesPeriodInDays" -expectedValue 0 -sectionNumber "18.10.93.4.3" -description "Select when Quality Updates are received" -recommendation "Enabled: 0 days"