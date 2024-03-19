# Function to check the status of: Local Administrative Templates (Computer) - App Package Deployment
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\AppModel\StateManager"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Appx"

# 18.10.3.1 (L2) Ensure 'Allow a Windows app to share application data between users' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "AllowSharedLocalAppData" -expectedValue 0 -sectionNumber "18.10.3.1" -level "(L2)" -description "Allow a Windows app to share application data between users" -recommendation "Disabled"

# 18.10.3.2 (L1) Ensure 'Prevent non-admin users from installing packaged Windows apps' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "BlockNonAdminUserInstall" -expectedValue 1 -sectionNumber "18.10.3.2" -level "(L1)" -description "Prevent non-admin users from installing packaged Windows apps" -recommendation "Enabled"