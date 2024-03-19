# Function to check the status of: Administrative Templates (Computer) - Windows Time Service
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpClient"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpServer"


# 18.9.50.1.1 (L2) Ensure 'Enable Windows NTP Client' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "Enabled" -expectedValue 1 -sectionNumber "18.9.50.1.1" -level "(L2)" -description "Enable Windows NTP Client" -recommendation "Enabled"

# 18.9.50.1.2 (L2) Ensure 'Enable Windows NTP Server' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "Enabled" -expectedValue 0 -sectionNumber "18.9.50.1.2" -level "(L2)" -description "Enable Windows NTP Server" -recommendation "Disabled"