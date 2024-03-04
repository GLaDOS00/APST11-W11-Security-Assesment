# Function to check the status of:  - 
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppInstaller"


# 18.10.17.1 (L1) Ensure 'Enable App Installer' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableAppInstaller" -expectedValue 0 -sectionNumber "18.10.17.1" -description "Enable App Installer" -recommendation "Disabled"

# 18.10.17.2 (L1) Ensure 'Enable App Installer Experimental Features' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableExperimentalFeatures" -expectedValue 0 -sectionNumber "18.10.17.2" -description "Enable App Installer Experimental Features" -recommendation "Disabled"

# 18.10.17.3 (L1) Ensure 'Enable App Installer Hash Override' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableHashOverride" -expectedValue 0 -sectionNumber "18.10.17.3" -description "Enable App Installer Hash Override" -recommendation "Disabled"

# 18.10.17.4 (L1) Ensure 'Enable App Installer ms-appinstaller protocol' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableMSAppInstallerProtocol" -expectedValue 0 -sectionNumber "18.10.17.4" -description "Enable App Installer ms-appinstaller protocol" -recommendation "Disabled"
