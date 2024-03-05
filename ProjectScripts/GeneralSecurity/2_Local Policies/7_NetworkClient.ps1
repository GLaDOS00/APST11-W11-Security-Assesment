# Function to check the status of: Local Policy - Microsoft Network Client
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
$RegPath= "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"


# 2.3.8.1 (L1) Ensure 'Microsoft network client: Digitally sign communications (always)' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "RequireSecuritySignature" -expectedValue 1 -sectionNumber "2.3.8.1" -description "Microsoft network client: Digitally sign communications (always)" -recommendation "Enabled"

# 2.3.8.2 (L1) Ensure 'Microsoft network client: Digitally sign communications (if server agrees)' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableSecuritySignature" -expectedValue 1 -sectionNumber "2.3.8.2" -description "Microsoft network client: Digitally sign communications (if server agrees)" -recommendation "Enabled"

# 2.3.8.3 (L1) Ensure 'Microsoft network client: Send unencrypted password to third-party SMB servers' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "EnablePlainTextPassword" -expectedValue 0 -sectionNumber "2.3.8.3" -description "Microsoft network client: Send unencrypted password to third-party SMB servers" -recommendation "Disabled"