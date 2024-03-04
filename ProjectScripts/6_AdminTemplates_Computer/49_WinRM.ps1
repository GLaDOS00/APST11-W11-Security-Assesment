# Function to check the status of: Administrative Templates (Computer) - WinRM
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service"


# 18.10.89.1.1 (L1) Ensure 'Allow Basic authentication' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "AllowBasic" -expectedValue 0 -sectionNumber "18.10.89.1.1" -description "Allow Basic authentication" -recommendation "Disabled"

# 18.10.89.1.2 (L1) Ensure 'Allow unencrypted traffic' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "AllowUnencryptedTraffic" -expectedValue 0 -sectionNumber "18.10.89.1.2" -description "Allow unencrypted traffic" -recommendation "Disabled"

# 18.10.89.1.3 (L1) Ensure 'Disallow Digest authentication' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "AllowDigest" -expectedValue 0 -sectionNumber "18.10.89.1.3" -description "Disallow Digest authentication" -recommendation "Enabled"

# 18.10.89.2.1 (L1) Ensure 'Allow Basic authentication' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "AllowBasic" -expectedValue 0 -sectionNumber "18.10.89.2.1" -description "Allow Basic authentication" -recommendation "Disabled"

# 18.10.89.2.3 (L1) Ensure 'Allow unencrypted traffic' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "AllowUnencryptedTraffic" -expectedValue 0 -sectionNumber "18.10.89.2.3" -description "Allow unencrypted traffic" -recommendation "Disabled"

# 18.10.89.2.4 (L1) Ensure 'Disallow WinRM from storing RunAs credentials' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "DisableRunAs" -expectedValue 1 -sectionNumber "18.10.89.2.4" -description "Disallow WinRM from storing RunAs credentials" -recommendation "Enabled"
