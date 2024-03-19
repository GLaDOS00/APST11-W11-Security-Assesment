# Function to check the status of: Administrative Templates (Computer) - Microsoft Peer-to-Peer (P2P) Networking Services
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Peernet"


# 18.6.10.2 (L2) Ensure 'Turn off Microsoft Peer-to-Peer Networking Services' is set to 'Enabled’ 
Check-GPSetting -policyPath $RegPath -valueName "Disabled" -expectedValue 1 -sectionNumber "18.6.10.2" -level "(L2)" -description "Turn off Microsoft Peer-to-Peer Networking Services" -recommendation "Enabled"