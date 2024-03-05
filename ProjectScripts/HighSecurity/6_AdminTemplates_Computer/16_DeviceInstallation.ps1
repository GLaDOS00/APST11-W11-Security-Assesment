# Function to check the status of: Administrative Templates (Computer) - Device Installation
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

# Define the registry path for Device Installation settings
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata"

# 18.9.7.2 (L1) Ensure 'Prevent device metadata retrieval from the Internet' is set to 'Enabled’
Check-GPSetting -policyPath $RegPath -valueName "PreventDeviceMetadataFromInternet" -expectedValue 1 -sectionNumber "18.9.7.2" -description "Prevent device metadata retrieval from the Internet" -recommendation "Enabled"
