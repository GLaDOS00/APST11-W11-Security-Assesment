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
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue

    if ($currentValue -eq $null) {
        Write-Host "$valueName is not configured. Recommendation: $recommendation"
    } elseif ($currentValue.$valueName -eq $expectedValue) {
        Write-Host "$valueName is set to $expectedValue (Meets the recommendation)"
    } else {
        Write-Host "$valueName is set to $($currentValue.$valueName) (Does not meet the recommendation. Recommendation: $recommendation)"
    }
}

# Check the status of Prevent enabling lock screen camera policy
Check-GPSetting -policyPath $lockScreenCameraPolicyPath -valueName $lockScreenCameraValueName -expectedValue 1 -recommendation "Enable"

# Check the status of Prevent enabling lock screen slide show policy
Check-GPSetting -policyPath $lockScreenSlideShowPolicyPath -valueName $lockScreenSlideShowValueName -expectedValue 1 -recommendation "Enable"

