# Function to check the status of: Administrative Templates (Computer) - Cloud Content
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"


# 18.10.12.1 (L1) Ensure 'Turn off cloud consumer account state content' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DisableConsumerAccountStateContent" -expectedValue 1 -sectionNumber "18.10.12.1" -description "Turn off cloud consumer account state content" -recommendation "Enabled"

# 18.10.12.3 (L1) Ensure 'Turn off Microsoft consumer experiences' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DisableCloudOptimizedContent" -expectedValue 1 -sectionNumber "18.10.12.2" -description "Turn off Microsoft consumer experiences" -recommendation "Enabled"