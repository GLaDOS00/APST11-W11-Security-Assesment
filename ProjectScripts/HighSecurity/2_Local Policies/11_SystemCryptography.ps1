# Function to check the status of: Local Policies - System Cryptography
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

    Write-Host "$sectionNumber (L2) Ensure '$description' is set to '$recommendation': $status"
}



# Registry Values:
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography"


# 2.3.14.1 (L2) Ensure 'System cryptography: Force strong key protection for user keys stored on the computer' is set to 'User is prompted when the key is first used' or higher
Check-GPSetting -policyPath $RegPath -valueName "ForceKeyProtection" -expectedValue 1 -sectionNumber "2.3.14.1" -description "System cryptography: Force strong key protection for user keys stored on the computer" -recommendation "User is prompted when the key is first used"