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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Connect"


# 18.10.13.1 (L1) Ensure 'Require pin for pairing' is set to 'Enabled: First Time'
Check-GPSetting -policyPath $RegPath -valueName "RequirePinForPairing" -expectedValue 1 -sectionNumber "18.10.13.1" -description "Require pin for pairing" -recommendation "Enabled: First Time"
