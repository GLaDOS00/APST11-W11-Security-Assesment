# Function to check the status of: Administrative Templates (Computer) - Internet Communication Management
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
$RegPath1= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
$RegPath2= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$RegPath3= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\TabletPC"
$RegPath4= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports"
$RegPath5= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Internet Connection Wizard"
$RegPath6= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$RegPath7= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$RegPath8= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Registration Wizard Control"
$RegPath9= "HKLM:\SOFTWARE\Policies\Microsoft\SearchCompanion"
$RegPath10= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$RegPath11= "HKLM:\SOFTWARE\Policies\Microsoft\Messenger\Client"
$RegPath12= "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows"
$RegPath13= "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting"


# 18.9.20.1.1 (L2) Ensure 'Turn off access to the Store' is set to 'Enabled' 
Check-GPSetting -policyPath $RegPath1 -valueName "NoUseStoreOpenWith" -expectedValue 1 -sectionNumber "18.9.20.1.1" -level "(L2)" -description "Turn off access to the Store" -recommendation "Enabled"

# 18.9.20.1.2 (L1) Ensure 'Turn off downloading of print drivers over HTTP' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "DisableWebPnPDownload" -expectedValue 1 -sectionNumber "18.9.20.1.2" -level "(L1)" -description "Turn off downloading of print drivers over HTTP" -recommendation "Enabled"

# 18.9.20.1.3 (L2) Ensure 'Turn off handwriting personalization data sharing' is set to 'Enabled' 
Check-GPSetting -policyPath $RegPath3 -valueName "PreventHandwritingDataSharing" -expectedValue 1 -sectionNumber "18.9.20.1.3" -level "(L2)" -description "Turn off handwriting personalization data sharing" -recommendation "Enabled"

# 18.9.20.1.4 (L2) Ensure 'Turn off handwriting recognition error reporting' is set to 'Enabled' 
Check-GPSetting -policyPath $RegPath4 -valueName "PreventHandwritingErrorReports" -expectedValue 1 -sectionNumber "18.9.20.1.4" -level "(L2)" -description "Turn off handwriting recognition error reporting" -recommendation "Enabled"

# 18.9.20.1.5 (L2) Ensure 'Turn off Internet Connection Wizard if URL connection is referring to Microsoft.com' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath5 -valueName "ExitOnMSICW" -expectedValue 1 -sectionNumber "18.9.20.1.5" -level "(L2)" -description "Turn off Internet Connection Wizard if URL connection is referring to Microsoft.com" -recommendation "Enabled"

# 18.9.20.1.6 (L1) Ensure 'Turn off Internet download for Web publishing and online ordering wizards' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath6 -valueName "NoWebServices" -expectedValue 1 -sectionNumber "18.9.20.1.6" -level "(L1)" -description "Turn off Internet download for Web publishing and online ordering wizards" -recommendation "Enabled"

# 18.9.20.1.7 (L2) Ensure 'Turn off printing over HTTP' is set to 'Enabled' 
Check-GPSetting -policyPath $RegPath7 -valueName "DisableHTTPPrinting" -expectedValue 1 -sectionNumber "18.9.20.1.7" -level "(L2)" -description "Turn off printing over HTTP" -recommendation "Enabled"

# 18.9.20.1.8 (L2) Ensure 'Turn off Registration if URL connection is referring to Microsoft.com' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath8 -valueName "NoRegistration" -expectedValue 1 -sectionNumber "18.9.20.1.8" -level "(L2)" -description "Turn off Registration if URL connection is referring to Microsoft.com" -recommendation "Enabled"

# 18.9.20.1.9 (L2) Ensure 'Turn off Search Companion content file updates' is set to 'Enabled' 
Check-GPSetting -policyPath $RegPath9 -valueName "DisableContentFileUpdates" -expectedValue 1 -sectionNumber "18.9.20.1.9" -level "(L2)" -description "Turn off Search Companion content file updates" -recommendation "Enabled"

# 18.9.20.1.10 (L2) Ensure 'Turn off the "Order Prints" picture task' is set to 'Enabled' 
Check-GPSetting -policyPath $RegPath10 -valueName "NoOnlinePrintsWizard" -expectedValue 1 -sectionNumber "18.9.20.1.10" -level "(L2)" -description "Turn off the Order Prints picture task" -recommendation "Enabled"

# 18.9.20.1.11 (L2) Ensure 'Turn off the "Publish to Web" task for files and folders' is set to 'Enabled' 
Check-GPSetting -policyPath $RegPath10 -valueName "NoPublishingWizard" -expectedValue 1 -sectionNumber "18.9.20.1.11" -level "(L2)" -description "Turn off the Publish to Web task for files and folders" -recommendation "Enabled"

# 18.9.20.1.12 (L2) Ensure 'Turn off the Windows Messenger Customer Experience Improvement Program' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath11 -valueName "CEIP" -expectedValue 2 -sectionNumber "18.9.20.1.12" -level "(L2)" -description "Turn off the Windows Messenger Customer Experience Improvement Program" -recommendation "Enabled"

# 18.9.20.1.13 (L2) Ensure 'Turn off Windows Customer Experience Improvement Program' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath12 -valueName "CEIPEnable" -expectedValue 0 -sectionNumber "18.9.20.1.13" -level "(L2)" -description "Turn off Windows Customer Experience Improvement Program" -recommendation "Enabled"

# 18.9.20.1.14 (L2) Ensure 'Turn off Windows Error Reporting' is set to 'Enabled' 
Check-GPSetting -policyPath $RegPath13 -valueName "Disabled" -expectedValue 1 -sectionNumber "18.9.20.1.14" -level "(L2)" -description "Turn off Windows Error Reporting" -recommendation "Enabled"