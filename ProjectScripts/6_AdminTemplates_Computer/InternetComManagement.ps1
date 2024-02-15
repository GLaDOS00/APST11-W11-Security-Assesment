# Define function to check Internet Communication Management setting
function Check-InternetCommunicationSetting {
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

# 18.9.20.1.2 Ensure 'Turn off downloading of print drivers over HTTP' is set to 'Enabled'
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Printers"
$valueName = "DisableWebPnPDownload"
$expectedValue = "1"
$recommendation = "Enabled"
Check-InternetCommunicationSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.20.1.6 Ensure 'Turn off Internet download for Web publishing and online ordering wizards' is set to 'Enabled'
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
$valueName = "2201"
$expectedValue = "3"
$recommendation = "Enabled"
Check-InternetCommunicationSetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation
