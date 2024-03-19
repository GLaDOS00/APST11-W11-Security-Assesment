# Function to check the status of: Administrative Templates (Computer) - App Runtime
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
$RegPath= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

# 18.10.5.1 (L1) Ensure 'Allow Microsoft accounts to be optional' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "MSAOptional" -expectedValue 1 -sectionNumber "18.10.5.1" -level "(L1)" -description "Allow Microsoft accounts to be optional" -recommendation "Enabled"

# 18.10.5.2 (L2) Ensure 'Block launching Universal Windows apps with Windows Runtime API access from hosted content' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "BlockHostedAppAccessWinRT" -expectedValue 1 -sectionNumber "18.10.5.2" -level "(L2)" -description "Block launching Universal Windows apps with Windows Runtime API access from hosted content" -recommendation "Enabled"