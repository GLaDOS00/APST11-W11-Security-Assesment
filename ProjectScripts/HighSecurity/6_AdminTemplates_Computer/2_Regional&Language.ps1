# Function to check the status of: Administrative Templates (Computer) - Regional & Language Options
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
$RegPath1= "HKLM:\\SOFTWARE\Policies\Microsoft\Windows\SpeechOne"
$RegPath2= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"


# 18.1.2.2 (L1) Ensure 'Allow users to enable online speech recognition services' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "AllowOnlineSpeechRecognition" -expectedValue 0 -sectionNumber "18.1.2.2" -level "(L1)" -description "Allow users to enable online speech recognition services" -recommendation "Disabled"

# 18.1.3 (L2) Ensure 'Allow Online Tips' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath2 -valueName "AllowOnlineTips" -expectedValue 0 -sectionNumber "18.1.3" -level "(L2)" -description "Allow Online Tips" -recommendation "Disabled"