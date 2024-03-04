# Function to check the status of: Administrative Templates (Computer) - Microsoft Defender Application Guard
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

# Registry Values:
$RegPath= "HKLM:\"


# 18.10.44.1 (L1) Ensure 'Allow auditing events in Microsoft Defender Application Guard' is set to 'Enabled'
Check-GPSetting -policyPath  -valueName "" -expectedValue  -sectionNumber "" -description "" -recommendation ""

# 18.10.44.2 (L1) Ensure 'Allow camera and microphone access in Microsoft Defender Application Guard' is set to 'Disabled'
Check-GPSetting -policyPath  -valueName "" -expectedValue  -sectionNumber "" -description "" -recommendation ""

# 18.10.44.3 (L1) Ensure 'Allow data persistence for Microsoft Defender Application Guard' is set to 'Disabled'
Check-GPSetting -policyPath  -valueName "" -expectedValue  -sectionNumber "" -description "" -recommendation ""

# 18.10.44.4 (L1) Ensure 'Allow files to download and save to the host operating system from Microsoft Defender Application Guard' is set to 'Disabled'
Check-GPSetting -policyPath  -valueName "" -expectedValue  -sectionNumber "" -description "" -recommendation ""

# 18.10.44.5 (L1) Ensure 'Configure Microsoft Defender Application Guard clipboard settings: Clipboard behavior setting' is set to 'Enabled: Enable clipboard operation from an isolated session to the host'
Check-GPSetting -policyPath  -valueName "" -expectedValue  -sectionNumber "" -description "" -recommendation ""

# 18.10.44.6 (L1) Ensure 'Turn on Microsoft Defender Application Guard in Managed Mode' is set to 'Enabled: 1'
Check-GPSetting -policyPath  -valueName "" -expectedValue  -sectionNumber "" -description "" -recommendation ""
