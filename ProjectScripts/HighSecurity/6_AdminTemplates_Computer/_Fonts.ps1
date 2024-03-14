# Function to check the status of: Administrative Templates (Computer) - Fonts
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"


# 18.6.5.1 (L2) Ensure 'Enable Font Providers' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath -valueName "EnableFontProviders" -expectedValue 0 -sectionNumber "18.6.5.1" -level "(L2)" -description "Enable Font Providers" -recommendation "Disabled"