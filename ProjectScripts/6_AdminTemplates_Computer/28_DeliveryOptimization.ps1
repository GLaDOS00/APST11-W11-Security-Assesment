# Function to check the status of: Administrative Templates (Computer) - Delivery Optimization
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [array]$expectedValue,
        [string]$sectionNumber,
        [string]$description,
        [string]$recommendation
    )

    # Attempt to retrieve the current policy setting value.
    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"

    # Check if the current value is in the list of expected values.
    if ($currentValue -ne $null -and $expectedValue -contains $currentValue.$valueName) {
        $status = "Compliant"
    }

    # Output the compliance status.
    Write-Host "$sectionNumber (L1) Ensure '$description' is NOT set to '$recommendation': $status"
}

$expectedValues = @(
    "0",
    "1",
    "2",
    "99",
    "100"
)

# Registry Values:
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization"


# 18.10.16.1 (L1) Ensure 'Download Mode' is NOT set to 'Enabled: Internet'
Check-GPSetting -policyPath $RegPath -valueName "DODownloadMode" -expectedValue $expectedValues -sectionNumber "18.10.16.1" -description "Download Mode" -recommendation "Enabled: Internet"
