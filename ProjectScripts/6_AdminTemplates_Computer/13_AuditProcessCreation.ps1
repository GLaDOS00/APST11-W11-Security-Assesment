# Define a function to check the status of the 'Include command line in process creation events' setting
function Check-AuditProcessCreationSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
        [string]$description
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to 'Disabled': $status"
}

# Registry path for the 'Audit Process Creation' settings
$auditProcessCreationPolicyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit"

# Check the 'Include command line in process creation events' setting
Check-AuditProcessCreationSetting -policyPath $auditProcessCreationPolicyPath -valueName "ProcessCreationIncludeCmdLine_Enabled" -expectedValue 1 -sectionNumber "18.9.3.1" -description "Include command line in process creation events is set to Enabled"
