# Function to check the status of: Administrative Templates (Computer) - Microsoft Defender Antivirus
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR"
$RegPath3= "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules"
$RegPath4= "HKLM:\SOFTWARE\Policies\Microsoft\windows Defender\Windows Defender Exploit Guard\Network Protection"
$RegPath5= "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection"
$RegPath6= "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Scan"
$RegPath7= "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender"


# 18.10.43.5.1 (L1) Ensure 'Configure local setting override for reporting to Microsoft MAPS' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "LocalSettingOverrideSpynetReporting" -expectedValue 0 -sectionNumber "18.10.43.5.1" -description "Configure local setting override for reporting to Microsoft MAPS" -recommendation "Disabled"

# 18.10.43.6.1.1 (L1) Ensure 'Configure Attack Surface Reduction rules' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "ExploitGuard_ASR_Rules" -expectedValue 1 -sectionNumber "18.10.43.6.1.1" -description "Configure Attack Surface Reduction rules" -recommendation "Enabled"

# 18.10.43.6.1.2 (L1) Ensure 'Configure Attack Surface Reduction rules: Set the state for each ASR rule' is configured
Check-GPSetting -policyPath $RegPath3 -valueName "" -expectedValue 1 -sectionNumber "18.10.43.6.1.2" -description "Configure Attack Surface Reduction rules: Set the state for each ASR rule" -recommendation "Configure"

# 18.10.43.6.3.1 (L1) Ensure 'Prevent users and apps from accessing dangerous websites' is set to 'Enabled: Block'
Check-GPSetting -policyPath $RegPath4 -valueName "EnableNetworkProtection" -expectedValue 1 -sectionNumber "18.10.43.6.3.1" -description "Prevent users and apps from accessing dangerous websites" -recommendation "Enabled: Block"

# 18.10.43.10.1 (L1) Ensure 'Scan all downloaded files and attachments' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath5 -valueName "DisableIOAVProtection" -expectedValue 0 -sectionNumber "18.10.43.10.1" -description "Scan all downloaded files and attachments" -recommendation "Enabled"

# 18.10.43.10.2 (L1) Ensure 'Turn off real-time protection' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath5 -valueName "DisableRealtimeMonitoring" -expectedValue 0 -sectionNumber "18.10.43.10.2" -description "Turn off real-time protection" -recommendation "Disabled"

# 18.10.43.10.3 (L1) Ensure 'Turn on behavior monitoring' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath5 -valueName "DisableBehaviorMonitoring" -expectedValue 0 -sectionNumber "18.10.43.10.3" -description "Turn on behavior monitoring" -recommendation "Enabled"

# 18.10.43.10.4 (L1) Ensure 'Turn on script scanning' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath5 -valueName "DisableScriptScanning" -expectedValue 0 -sectionNumber "18.10.43.10.4" -description "Turn on script scanning" -recommendation "Enabled"

# 18.10.43.13.1 (L1) Ensure 'Scan removable drives' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath6 -valueName "DisableRemovableDriveScanning" -expectedValue 0 -sectionNumber "18.10.43.13.1" -description "Scan removable drives" -recommendation "Enabled"

# 18.10.43.13.2 (L1) Ensure 'Turn on e-mail scanning' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath6 -valueName "DisableEmailScanning" -expectedValue 0 -sectionNumber "18.10.43.13.2" -description "Turn on e-mail scanning" -recommendation "Enabled"

# 18.10.43.16 (L1) Ensure 'Configure detection for potentially unwanted applications' is set to 'Enabled: Block'
Check-GPSetting -policyPath $RegPath7 -valueName "PUAProtection" -expectedValue 1 -sectionNumber "18.10.43.16" -description "Configure detection for potentially unwanted applications" -recommendation "Enabled: Block"

# 18.10.43.17 (L1) Ensure 'Turn off Microsoft Defender AntiVirus' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath7 -valueName "DisableAntiSpyware" -expectedValue 0 -sectionNumber "18.10.43.17" -description "Turn off Microsoft Defender AntiVirus" -recommendation "Disabled"