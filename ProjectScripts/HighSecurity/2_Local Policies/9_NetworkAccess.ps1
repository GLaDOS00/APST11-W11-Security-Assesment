# Function to check the status of: Local Policy - Network Access
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [array]$expectedValue,
        [string]$sectionNumber,
        [string]$description,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    
    if ($currentValue -ne $null) {
        # Convert both the current value and expected value to sorted arrays for comparison
        $currentArray = @($currentValue.$valueName | Sort-Object)
        $expectedArray = @($expectedValue | Sort-Object)

        # Check if the arrays have the same elements in any order
        if (Compare-Object -ReferenceObject $currentArray -DifferenceObject $expectedArray -SyncWindow 0) {
            $status = "Non-Compliant"
        } else {
            $status = "Compliant"
        }
    }

    Write-Host "$sectionNumber (L1) Ensure '$description' is set to '$recommendation': $status"
}

# Recommended Paths
$expectedPaths1 = @(
    "System\CurrentControlSet\Control\ProductOptions",
    "System\CurrentControlSet\Control\Server Applications",
    "Software\Microsoft\Windows NT\CurrentVersion"
)

$expectedPaths2 = @(
    "System\CurrentControlSet\Control\Print\Printers",
    "System\CurrentControlSet\Services\Eventlog",
    "Software\Microsoft\OLAP Server",
    "Software\Microsoft\Windows NT\CurrentVersion\Print",
    "Software\Microsoft\Windows NT\CurrentVersion\Windows",
    "System\CurrentControlSet\Control\ContentIndex",
    "System\CurrentControlSet\Control\Terminal Server",
    "System\CurrentControlSet\Control\Terminal Server\UserConfig",
    "System\CurrentControlSet\Control\Terminal Server\DefaultUserConfiguration",
    "Software\Microsoft\Windows NT\CurrentVersion\Perflib",
    "System\CurrentControlSet\Services\SysmonLog"
)

$expectedPaths3 = @(

)

# Registry Values:
$RegPath1= "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$RegPath2= "HKLM:\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters"
$RegPath3= "HKLM:\SYSTEM\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedPaths"
$RegPath4= "HKLM:\SYSTEM\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedExactPaths"


# 2.3.10.1 (L1) Ensure 'Network access: Allow anonymous SID/Name translation' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "LSAAnonymousNameLookup" -expectedValue 0 -sectionNumber "2.3.10.1" -description "Network access: Allow anonymous SID/Name translation" -recommendation "Disabled"

# 2.3.10.2 (L1) Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "RestrictAnonymousSAM" -expectedValue 1 -sectionNumber "2.3.10.2" -description "Network access: Do not allow anonymous enumeration of SAM accounts" -recommendation "Enabled"

# 2.3.10.3 (L1) Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts and shares' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "RestrictAnonymous" -expectedValue 1 -sectionNumber "2.3.10.3" -description "Network access: Do not allow anonymous enumeration of SAM accounts and shares" -recommendation "Enabled"

# 2.3.10.4 (L1) Ensure 'Network access: Do not allow storage of passwords and credentials for network authentication' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath1 -valueName "DisableDomainCreds" -expectedValue 1 -sectionNumber "2.3.10.4" -description "Network access: Do not allow storage of passwords and credentials for network authentication" -recommendation "Enabled"

# 2.3.10.5 (L1) Ensure 'Network access: Let Everyone permissions apply to anonymous users' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath1 -valueName "EveryoneIncludesAnonymous" -expectedValue 0 -sectionNumber "2.3.10.5" -description "Network access: Let Everyone permissions apply to anonymous users" -recommendation "Disabled"

# 2.3.10.6 (L1) Ensure 'Network access: Named Pipes that can be accessed anonymously' is set to 'None'
Check-GPSetting -policyPath $RegPath2 -valueName "NullSessionPipes" -expectedValue $expectedPaths3 -sectionNumber "2.3.10.6" -description "Network access: Named Pipes that can be accessed anonymously" -recommendation "None"

# 2.3.10.7 (L1) Ensure 'Network access: Remotely accessible registry paths' is configured
Check-GPSetting -policyPath $RegPath4 -valueName "Machine" -expectedValue $expectedPaths1 -sectionNumber "2.3.10.7" -description "Network access: Remotely accessible registry paths" -recommendation "Configured"

# 2.3.10.8 (L1) Ensure 'Network access: Remotely accessible registry paths and sub-paths' is configured
Check-GPSetting -policyPath $RegPath3 -valueName "Machine" -expectedValue $expectedPaths2 -sectionNumber "2.3.10.8" -description "Network access: Remotely accessible registry paths and sub-paths" -recommendation "Configured"

# 2.3.10.9 (L1) Ensure 'Network access: Restrict anonymous access to Named Pipes and Shares' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath2 -valueName "RestrictNullSessAccess" -expectedValue 1 -sectionNumber "2.3.10.9" -description "Network access: Restrict anonymous access to Named Pipes and Shares" -recommendation "Enabled"

# 2.3.10.10 (L1) Ensure 'Network access: Restrict clients allowed to make remote calls to SAM' is set to 'Administrators: Remote Access: Allow'
Check-GPSetting -policyPath $RegPath1 -valueName "restrictremotesam" -expectedValue "O:BAG:BAD:(A;;RC;;;BA)" -sectionNumber "2.3.10.10" -description "Network access: Restrict clients allowed to make remote calls to SAM" -recommendation "Administrators: Remote Access: Allow"

# 2.3.10.11 (L1) Ensure 'Network access: Shares that can be accessed anonymously' is set to 'None'
Check-GPSetting -policyPath $RegPath2 -valueName "NullSessionShares" -expectedValue $expectedPaths3 -sectionNumber "2.3.10.11" -description "Network access: Shares that can be accessed anonymously" -recommendation "None"

# 2.3.10.12 (L1) Ensure 'Network access: Sharing and security model for local accounts' is set to 'Classic - local users authenticate as themselves'
Check-GPSetting -policyPath $RegPath1 -valueName "ForceGuest" -expectedValue 0 -sectionNumber "2.3.10.12" -description "Network access: Sharing and security model for local accounts" -recommendation "Classic - local users authenticate as themselves"