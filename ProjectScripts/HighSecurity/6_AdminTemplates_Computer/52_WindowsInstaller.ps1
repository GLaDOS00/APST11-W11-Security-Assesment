# Function to check the status of: Administrative Templates (Computer) - Windows Installer 
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"


# 18.10.81.1 (L1) Ensure 'Allow user control over installs' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableUserControl" -expectedValue 0 -sectionNumber "18.10.81.1" -level "(L1)" -description "Allow user control over installs" -recommendation "Disabled"

# 18.10.81.2 (L1) Ensure 'Always install with elevated privileges' is set to 'Disabled’
Check-GPSetting -policyPath $RegPath -valueName "AlwaysInstallElevated" -expectedValue 0 -sectionNumber "18.10.81.1" -level "(L1)" -description "Allow user control over installs" -recommendation "Disabled"

# 18.10.81.3 (L2) Ensure 'Prevent Internet Explorer security prompt for Windows Installer scripts' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "SafeForScripting" -expectedValue 0 -sectionNumber "18.10.81.3" -level "(L2)" -description "Prevent Internet Explorer security prompt for Windows Installer scripts" -recommendation "Disabled"