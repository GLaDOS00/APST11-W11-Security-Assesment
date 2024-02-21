# Define Group Policy paths
$lockScreenCameraPolicyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$lockScreenSlideShowPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"

# Define Group Policy values
$lockScreenCameraValueName = "NoLockScreenCamera"
$lockScreenSlideShowValueName = "NoLockScreenSlideshow"

# Function to check the status of Group Policy settings
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber Ensure '$valueName' is set to 'Enabled' : $status"
}

# Check the status of Prevent enabling lock screen camera policy
Check-GPSetting -policyPath $lockScreenCameraPolicyPath -valueName $lockScreenCameraValueName -expectedValue 1 -sectionNumber "18.1.1.1 (L1)"

# Check the status of Prevent enabling lock screen slide show policy
Check-GPSetting -policyPath $lockScreenSlideShowPolicyPath -valueName $lockScreenSlideShowValueName -expectedValue 1 -sectionNumber "18.1.1.2 (L1)"
