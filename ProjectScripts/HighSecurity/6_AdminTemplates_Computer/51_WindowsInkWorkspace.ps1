# Function to check the status of: Administrative Templates (Computer) - Windows Ink Workspace
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace"


# 18.10.80.1 (L2) Ensure 'Allow suggested apps in Windows Ink Workspace' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowSuggestedAppsInWindowsInkWorkspace" -expectedValue 0 -sectionNumber "18.10.80.1" -level "(L2)" -description "Allow suggested apps in Windows Ink Workspace" -recommendation "Disabled"

# 18.10.80.2 (L1) Ensure 'Allow Windows Ink Workspace' is set to 'Enabled: On, but disallow access above lock'
Check-GPSetting -policyPath $RegPath -valueName "AllowWindowsInkWorkspace" -expectedValue 1 -sectionNumber "18.10.80.2" -level "(L1)" -description "Allow Windows Ink Workspace" -recommendation "Enabled: On, but disallow access above lock"