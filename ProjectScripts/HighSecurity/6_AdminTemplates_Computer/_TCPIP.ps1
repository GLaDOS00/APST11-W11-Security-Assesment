# Function to check the status of: Administrative Templates (Computer) - TCPIP Settings
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
$RegPath= "HKLM:\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters"


# 18.6.19.2.1 (L2) Ensure 'TCPIP6 Parameter 'DisabledComponents' is set to '0xff (255)'
Check-GPSetting -policyPath $RegPath -valueName "DisabledComponents" -expectedValue "0xff (255)" -sectionNumber "18.6.19.2.1" -level "(L2)" -description "TCPIP6 Parameter 'DisabledComponents" -recommendation "0xff (255)"