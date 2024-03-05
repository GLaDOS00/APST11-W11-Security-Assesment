# Function to check the status of: Administrative Templates (Computer) - Remote Assistance
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"


# 18.9.34.1 (L1) Ensure 'Configure Offer Remote Assistance' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "fAllowUnsolicited" -expectedValue 0 -sectionNumber "18.9.34.1" -description "Configure Offer Remote Assistance" -recommendation "Disabled"

# 18.9.34.2 (L1) Ensure 'Configure Solicited Remote Assistance' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "fAllowToGetHelp" -expectedValue 0 -sectionNumber "18.9.34.2" -description "Configure Solicited Remote Assistance" -recommendation "Disabled" 
