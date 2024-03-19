# Function to check the status of: Administrative Templates (Computer) - Kerberos
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
$RegPath= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\kerberos\parameters"


# 18.9.23.1 (L2) Ensure 'Support device authentication using certificate' is set to 'Enabled: Automatic'
Check-GPSetting -policyPath $RegPath -valueName "DevicePKInitBehavior" -expectedValue 0 -sectionNumber "18.9.23.1" -level "(L2)" -description "Support device authentication using certificate" -recommendation "Enabled: Automatic"