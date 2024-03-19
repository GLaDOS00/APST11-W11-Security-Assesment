# Function to check the status of: Administrative Templates (Computer) - Windows Performance PerfTrack
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
		[string]$level,
        [string]$description,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber $level Ensure '$description' is set to '$recommendation': $status"
}


# Registry Values:
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}"


# 18.9.46.11.1 (L2) Ensure 'Enable/Disable PerfTrack' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "ScenarioExecutionEnabled" -expectedValue 0 -sectionNumber "18.9.46.11.1" -level "(L2)" -description "Enable/Disable PerfTrack" -recommendation "Disabled"