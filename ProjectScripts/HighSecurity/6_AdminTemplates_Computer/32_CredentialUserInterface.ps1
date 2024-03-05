# Function to check the status of: Administrative Templates (Computers) - Credential User Interface 
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredUI"
$RegPath2= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI"
$RegPath3= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"

# 18.10.14.1 (L1) Ensure 'Do not display the password reveal button' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "DisablePasswordReveal" -expectedValue 1 -sectionNumber "18.10.14.1" -description "Do not display the password reveal button" -recommendation "Enabled"

# 18.10.14.2 (L1) Ensure 'Enumerate administrator accounts on elevation' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "EnumerateAdministrators" -expectedValue 0 -sectionNumber "18.10.14.2" -description "Enumerate administrator accounts on elevation" -recommendation "Disabled"

# 18.10.14.3 (L1) Ensure 'Prevent the use of security questions for local accounts' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath3 -valueName "NoLocalPasswordResetQuestions" -expectedValue 1 -sectionNumber "18.10.14.3" -description "Prevent the use of security questions for local accounts" -recommendation "Enabled"