# Function to check the status of: Administrative Templates (Computer) - App Runtime
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\RuntimeBroker"

# 18.10.5.1 (L1) Ensure 'Allow Microsoft accounts to be optional' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowMicrosoftAccountsToBeOptional" -expectedValue 1 -sectionNumber "18.10.5.1" -description "Allow Microsoft accounts to be optional" -recommendation "Enabled"