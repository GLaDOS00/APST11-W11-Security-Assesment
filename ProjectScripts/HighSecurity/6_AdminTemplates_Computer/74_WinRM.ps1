# Function to check the status of: Administrative Templates (Computer) - WinRM
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service"


# 18.10.89.1.1 (L1) Ensure 'Allow Basic authentication' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "AllowBasic" -expectedValue 0 -sectionNumber "18.10.89.1.1" -level "(L1)" -description "Allow Basic authentication" -recommendation "Disabled"

# 18.10.89.1.2 (L1) Ensure 'Allow unencrypted traffic' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "AllowUnencryptedTraffic" -expectedValue 0 -sectionNumber "18.10.89.1.2" -level "(L1)" -description "Allow unencrypted traffic" -recommendation "Disabled"

# 18.10.89.1.3 (L1) Ensure 'Disallow Digest authentication' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "AllowDigest" -expectedValue 0 -sectionNumber "18.10.89.1.3" -level "(L1)" -description "Disallow Digest authentication" -recommendation "Enabled"

# 18.10.89.2.1 (L1) Ensure 'Allow Basic authentication' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "AllowBasic" -expectedValue 0 -sectionNumber "18.10.89.2.1" -level "(L1)" -description "Allow Basic authentication" -recommendation "Disabled"

# 18.10.89.2.2 (L2) Ensure 'Allow remote server management through WinRM' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "AllowAutoConfig" -expectedValue 0 -sectionNumber "18.10.89.2.2" -level "(L2)" -description "Allow remote server management through WinRM" -recommendation "Disabled"

# 18.10.89.2.3 (L1) Ensure 'Allow unencrypted traffic' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "AllowUnencryptedTraffic" -expectedValue 0 -sectionNumber "18.10.89.2.3" -level "(L1)" -description "Allow unencrypted traffic" -recommendation "Disabled"

# 18.10.89.2.4 (L1) Ensure 'Disallow WinRM from storing RunAs credentials' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "DisableRunAs" -expectedValue 1 -sectionNumber "18.10.89.2.4" -level "(L1)" -description "Disallow WinRM from storing RunAs credentials" -recommendation "Enabled"
