# Function to check the status of: Local Policy - System Objects
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
        [string]$description,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to '$recommendation': $status"
}

# Registry Values:
$RegPath1= "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel"
$RegPath2= "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager"


# 2.3.15.1 (L1) Ensure 'System objects: Require case insensitivity for non-Windows subsystems' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "ObCaseInsensitive" -expectedValue 1 -sectionNumber "2.3.15.1" -description "System objects: Require case insensitivity for non-Windows subsystems" -recommendation "Enabled"

# 2.3.15.2 (L1) Ensure 'System objects: Strengthen default permissions of internal system objects (e.g. Symbolic Links)' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "ProtectionMode" -expectedValue 1 -sectionNumber "2.3.15.2" -description "System objects: Strengthen default permissions of internal system objects (e.g. Symbolic Links)" -recommendation "Enabled"