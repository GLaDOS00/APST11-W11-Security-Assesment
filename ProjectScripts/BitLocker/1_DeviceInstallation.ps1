# Function to check the status of: BitLocker  - Device Installation
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Restrictions\DenyDeviceIDs"


# 18.9.7.1.1 (BL) Ensure 'Prevent installation of devices that match any of these device IDs' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "DenyDeviceIDs" -expectedValue 1 -sectionNumber "18.9.7.1.1" -level "(BL)" -description "Prevent installation of devices that match any of these device IDs" -recommendation "Enabled"

# 18.9.7.1.2 (BL) Ensure 'Prevent installation of devices that match any of these device IDs: Prevent installation of devices that match any of these device IDs' is set to 'PCI\CC_0C0A' 
Check-GPSetting -policyPath $RegPath2 -valueName "1" -expectedValue "PCI\CC_0C0A" -sectionNumber "18.9.7.1.2" -level "(BL)" -description "Prevent installation of devices that match any of these device IDs: Prevent installation of devices that match any of these device IDs" -recommendation "PCI\CC_0C0A"

# 18.9.7.1.3 (BL) Ensure 'Prevent installation of devices that match any of these device IDs: Also apply to matching devices that are already installed.' is set to 'True' (checked)
Check-GPSetting -policyPath $RegPath1 -valueName "DenyDeviceIDsRetroactive" -expectedValue 1 -sectionNumber "18.9.7.1.3" -level "(BL)" -description "Prevent installation of devices that match any of these device IDs: Also apply to matching devices that are already installed." -recommendation "True"

# 18.9.7.1.4 (BL) Ensure 'Prevent installation of devices using drivers that match these device setup classes' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "DenyDeviceClasses" -expectedValue 1 -sectionNumber "18.9.7.1.4" -level "(BL)" -description "Prevent installation of devices using drivers that match these device setup classes" -recommendation "Enabled"

# 18.9.7.1.6 (BL) Ensure 'Prevent installation of devices using drivers that match these device setup classes: Also apply to matching devices that are already installed.' is set to 'True'
Check-GPSetting -policyPath $RegPath1 -valueName "DenyDeviceClassesRetroactive" -expectedValue 1 -sectionNumber "18.9.7.1.6" -level "(BL)" -description "Prevent installation of devices using drivers that match these device setup classes: Also apply to matching devices that are already installed." -recommendation "True"

