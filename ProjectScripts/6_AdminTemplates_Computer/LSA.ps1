# Define function to check LSA setting
function Check-LSASetting {
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

# 18.9.25.1 Ensure 'Allow Custom SSPs and APs to be loaded into LSASS' is set to 'Disabled'
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$valueName = "DisableRestrictedAdmin"
$expectedValue = "1"
$recommendation = "Disabled"
Check-LSASetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation

# 18.9.25.2 Ensure 'Configures LSASS to run as a protected process' is set to 'Enabled: Enabled with UEFI Lock'
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$valueName = "RunAsPPL"
$expectedValue = "1"
$recommendation = "Enabled with UEFI Lock"
Check-LSASetting -registryPath $registryPath -valueName $valueName -expectedValue $expectedValue -recommendation $recommendation
