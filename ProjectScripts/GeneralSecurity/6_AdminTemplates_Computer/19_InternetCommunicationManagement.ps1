# Function to check the status of: Administrative Templates (Computer) - Internet Communication Management
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$RegPath2= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"

# 18.9.20.1.2 (L1) Ensure 'Turn off downloading of print drivers over HTTP' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "DisableWebPnPDownload" -expectedValue 1 -sectionNumber "18.9.20.1.2" -description "Turn off downloading of print drivers over HTTP" -recommendation "Enabled"

# 18.9.20.1.6 (L1) Ensure 'Turn off Internet download for Web publishing and online ordering wizards' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "NoWebServices" -expectedValue 1 -sectionNumber "18.9.20.1.6" -description "Turn off Internet download for Web publishing and online ordering wizards" -recommendation "Enabled"
