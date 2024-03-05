# Function to check the status of: Administrative Templates (Computer) - File Explorer
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
$RegPath2= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"


# 18.10.29.2 (L1) Ensure 'Turn off Data Execution Prevention for Explorer' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "NoDataExecutionPrevention" -expectedValue 0 -sectionNumber "18.10.29.2" -description "Turn off Data Execution Prevention for Explorer" -recommendation "Disabled"

# 18.10.29.4 (L1) Ensure 'Turn off heap termination on corruption' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "NoHeapTerminationOnCorruption" -expectedValue 0 -sectionNumber "18.10.29.4" -description "Turn off heap termination on corruption" -recommendation "Disabled"

# 18.10.29.5 (L1) Ensure 'Turn off shell protocol protected mode' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath2 -valueName "PreXPSP2ShellProtocolBehavior" -expectedValue 0 -sectionNumber "18.10.29.5" -description "Turn off shell protocol protected mode" -recommendation "Disabled"
