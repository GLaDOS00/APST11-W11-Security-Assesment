# Define function to check AutoPlay Policies setting
function Check-AutoPlayPoliciesSetting {
    param (
        [string]$registryPath,
        [string]$valueName,
        [string]$expectedValue,
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

# 18.10.7.1 Ensure 'Disallow Autoplay for non-volume devices' is set to 'Enabled'
$registryPath1 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
$valueName1 = "NoAutoplayfornonVolume"

# 18.10.7.2 Ensure 'Set the default behavior for AutoRun' is set to 'Enabled: Do not execute any autorun commands'
$registryPath2 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$valueName2 = "NoAutorun"

# 18.10.7.3 Ensure 'Turn off Autoplay' is set to 'Enabled: All drives'
$registryPath3 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$valueName3 = "NoDriveTypeAutoRun"

$expectedValue = "1"
$recommendation = "Enabled"

# Call the function to check AutoPlay Policies settings
Check-AutoPlayPoliciesSetting -registryPath $registryPath1 -valueName $valueName1 -expectedValue $expectedValue -recommendation $recommendation
Check-AutoPlayPoliciesSetting -registryPath $registryPath2 -valueName $valueName2 -expectedValue $expectedValue -recommendation $recommendation
Check-AutoPlayPoliciesSetting -registryPath $registryPath3 -valueName $valueName3 -expectedValue $expectedValue -recommendation $recommendation
