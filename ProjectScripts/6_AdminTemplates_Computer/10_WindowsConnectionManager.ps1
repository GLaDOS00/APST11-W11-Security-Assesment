# Function to check the status of Windows Connection Manager Group Policy settings
function Check-WindowsConnectionManager-GPSetting {
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

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to 'Enabled': $status"
}

# Define the registry path for Windows Connection Manager settings
$windowsConnectionManagerPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy"

# Check 'Minimize the number of simultaneous connections to the Internet or a Windows Domain'
Check-WindowsConnectionManager-GPSetting -policyPath $windowsConnectionManagerPolicyPath -valueName "fMinimizeConnections" -expectedValue 3 -sectionNumber "18.6.21.1" -description "Minimize the number of simultaneous connections to the Internet or a Windows Domain"

# Check 'Prohibit connection to non-domain networks when connected to domain authenticated network'
Check-WindowsConnectionManager-GPSetting -policyPath $windowsConnectionManagerPolicyPath -valueName "fBlockNonDomain" -expectedValue 1 -sectionNumber "18.6.21.2" -description "Prohibit connection to non-domain networks when connected to domain authenticated network"
