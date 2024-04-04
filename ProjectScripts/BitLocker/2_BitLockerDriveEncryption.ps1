# Function to check the status of: BitLocker - Drive Encryption
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\FVE"


# 18.10.9.1.1 (BL) Ensure 'Allow access to BitLocker-protected fixed data drives from earlier versions of Windows' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "FDVDiscoveryVolumeType" -expectedValue 0 -sectionNumber "18.10.9.1.1" -level "(BL)" -description "Allow access to BitLocker-protected fixed data drives from earlier versions of Windows" -recommendation "Disabled"

# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""

# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""


# 
Check-GPSetting -policyPath $RegPath -valueName "" -expectedValue  -sectionNumber "" -level "(BL)" -description "" -recommendation ""





