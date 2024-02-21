# Define Group Policy path for regional and language options
$regionalLanguageOptionsPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\SpeechOne"

# Define Group Policy value
$onlineSpeechRecognitionValueName = "AllowOnlineSpeechRecognition"

# Function to check the status of Group Policy setting for regional and language options
function Check-GPSettingRegionalLanguageOptions {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber Ensure '$valueName' is set to 'Disabled' : $status"
}

$sectionNumber = "19.1.1 (L1)"

# Check the status of 'Allow users to enable online speech recognition services' policy
Check-GPSettingRegionalLanguageOptions -policyPath $regionalLanguageOptionsPolicyPath -valueName $onlineSpeechRecognitionValueName -expectedValue 0 -sectionNumber $sectionNumber
