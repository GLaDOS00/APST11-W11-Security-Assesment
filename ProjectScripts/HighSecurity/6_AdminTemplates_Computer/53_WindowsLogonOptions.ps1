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
$RegPath= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"


# 18.10.82.1 (L1) Ensure 'Enable MPR notifications for the system' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableMPR" -expectedValue 0 -sectionNumber "18.10.82.1" -description "Enable MPR notifications for the system" -recommendation "Disabled"

# 18.10.82.2 (L1) Ensure 'Sign-in and lock last interactive user automatically after a restart' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "DisableAutomaticRestartSignOn" -expectedValue 1 -sectionNumber "18.10.82.1" -description "Sign-in and lock last interactive user automatically after a restart" -recommendation "Disabled"
