# Function to check the status of: Administrative Templates (Computer) - Audio Process Creation
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

# Registry path for the 'Audit Process Creation' settings
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit"

# 18.9.3.1 (L1) Ensure 'Include command line in process creation events' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "ProcessCreationIncludeCmdLine_Enabled" -expectedValue 1 -sectionNumber "18.9.3.1" -description "Include command line in process creation events" -recommendation "Enabled"
