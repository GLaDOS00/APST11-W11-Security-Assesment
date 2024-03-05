# Function to check the status of: Administrative Templates (Computer) - Windows Security
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\App and Browser protection"


# 18.10.92.2.1 (L1) Ensure 'Prevent users from modifying settings' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DisallowExploitProtectionOverride" -expectedValue 1 -sectionNumber "18.10.92.2.1" -description "Prevent users from modifying settings" -recommendation "Enabled"