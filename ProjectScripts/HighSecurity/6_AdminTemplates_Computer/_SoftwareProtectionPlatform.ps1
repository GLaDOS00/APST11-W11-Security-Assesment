# Function to check the status of: Administrative Templates (Computer) - Software Protection Platform
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform"


# 18.10.63.1 (L2) Ensure 'Turn off KMS Client Online AVS Validation' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "NoGenTicket" -expectedValue 1 -sectionNumber "18.10.63.1" -level "(L2)" -description "Turn off KMS Client Online AVS Validation" -recommendation "Enabled"