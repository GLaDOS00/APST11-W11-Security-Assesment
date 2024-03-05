# Function to check the status of: Local Administrative Templates (Computer) - App Package Deployment
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Appx"


# 18.10.3.2 (L1) Ensure 'Prevent non-admin users from installing packaged Windows apps' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "BlockNonAdminUserInstall" -expectedValue 1 -sectionNumber "18.10.3.2" -description "Prevent non-admin users from installing packaged Windows apps" -recommendation "Enabled"