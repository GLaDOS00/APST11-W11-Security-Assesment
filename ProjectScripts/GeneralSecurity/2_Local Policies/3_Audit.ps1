# Function to check the status of Local Policy - Audit
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

# Regristry Value Path:
$RegPath= "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"


# 2.3.2.1 (L1) Ensure 'Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "SCENoApplyLegacyAuditPolicy" -expectedValue 1 -sectionNumber "2.3.2.1" -description "Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings" -recommendation "Enabled"

# 2.3.2.2 (L1) Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "CrashOnAuditFail" -expectedValue 0 -sectionNumber "2.3.2.2" -description "Audit: Shut down system immediately if unable to log security audits" -recommendation "Disabled"