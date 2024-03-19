# Function to check the status of: Administrative Templates (Computer) - Remote Desktop Services
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"

# 18.10.57.2.2 (L2) Ensure 'Disable Cloud Clipboard integration for server-to-client data transfer' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "DisableCloudClipboardIntegration" -expectedValue 1 -sectionNumber "18.10.57.2.2" -level "(L2)" -description "'Disable Cloud Clipboard integration for server-to-client data transfer" -recommendation "Enabled"

# 18.10.57.2.3 (L1) Ensure 'Do not allow passwords to be saved' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "DisablePasswordSaving" -expectedValue 1 -sectionNumber "18.10.57.2.3" -level "(L1)" -description "Do not allow passwords to be saved" -recommendation "Enabled"

# 18.10.57.3.2.1 (L2) Ensure 'Allow users to connect remotely by using Remote Desktop Services' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "fDenyTSConnections" -expectedValue 1 -sectionNumber "18.10.57.3.2.1" -level "(L2)" -description "Allow users to connect remotely by using Remote Desktop Services" -recommendation "Disabled"

# 18.10.57.3.3.1 (L2) Ensure 'Allow UI Automation redirection' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "EnableUiaRedirection" -expectedValue 0 -sectionNumber "18.10.57.3.3.1" -level "(L2)" -description "Allow UI Automation redirection" -recommendation "Disabled"

# 18.10.57.3.3.2 (L2) Ensure 'Do not allow COM port redirection' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "fDisableCcm" -expectedValue 1 -sectionNumber "18.10.57.3.3.2" -level "(L2)" -description "Do not allow COM port redirection" -recommendation "Enabled"

# 18.10.57.3.3.3 (L1) Ensure 'Do not allow drive redirection' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "fDisableCdm" -expectedValue 1 -sectionNumber "18.10.57.3.3.3" -level "(L1)" -description "Do not allow drive redirection" -recommendation "Enabled"

# 18.10.57.3.3.4 (L2) Ensure 'Do not allow location redirection' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "fDisableLocationRedir" -expectedValue 1 -sectionNumber "18.10.57.3.3.4 " -level "(L2)" -description "Do not allow location redirection" -recommendation "Enabled"

# 18.10.57.3.3.5 (L2) Ensure 'Do not allow LPT port redirection' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "fDisableLPT" -expectedValue 1 -sectionNumber "18.10.57.3.3.5" -level "(L2)" -description "Do not allow LPT port redirection" -recommendation "Enabled"

# 18.10.57.3.3.6 (L2) Ensure 'Do not allow supported Plug and Play device redirection' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "fDisablePNPRedir" -expectedValue 1 -sectionNumber "18.10.57.3.3.6" -level "(L2)" -description "Do not allow supported Plug and Play device redirection" -recommendation "Enabled"

# 18.10.57.3.3.7 (L2) Ensure 'Do not allow WebAuthn redirection' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "fDisableWebAuthn" -expectedValue 1 -sectionNumber "18.10.57.3.3.7" -level "(L2)" -description "Do not allow WebAuthn redirection" -recommendation "Enabled"

# 18.10.57.3.9.1 (L1) Ensure 'Always prompt for password upon connection' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "fPromptForPassword" -expectedValue 1 -sectionNumber "18.10.57.3.9.1" -level "(L1)" -description "Always prompt for password upon connection" -recommendation "Enabled"

# 18.10.57.3.9.2 (L1) Ensure 'Require secure RPC communication' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "fEncryptRPCTraffic" -expectedValue 1 -sectionNumber "18.10.57.3.9.2" -level "(L1)" -description "Require secure RPC communication" -recommendation "Enabled"

# 18.10.57.3.9.3 (L1) Ensure 'Require use of specific security layer for remote (RDP) connections' is set to 'Enabled: SSL'
Check-GPSetting -policyPath $RegPath2 -valueName "SecurityLayer" -expectedValue 2 -sectionNumber "18.10.57.3.9.3" -level "(L1)" -description "Require use of specific security layer for remote (RDP) connections" -recommendation "Enabled: SSL"

# 18.10.57.3.9.4 (L1) Ensure 'Require user authentication for remote connections by using Network Level Authentication' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "UserAuthentication" -expectedValue 1 -sectionNumber "18.10.57.3.9.4" -level "(L1)" -description "Require user authentication for remote connections by using Network Level Authentication" -recommendation "Enabled"

# 18.10.57.3.9.5 (L1) Ensure 'Set client connection encryption level' is set to 'Enabled: High Level'
Check-GPSetting -policyPath $RegPath2 -valueName "MinEncryptionLevel" -expectedValue 3 -sectionNumber "18.10.57.3.9.5" -level "(L1)" -description "Set client connection encryption level" -recommendation "Enabled: High Level"

# 18.10.57.3.10.1 (L2) Ensure 'Set time limit for active but idle Remote Desktop Services sessions' is set to 'Enabled: 15 minutes or less, but not Never (0)'
Check-GPSetting -policyPath $RegPath2 -valueName "MaxIdleTime" -expectedValue 4 -sectionNumber "18.10.57.3.10.1" -level "(L2)" -description "Set time limit for active but idle Remote Desktop Services sessions" -recommendation "Enabled: 15 minutes or less, but not Never (0)"

# 18.10.57.3.10.2 (L2) Ensure 'Set time limit for disconnected sessions' is set to 'Enabled: 1 minute'
Check-GPSetting -policyPath $RegPath2 -valueName "MaxDisconnectionTime" -expectedValue 1 -sectionNumber "18.10.57.3.10.2" -level "(L2)" -description "Set time limit for disconnected sessions" -recommendation "Enabled: 1 minute"

# 18.10.57.3.11.1 (L1) Ensure 'Do not delete temp folders upon exit' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "DeleteTempDirsOnExit" -expectedValue 1 -sectionNumber "18.10.57.3.11.1" -level "(L1)" -description "Do not delete temp folders upon exit" -recommendation "Disable"
