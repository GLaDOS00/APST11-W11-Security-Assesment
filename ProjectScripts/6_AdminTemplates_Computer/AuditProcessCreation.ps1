# Define function to check security setting
function Check-SecuritySetting {
    param (
        [string]$registryPath,
        [string]$valueName,
        [int]$expectedValue,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

    if ($currentValue -eq $null) {
        Write-Host "$valueName is not configured. Recommendation: $recommendation"
    } elseif ($currentValue.$valueName -eq $expectedValue) {
        Write-Host "$valueName is set to $expectedValue (Meets the recommendation)"
    } else {
        Write-Host "$valueName is set to $($currentValue.$valueName) (Does not meet the recommendation. Recommendation: $recommendation)"
    }
}

# 18.9.3.1 Ensure 'Include command line in process creation events' is set to 'Enabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit"
$valueName = "ProcessCreationIncludeCmdLine_Enabled"
$expectedValue = 1
$recommendation = "Enabled"
Check-SecuritySetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation
