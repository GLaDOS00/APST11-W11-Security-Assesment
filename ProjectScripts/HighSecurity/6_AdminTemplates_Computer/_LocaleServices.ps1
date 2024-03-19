# Function to check the status of: Administrative Templates (Computer) - Locale Services
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Control Panel\International"


# 18.9.26.1 (L2) Ensure 'Disallow copying of user input methods to the system account for sign-in' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "BlockUserInputMethodsForSignIn" -expectedValue 1 -sectionNumber "18.9.26.1" -level "(L2)" -description "Disallow copying of user input methods to the system account for sign-in" -recommendation "Enabled"