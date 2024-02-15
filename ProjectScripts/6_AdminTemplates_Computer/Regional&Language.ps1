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
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue

    if ($currentValue -eq $null) {
        Write-Host "$valueName is not configured. Recommendation: $recommendation"
    } elseif ($currentValue.$valueName -eq $expectedValue) {
        Write-Host "$valueName is set to $expectedValue (Meets the recommendation)"
    } else {
        Write-Host "$valueName is set to $($currentValue.$valueName) (Does not meet the recommendation. Recommendation: $recommendation)"
    }
}

# Check the status of 'Allow users to enable online speech recognition services' policy
Check-GPSettingRegionalLanguageOptions -policyPath $regionalLanguageOptionsPolicyPath -valueName $onlineSpeechRecognitionValueName -expectedValue 0 -recommendation "Disable"
