# Function to check the status of: Administrative Templates (Computer) - Messaging
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Messaging"


# 18.10.41.1 (L2) Ensure 'Allow Message Service Cloud Sync' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowMessageSync" -expectedValue 0 -sectionNumber "18.10.41.1" -level "(L2)" -description "Allow Message Service Cloud Sync" -recommendation "Disabled"