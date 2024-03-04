# Function to check the status of: Administrative Templates (Computer) - Windows Ink Workspace
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace"


# 18.10.80.2 (L1) Ensure 'Allow Windows Ink Workspace' is set to 'Enabled: On, but disallow access above lock'
Check-GPSetting -policyPath $RegPath -valueName "AllowWindowsInkWorkspace" -expectedValue 1 -sectionNumber "18.10.80.2" -description "Allow Windows Ink Workspace" -recommendation "Enabled: On, but disallow access above lock"