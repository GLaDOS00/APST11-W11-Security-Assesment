# Function to check the status of: Administrative Templates (Computer) - News & Interests
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds"


# 18.10.50.1 (L2) Ensure 'Enable news and interests on the taskbar' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableFeeds" -expectedValue 0 -sectionNumber "18.10.50.1" -level "(L2)" -description "Enable news and interests on the taskbar" -recommendation "Disabled"