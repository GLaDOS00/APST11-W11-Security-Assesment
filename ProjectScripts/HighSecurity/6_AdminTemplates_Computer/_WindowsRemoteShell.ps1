# Function to check the status of: Administrative Templates (Computer) - Windows Remote Shell
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\WinRS"


# 18.10.90.1 (L2) Ensure 'Allow Remote Shell Access' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "AllowRemoteShellAccess" -expectedValue 0 -sectionNumber "18.10.90.1" -level "(L2)" -description "Allow Remote Shell Access" -recommendation "Disabled"