# Function to check the status of: Administrative Template (Computer) - Windows Search
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"


# 18.10.59.2 (L2) Ensure 'Allow Cloud Search' is set to 'Enabled: Disable Cloud Search'
Check-GPSetting -policyPath $RegPath -valueName "AllowCloudSearch" -expectedValue 0 -sectionNumber "18.10.59.2" -level "(L2)" -description "Allow Cloud Search" -recommendation "Enabled: Disable Cloud Search"

# 18.10.59.3 (L1) Ensure 'Allow Cortana' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowCortana" -expectedValue 0 -sectionNumber "18.10.59.3" -level "(L1)" -description "Allow Cortana" -recommendation "Disabled"

# 18.10.59.4 (L1) Ensure 'Allow Cortana above lock screen' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath -valueName "AllowCortanaAboveLock" -expectedValue 0 -sectionNumber "18.10.59.4" -level "(L1)" -description "Allow Cortana above lock screen" -recommendation "Disabled"

# 18.10.59.5 (L1) Ensure 'Allow indexing of encrypted files' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath -valueName "AllowIndexingEncryptedStoresOrItems" -expectedValue 0 -sectionNumber "18.10.59.5" -level "(L1)" -description "Allow indexing of encrypted files" -recommendation "Disabled"

# 18.10.59.6 (L1) Ensure 'Allow search and Cortana to use location' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowSearchToUseLocation" -expectedValue 0 -sectionNumber "18.10.59.6" -level "(L1)" -description "Allow search and Cortana to use location" -recommendation "Disabled"

# 18.10.59.7 (L2) Ensure 'Allow search highlights' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableDynamicContentInWSB" -expectedValue 0 -sectionNumber "18.10.59.7" -level "(L2)" -description "Allow search highlights" -recommendation "Disabled"