# Function to check the status of: Administrative Templates (Computer) - Data Collection & Preview Builds
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
		[string]$level,
        [string]$description,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber $level Ensure '$description' is set to '$recommendation': $status"
}

# Registry Values:
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds"


# 18.10.15.1 (L1) Ensure 'Allow Diagnostic Data' is set to 'Enabled: Send required diagnostic data'
Check-GPSetting -policyPath $RegPath1 -valueName "AllowTelemetry" -expectedValue 1 -sectionNumber "18.10.15.1" -level "(L1)" -description "Allow Diagnostic Data" -recommendation "Enabled: Send required diagnostic data"

# 18.10.15.2 (L2) Ensure 'Configure Authenticated Proxy usage for the Connected User Experience and Telemetry service' is set to 'Enabled: Disable Authenticated Proxy usage'
Check-GPSetting -policyPath $RegPath1 -valueName "DisableEnterpriseAuthProxy" -expectedValue 1 -sectionNumber "18.10.15.2" -level "(L2)" -description "Configure Authenticated Proxy usage for the Connected User Experience and Telemetry service" -recommendation "Enabled: Disable Authenticated Proxy usage"

# 18.10.15.3 (L1) Ensure 'Disable OneSettings Downloads' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "DisableOneSettingsDownloads" -expectedValue 1 -sectionNumber "18.10.15.3" -level "(L1)" -description "Disable OneSettings Downloads" -recommendation "Enabled"

# 18.10.15.4 (L1) Ensure 'Do not show feedback notifications' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "DoNotShowFeedbackNotifications" -expectedValue 1 -sectionNumber "18.10.15.4" -level "(L1)" -description "Do not show feedback notifications" -recommendation "Enabled"

# 18.10.15.5 (L1) Ensure 'Enable OneSettings Auditing' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "EnableOneSettingsAuditing" -expectedValue 1 -sectionNumber "18.10.15.5" -level "(L1)" -description "Enable OneSettings Auditing" -recommendation "Enabled"

# 18.10.15.6 (L1) Ensure 'Limit Diagnostic Log Collection' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "LimitDiagnosticLogCollection" -expectedValue 1 -sectionNumber "18.10.15.6" -level "(L1)" -description "Limit Diagnostic Log Collection" -recommendation "Enabled"

# 18.10.15.7 (L1) Ensure 'Limit Dump Collection' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "LimitDumpCollection" -expectedValue 1 -sectionNumber "18.10.15.7" -level "(L1)" -description "Limit Dump Collection" -recommendation "Enabled"

# 18.10.15.8 (L1) Ensure 'Toggle user control over Insider builds' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "AllowBuildPreview" -expectedValue 0 -sectionNumber "18.10.15.8" -level "(L1)" -description "Toggle user control over Insider builds" -recommendation "Disabled"