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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription"

# 18.10.87.1 (L1) Ensure 'Turn on PowerShell Script Block Logging' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "EnableScriptBlockLogging" -expectedValue 1 -sectionNumber "18.10.87.1" -description "Turn on PowerShell Script Block Logging" -recommendation "Enabled"

# 18.10.87.2 (L1) Ensure 'Turn on PowerShell Transcription' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "EnableTranscripting" -expectedValue 1 -sectionNumber "18.10.87.2" -description "Turn on PowerShell Transcription" -recommendation "Enabled"