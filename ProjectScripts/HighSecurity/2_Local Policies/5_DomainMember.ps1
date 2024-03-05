# Function to check the status of Local Policy - Domain Member
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

# Registry Value:
$RegPath= "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters"


# 2.3.6.1 (L1) Ensure 'Domain member: Digitally encrypt or sign secure channel data (always)'is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "RequireSignOrSeal" -expectedValue 1 -sectionNumber "2.3.6.1" -description "Domain member: Digitally encrypt or sign secure channel data (always)" -recommendation "Enabled"

# 2.3.6.2 (L1) Ensure 'Domain member: Digitally encrypt secure channel data (when possible)'is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "SealSecureChannel" -expectedValue 1 -sectionNumber "2.3.6.2" -description "Domain member: Digitally encrypt secure channel data (when possible)" -recommendation "Enabled"

# 2.3.6.3 (L1) Ensure 'Domain member: Digitally sign secure channel data (when possible)'is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "SignSecureChannel" -expectedValue 1 -sectionNumber "2.3.6.3" -description "Domain member: Digitally sign secure channel data (when possible)" -recommendation "Enabled"

# 2.3.6.4 (L1) Ensure 'Domain member: Disable machine account password changes' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "DisablePasswordChange" -expectedValue 0 -sectionNumber "2.3.6.4" -description "Domain member: Disable machine account password changes" -recommendation "Disabled"

# 2.3.6.5 (L1) Ensure 'Domain member: Maximum machine account password age' is set to '30 or fewer days, but not 0'
Check-GPSetting -policyPath $RegPath -valueName "MaximumPasswordAge" -expectedValue 30 -sectionNumber "2.3.6.5" -description "Domain member: Maximum machine account password age" -recommendation "30 or fewer days, but not 0"

# 2.3.6.6 (L1) Ensure 'Domain member: Require strong (Windows 2000 or later) session key' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "RequireStrongKey" -expectedValue 1 -sectionNumber "2.3.6.6" -description "Domain member: Require strong (Windows 2000 or later) session key" -recommendation "Enabled"