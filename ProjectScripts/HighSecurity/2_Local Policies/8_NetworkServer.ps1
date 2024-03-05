# Function to check the status of: Local Policy - Microsoft Network Server
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

# Registry Values
$RegPath= "HKLM:\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters"

# 2.3.9.1 (L1) Ensure 'Microsoft network server: Amount of idle time required before suspending session' is set to '15 or fewer minute(s)'
Check-GPSetting -policyPath $RegPath -valueName "AutoDisconnect" -expectedValue 15 -sectionNumber "2.3.9.1 " -description "Microsoft network server: Amount of idle time required before suspending session" -recommendation "15 or fewer minute(s)"

# 2.3.9.2 (L1) Ensure 'Microsoft network server: Digitally sign communications (always)' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "RequireSecuritySignature" -expectedValue 1 -sectionNumber "2.3.9.2" -description "Microsoft network server: Digitally sign communications (always)" -recommendation "Enabled"

# 2.3.9.3 (L1) Ensure 'Microsoft network server: Digitally sign communications (if client agrees)' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableSecuritySignature" -expectedValue 1 -sectionNumber "2.3.9.3" -description "Microsoft network server: Digitally sign communications (if client agrees)" -recommendation "Enabled"

# 2.3.9.4 (L1) Ensure 'Microsoft network server: Disconnect clients when logon hours expire' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "enableforcedlogoff" -expectedValue 1 -sectionNumber "2.3.9.4" -description "Microsoft network server: Disconnect clients when logon hours expire" -recommendation "Enabled"

# 2.3.9.5 (L1) Ensure 'Microsoft network server: Server SPN target name validation level' is set to 'Accept if provided by client' or higher
Check-GPSetting -policyPath $RegPath -valueName "SMBServerNameHardeningLevel" -expectedValue 1 -sectionNumber "2.3.9.5" -description "Microsoft network server: Server SPN target name validation level" -recommendation "Accept if provided by client"