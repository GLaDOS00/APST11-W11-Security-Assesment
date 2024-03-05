# Function to check the status of: Administrative Templates (Computer) - LSA
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
$RegPath2= "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"


# 18.9.25.1 (L1) Ensure 'Allow Custom SSPs and APs to be loaded into LSASS' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "AllowCustomSSPsAPs" -expectedValue 0 -sectionNumber "18.9.25.1" -description "Allow Custom SSPs and APs to be loaded into LSASS" -recommendation "Disabled"

# 18.9.25.2 (L1) Ensure 'Configures LSASS to run as a protected process' is set to 'Enabled: Enabled with UEFI Lock'
Check-GPSetting -policyPath $RegPath2 -valueName "RunAsPPL" -expectedValue 1 -sectionNumber "18.9.25.2" -description "Configures LSASS to run as a protected process" -recommendation "Enabled: Enabled with UEFI Lock"
