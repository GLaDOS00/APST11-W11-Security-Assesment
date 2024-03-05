# Function to check the status of: Administrative Templates (Computer) - Windows Sandbox
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Sandbox"


# 18.10.91.1 (L1) Ensure 'Allow clipboard sharing with Windows Sandbox' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowClipboardRedirection" -expectedValue 0 -sectionNumber "18.10.91.1" -description "Allow clipboard sharing with Windows Sandbox" -recommendation "Disabled"

# 18.10.91.2 (L1) Ensure 'Allow networking in Windows Sandbox' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowNetworking" -expectedValue 0 -sectionNumber "18.10.91.2" -description "Allow networking in Windows Sandbox" -recommendation "Disabled"
