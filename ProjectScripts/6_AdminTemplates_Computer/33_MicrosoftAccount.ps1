# Function to check the status of: Administrative Templates (Computer) - Microsoft Account 
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftAccount"


# 18.10.42.1 (L1) Ensure 'Block all consumer Microsoft account user authentication' is set to 'Enabled’
Check-GPSetting -policyPath $RegPath -valueName "DisableUserAuth" -expectedValue 1 -sectionNumber "18.10.42.1" -description "Block all consumer Microsoft account user authentication" -recommendation "Enabled"