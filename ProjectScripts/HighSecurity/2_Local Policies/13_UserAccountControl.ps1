# Function to check the status of: Local Policy - User Account Control
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
$RegPath= "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"



# 2.3.17.1 (L1) Ensure 'User Account Control: Admin Approval Mode for the Built-in Administrator account' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "FilterAdministratorToken" -expectedValue 1 -sectionNumber "2.3.17.1" -description "User Account Control: Admin Approval Mode for the Built-in Administrator account" -recommendation "Enabled"

# 2.3.17.2 (L1) Ensure 'User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode' is set to 'Prompt for consent on the secure desktop' or higher
Check-GPSetting -policyPath $RegPath -valueName "ConsentPromptBehaviorAdmin" -expectedValue 2 -sectionNumber "2.3.17.2" -description "User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode" -recommendation "Prompt for consent on the secure desktop"

# 2.3.17.3 (L1) Ensure 'User Account Control: Behavior of the elevation prompt for standard users' is set to 'Automatically deny elevation requests'
Check-GPSetting -policyPath $RegPath -valueName "ConsentPromptBehaviorUser" -expectedValue 0 -sectionNumber "2.3.17.3" -description "User Account Control: Behavior of the elevation prompt for standard users" -recommendation "Automatically deny elevation requests"

# 2.3.17.4 (L1) Ensure 'User Account Control: Detect application installations and prompt for elevation' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableInstallerDetection" -expectedValue 1 -sectionNumber "2.3.17.4" -description "User Account Control: Detect application installations and prompt for elevation" -recommendation "Enabled"

# 2.3.17.5 (L1) Ensure 'User Account Control: Only elevate UIAccess applications that are installed in secure locations' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableSecureUIAPaths" -expectedValue 1 -sectionNumber "2.3.17.5" -description "User Account Control: Only elevate UIAccess applications that are installed in secure locations" -recommendation "Enabled"

# 2.3.17.6 (L1) Ensure 'User Account Control: Run all administrators in Admin Approval Mode' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableLUA" -expectedValue 1 -sectionNumber "2.3.17.6" -description "User Account Control: Run all administrators in Admin Approval Mode" -recommendation "Enabled"

# 2.3.17.7 (L1) Ensure 'User Account Control: Switch to the secure desktop when prompting for elevation' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "PromptOnSecureDesktop" -expectedValue 1 -sectionNumber "2.3.17.7" -description "'User Account Control: Switch to the secure desktop when prompting for elevation" -recommendation "Enabled"

# 2.3.17.8 (L1) Ensure 'User Account Control: Virtualize file and registry write failures to per-user locations' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableVirtualization" -expectedValue 1 -sectionNumber "2.3.17.8" -description "User Account Control: Virtualize file and registry write failures to per-user locations" -recommendation "Enabled"