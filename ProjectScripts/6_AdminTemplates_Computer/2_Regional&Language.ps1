# Function to check the status of: Administrative Templates (Computer) - Regional & Language Options
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
$RegPath= "HKLM:\\SOFTWARE\Policies\Microsoft\Windows\SpeechOne"


# 18.1.2.2 (L1) Ensure 'Allow users to enable online speech recognition services' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowOnlineSpeechRecognition" -expectedValue 0 -sectionNumber "18.1.2.2" -description "Allow users to enable online speech recognition services" -recommendation "Disabled"