# Function to check the status of: Administrative Templates (Computer) - Windows Defender SmartScreen
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
$RegPath3= "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter"


# 18.10.76.1.1 (L1) Ensure 'Notify Malicious' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "NotifyMalicious" -expectedValue 1 -sectionNumber "18.10.76.1.1" -description "Notify Malicious" -recommendation "Enabled"

# 18.10.76.1.2 (L1) Ensure 'Notify Password Reuse' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "NotifyPasswordReuse" -expectedValue 1 -sectionNumber "18.10.76.1.2" -description "Notify Password Reuse" -recommendation "Enabled"

# 18.10.76.1.3 (L1) Ensure 'Notify Unsafe App' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "NotifyUnsafeApp" -expectedValue 1 -sectionNumber "18.10.76.1.3" -description "Notify Unsafe App" -recommendation "Enabled"

# 18.10.76.1.4 (L1) Ensure 'Service Enabled' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "ServiceEnabled" -expectedValue 1 -sectionNumber "18.10.76.1.4" -description "Service Enabled" -recommendation "Enabled"

# 18.10.76.2.1 (L1) Ensure 'Configure Windows Defender SmartScreen' is set to 'Enabled: Warn and prevent bypass’
Check-GPSetting -policyPath $RegPath2 -valueName "ShellSmartScreenLevel" -expectedValue "Block" -sectionNumber "18.10.76.2.1" -description "Configure Windows Defender SmartScreen" -recommendation "Enabled: Warn and prevent bypass"

# 18.10.76.2.1.1 (L1) Ensure 'Configure Windows Defender SmartScreen' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "EnableSmartScreen" -expectedValue 1 -sectionNumber "18.10.76.2.1.1" -description "Configure Windows Defender SmartScreen" -recommendation "Enabled"

# 18.10.76.3.1 (L1) Ensure 'Configure Windows Defender SmartScreen' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath3 -valueName "EnabledV9" -expectedValue 1 -sectionNumber "18.10.76.3.1" -description "Configure Windows Defender SmartScreen" -recommendation "Enabled"

# 18.10.76.3.2 (L1) Ensure 'Prevent bypassing Windows Defender SmartScreen prompts for sites' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath3 -valueName "PreventOverride" -expectedValue 1 -sectionNumber "18.10.76.3.2" -description "Prevent bypassing Windows Defender SmartScreen prompts for sites" -recommendation "Enabled"

