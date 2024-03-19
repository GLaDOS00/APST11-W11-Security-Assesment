# Function to check the status of: Administrative Templates (Computer) - Link-Layer Topology Discovery
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
    if ($currentValue -eq $null -or $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber $level Ensure '$description' is set to '$recommendation': $status"
}



# Registry Values:
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LLTD"


# 18.6.9.1 (L2) Ensure 'Turn on Mapper I/O (LLTDIO) driver' is set to 'Disabled'  
Check-GPSetting -policyPath $RegPath -valueName "EnableLLTDIO" -expectedValue 0,$null -sectionNumber "18.6.9.1" -level "(L2)" -description "Turn on Mapper I/O (LLTDIO) driver" -recommendation "Disabled"

# 18.6.9.2 (L2) Ensure 'Turn on Responder (RSPNDR) driver' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath -valueName "EnableRspndr" -expectedValue 0,$null -sectionNumber "18.6.9.2" -level "(L2)" -description "Turn on Responder (RSPNDR) driver" -recommendation "Disabled"