# Function to check the status of Group Policy setting
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
$deviceMetadataPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata"

# Check 'Prevent device metadata retrieval from the Internet'
Check-GPSetting -policyPath $deviceMetadataPath -valueName "PreventDeviceMetadataFromInternet" -expectedValue 1 -sectionNumber "18.9.7.2" -description "Prevent device metadata retrieval from the Internet" -recommendation "Enabled"
