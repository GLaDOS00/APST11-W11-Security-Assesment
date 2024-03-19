# Function to check the status of: Administrative Templates (Computer) - Windows Connect Now
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WCN\UI"


# 18.6.20.1 (L2) Ensure 'Configuration of wireless settings using Windows Connect Now' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "EnableRegistrars" -expectedValue 0 -sectionNumber "18.6.20.1" -level "(L2)" -description "Configuration of wireless settings using Windows Connect Now" -recommendation "Disabled"

# 18.6.20.2 (L2) Ensure 'Prohibit access of the Windows Connect Now wizards' is set to 'Enabled' 
Check-GPSetting -policyPath $RegPath2 -valueName "DisableWcnUi" -expectedValue 1 -sectionNumber "18.6.20.2" -level "(L2)" -description "Prohibit access of the Windows Connect Now wizards" -recommendation "Enabled"