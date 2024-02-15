# Define function to check Cloud Content settings
function Check-CloudContentSettings {
    param (
        [string]$registryPath1,
        [string]$valueName1,
        [string]$expectedValue1,
        [string]$recommendation1,

        [string]$registryPath2,
        [string]$valueName2,
        [string]$expectedValue2,
        [string]$recommendation2
    )

    # Check the first setting
    $currentValue1 = Get-ItemProperty -Path $registryPath1 -Name $valueName1 -ErrorAction SilentlyContinue

    if ($currentValue1 -eq $null) {
        Write-Host "$valueName1 is not configured. Recommendation: $recommendation1"
    } elseif ($currentValue1.$valueName1 -eq $expectedValue1) {
        Write-Host "$valueName1 is set to $expectedValue1 (Meets the recommendation)"
    } else {
        Write-Host "$valueName1 is set to $($currentValue1.$valueName1) (Does not meet the recommendation. Recommendation: $recommendation1)"
    }

    # Check the second setting
    $currentValue2 = Get-ItemProperty -Path $registryPath2 -Name $valueName2 -ErrorAction SilentlyContinue

    if ($currentValue2 -eq $null) {
        Write-Host "$valueName2 is not configured. Recommendation: $recommendation2"
    } elseif ($currentValue2.$valueName2 -eq $expectedValue2) {
        Write-Host "$valueName2 is set to $expectedValue2 (Meets the recommendation)"
    } else {
        Write-Host "$valueName2 is set to $($currentValue2.$valueName2) (Does not meet the recommendation. Recommendation: $recommendation2)"
    }
}

# 18.10.12.1 Ensure 'Turn off cloud consumer account state content' is set to 'Enabled'
$registryPath1 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$valueName1 = "DisableAccountState"

$expectedValue1 = "1"
$recommendation1 = "Enabled"

# 18.10.12.3 Ensure 'Turn off Microsoft consumer experiences' is set to 'Enabled'
$registryPath2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$valueName2 = "DisableWindowsConsumerFeatures"

$expectedValue2 = "1"
$recommendation2 = "Enabled"

# Call the function to check Cloud Content settings
Check-CloudContentSettings -registryPath1 $registryPath1 -valueName1 $valueName1 -expectedValue1 $expectedValue1 -recommendation1 $recommendation1 -registryPath2 $registryPath2 -valueName2 $valueName2 -expectedValue2 $expectedValue2 -recommendation2 $recommendation2
