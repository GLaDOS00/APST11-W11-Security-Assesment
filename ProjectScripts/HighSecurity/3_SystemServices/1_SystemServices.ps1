# Function to check the status of: System Services 
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
	    elseif ($currentValue -eq $null) {
        # If $currentValue is $null, it might mean the service/path does not exist (i.e., not installed)
        if ($recommendation -like "*Not Installed*") {
            $status = "Compliant"
        }
	}
    Write-Host "$sectionNumber $level Ensure '$description' is set to '$recommendation': $status"
}


# Registry Values:
$RegPath= "HKLM:\SYSTEM\CurrentControlSet\Services\"
$RegPath1= "$RegPath\BTAGService"
$RegPath2= "$RegPath\bthserv"
$RegPath3= "$RegPath\Browser"
$RegPath4= "$RegPath\MapsBroker"
$RegPath5= "$RegPath\lfsvc"
$RegPath6= "$RegPath\IISADMIN"
$RegPath7= "$RegPath\irmon"
$RegPath8= "$RegPath\SharedAccess"
$RegPath9= "$RegPath\lltdsvc"
$RegPath10= "$RegPath\LxssManager"
$RegPath11= "$RegPath\FTPSVC"
$RegPath12= "$RegPath\MSiSCSI"
$RegPath13= "$RegPath\sshd"
$RegPath14= "$RegPath\PNRPsvc"
$RegPath15= "$RegPath\p2psvc"
$RegPath16= "$RegPath\p2pimsvc"
$RegPath17= "$RegPath\PNRPAutoReg"
$RegPath18= "$RegPath\Spooler"
$RegPath19= "$RegPath\wercplsupport"
$RegPath20= "$RegPath\RasAuto"
$RegPath21= "$RegPath\SessionEnv"
$RegPath22= "$RegPath\TermService"
$RegPath23= "$RegPath\UmRdpService"
$RegPath24= "$RegPath\RpcLocator"
$RegPath25= "$RegPath\RemoteRegistry"
$RegPath26= "$RegPath\RemoteAccess"
$RegPath27= "$RegPath\LanmanServer"
$RegPath28= "$RegPath\simptcp"
$RegPath29= "$RegPath\SNMP"
$RegPath30= "$RegPath\sacsvr"
$RegPath31= "$RegPath\SSDPSRV"
$RegPath32= "$RegPath\upnphost"
$RegPath33= "$RegPath\WMSvc"
$RegPath34= "$RegPath\WerSvc"
$RegPath35= "$RegPath\Wecsvc"
$RegPath36= "$RegPath\WMPNetworkSvc"
$RegPath37= "$RegPath\icssvc"
$RegPath38= "$RegPath\WpnService"
$RegPath39= "$RegPath\PushToInstall"
$RegPath40= "$RegPath\WinRM"
$RegPath41= "$RegPath\W3SVC"
$RegPath42= "$RegPath\XboxGipSvc"
$RegPath43= "$RegPath\XblAuthManager"
$RegPath44= "$RegPath\XblGameSave"
$RegPath45= "$RegPath\XboxNetApiSvc"


# 5.1 (L2) Ensure 'Bluetooth Audio Gateway Service (BTAGService)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath1 -valueName "Start" -expectedValue 4 -sectionNumber "5.1" -level "(L2)" -description "Bluetooth Audio Gateway Service (BTAGService)" -recommendation "Disabled"

# 5.2 (L2) Ensure 'Bluetooth Support Service (bthserv)' is set to 'Disabled'  
Check-GPSetting -policyPath $RegPath2 -valueName "Start" -expectedValue 4 -sectionNumber "5.2" -level "(L2)" -description "Bluetooth Support Service (bthserv)" -recommendation "Disabled"

# 5.3 (L1) Ensure 'Computer Browser (Browser)' is set to 'Disabled' or 'Not Installed'
Check-GPSetting -policyPath $RegPath3 -valueName "Start" -expectedValue 4 -sectionNumber "5.3" -level "(L1)" -description "Computer Browser (Browser)" -recommendation "Disabled or Not Installed"

# 5.4 (L2) Ensure 'Downloaded Maps Manager (MapsBroker)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath4 -valueName "Start" -expectedValue 4 -sectionNumber "5.4" -level "(L2)" -description "Downloaded Maps Manager (MapsBroker)" -recommendation "Disabled"

# 5.5 (L2) Ensure 'Geolocation Service (lfsvc)' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath5 -valueName "Start" -expectedValue 4 -sectionNumber "5.5" -level "(L2)" -description "Geolocation Service (lfsvc)" -recommendation "Disabled"

# 5.6 (L1) Ensure 'IIS Admin Service (IISADMIN)' is set to 'Disabled' or 'Not Installed' 
Check-GPSetting -policyPath $RegPath6 -valueName "Start" -expectedValue 4 -sectionNumber "5.6" -level "(L1)" -description "IIS Admin Service (IISADMIN)" -recommendation "Disabled or Not Installed"

# 5.7 (L1) Ensure 'Infrared monitor service (irmon)' is set to 'Disabled' or 'Not Installed' 
Check-GPSetting -policyPath $RegPath7 -valueName "Start" -expectedValue 4 -sectionNumber "5.7" -level "(L1)" -description "Infrared monitor service (irmon)" -recommendation "Disabled' or 'Not Installed"

# 5.8 (L1) Ensure 'Internet Connection Sharing (ICS) (SharedAccess)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath8 -valueName "Start" -expectedValue 4 -sectionNumber "5.8" -level "(L1)" -description "Internet Connection Sharing (ICS) (SharedAccess)" -recommendation "Disabled"

# 5.9 (L2) Ensure 'Link-Layer Topology Discovery Mapper (lltdsvc)' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath9 -valueName "Start" -expectedValue 4 -sectionNumber "5.9" -level "(L2)" -description "Link-Layer Topology Discovery Mapper (lltdsvc)" -recommendation "Disabled"

# 5.10 (L1) Ensure 'LxssManager (LxssManager)' is set to 'Disabled' or 'Not Installed'
Check-GPSetting -policyPath $RegPath10 -valueName "Start" -expectedValue 4 -sectionNumber "5.10" -level "(L1)" -description "LxssManager (LxssManager)" -recommendation "Disabled' or 'Not Installed"

# 5.11 (L1) Ensure 'Microsoft FTP Service (FTPSVC)' is set to 'Disabled' or 'Not Installed' 
Check-GPSetting -policyPath $RegPath11 -valueName "Start" -expectedValue 4 -sectionNumber "5.11" -level "(L1)" -description "Microsoft FTP Service (FTPSVC)" -recommendation "Disabled' or 'Not Installed"

# 5.12 (L2) Ensure 'Microsoft iSCSI Initiator Service (MSiSCSI)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath12 -valueName "Start" -expectedValue 4 -sectionNumber "5.12" -level "(L2)" -description "Microsoft iSCSI Initiator Service (MSiSCSI)" -recommendation "Disabled"

# 5.13 (L1) Ensure 'OpenSSH SSH Server (sshd)' is set to 'Disabled' or 'Not Installed' 
Check-GPSetting -policyPath $RegPath13 -valueName "Start" -expectedValue 4 -sectionNumber "5.13" -level "(L1)" -description "OpenSSH SSH Server (sshd)" -recommendation "Disabled' or 'Not Installed"

# 5.14 (L2) Ensure 'Peer Name Resolution Protocol (PNRPsvc)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath14 -valueName "Start" -expectedValue 4 -sectionNumber "5.14" -level "(L2)" -description "Peer Name Resolution Protocol (PNRPsvc)" -recommendation "Disabled"

# 5.15 (L2) Ensure 'Peer Networking Grouping (p2psvc)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath15 -valueName "Start" -expectedValue 4 -sectionNumber "5.15" -level "(L2)" -description "Peer Networking Grouping (p2psvc)" -recommendation "Disabled"

# 5.16 (L2) Ensure 'Peer Networking Identity Manager (p2pimsvc)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath16 -valueName "Start" -expectedValue 4 -sectionNumber "5.16" -level "(L2)" -description "Peer Networking Identity Manager (p2pimsvc)" -recommendation "Disabled"

# 5.17 (L2) Ensure 'PNRP Machine Name Publication Service (PNRPAutoReg)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath17 -valueName "Start" -expectedValue 4 -sectionNumber "5.17" -level "(L2)" -description "PNRP Machine Name Publication Service (PNRPAutoReg)" -recommendation "Disabled"

# 5.18 (L2) Ensure 'Print Spooler (Spooler)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath18 -valueName "Start" -expectedValue 4 -sectionNumber "5.18" -level "(L2)" -description "Print Spooler (Spooler)" -recommendation "Disabled"

# 5.19 (L2) Ensure 'Problem Reports and Solutions Control Panel Support (wercplsupport)' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath19 -valueName "Start" -expectedValue 4 -sectionNumber "5.19" -level "(L2)" -description "Problem Reports and Solutions Control Panel Support (wercplsupport)" -recommendation "Disabled"

#5.20 (L2) Ensure 'Remote Access Auto Connection Manager (RasAuto)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath20 -valueName "Start" -expectedValue 4 -sectionNumber "5.20" -level "(L2)" -description "Remote Access Auto Connection Manager (RasAuto)" -recommendation "Disabled"

# 5.21 (L2) Ensure 'Remote Desktop Configuration (SessionEnv)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath21 -valueName "Start" -expectedValue 4 -sectionNumber "5.21" -level "(L2)" -description "Remote Desktop Configuration (SessionEnv)" -recommendation "Disabled"

# 5.22 (L2) Ensure 'Remote Desktop Services (TermService)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath22 -valueName "Start" -expectedValue 4 -sectionNumber "5.22" -level "(L2)" -description "Remote Desktop Services (TermService)" -recommendation "Disabled"

# 5.23 (L2) Ensure 'Remote Desktop Services UserMode Port Redirector (UmRdpService)' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath23 -valueName "Start" -expectedValue 4 -sectionNumber "5.23" -level "(L2)" -description "Remote Desktop Services UserMode Port Redirector (UmRdpService)" -recommendation "Disabled"

# 5.24 (L1) Ensure 'Remote Procedure Call (RPC) Locator (RpcLocator)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath24 -valueName "Start" -expectedValue 4 -sectionNumber "5.24" -level "(L1)" -description "Remote Procedure Call (RPC) Locator (RpcLocator)" -recommendation "Disabled"

# 5.25 (L2) Ensure 'Remote Registry (RemoteRegistry)' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath25 -valueName "Start" -expectedValue 4 -sectionNumber "5.25" -level "(L2)" -description "Remote Registry (RemoteRegistry)" -recommendation "Disabled"

# 5.26 (L1) Ensure 'Routing and Remote Access (RemoteAccess)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath26 -valueName "Start" -expectedValue 4 -sectionNumber "5.26" -level "(L1)" -description "Routing and Remote Access (RemoteAccess)" -recommendation "Disabled"

# 5.27 (L2) Ensure 'Server (LanmanServer)' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath27 -valueName "Start" -expectedValue 4 -sectionNumber "5.27" -level "(L2)" -description "Server (LanmanServer)" -recommendation "Disabled"

# 5.28 (L1) Ensure 'Simple TCP/IP Services (simptcp)' is set to 'Disabled' or 'Not Installed' 
Check-GPSetting -policyPath $RegPath28 -valueName "Start" -expectedValue 4 -sectionNumber "5.28" -level "(L1)" -description "Simple TCP/IP Services (simptcp)" -recommendation "Disabled' or 'Not Installed"

# 5.29 (L2) Ensure 'SNMP Service (SNMP)' is set to 'Disabled' or 'Not Installed' 
Check-GPSetting -policyPath $RegPath29 -valueName "Start" -expectedValue 4 -sectionNumber "5.29" -level "(L2)" -description "SNMP Service (SNMP)" -recommendation "Disabled"

#5.30 (L1) Ensure 'Special Administration Console Helper (sacsvr)' is set to 'Disabled' or 'Not Installed'
Check-GPSetting -policyPath $RegPath30 -valueName "Start" -expectedValue 4 -sectionNumber "5.30" -level "(L1)" -description "Special Administration Console Helper (sacsvr)" -recommendation "Disabled' or 'Not Installed"

# 5.31 (L1) Ensure 'SSDP Discovery (SSDPSRV)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath31 -valueName "Start" -expectedValue 4 -sectionNumber "5.31" -level "(L1)" -description "SSDP Discovery (SSDPSRV)" -recommendation "Disabled"

# 5.32 (L1) Ensure 'UPnP Device Host (upnphost)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath32 -valueName "Start" -expectedValue 4 -sectionNumber "5.32" -level "(L1)" -description "UPnP Device Host (upnphost)" -recommendation "Disabled"

# 5.33 (L1) Ensure 'Web Management Service (WMSvc)' is set to 'Disabled' or 'Not Installed' 
Check-GPSetting -policyPath $RegPath33 -valueName "Start" -expectedValue 4 -sectionNumber "5.33" -level "(L1)" -description "Web Management Service (WMSvc)" -recommendation "Disabled' or 'Not Installed"

# 5.34 (L2) Ensure 'Windows Error Reporting Service (WerSvc)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath34 -valueName "Start" -expectedValue 4 -sectionNumber "5.34" -level "(L2)" -description "Windows Error Reporting Service (WerSvc)" -recommendation "Disabled"

# 5.35 (L2) Ensure 'Windows Event Collector (Wecsvc)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath35 -valueName "Start" -expectedValue 4 -sectionNumber "5.35" -level "(L2)" -description "Windows Event Collector (Wecsvc)" -recommendation "Disabled"

# 5.36 (L1) Ensure 'Windows Media Player Network Sharing Service (WMPNetworkSvc)' is set to 'Disabled' or 'Not Installed' 
Check-GPSetting -policyPath $RegPath36 -valueName "Start" -expectedValue 4 -sectionNumber "5.36" -level "(L1)" -description "Windows Media Player Network Sharing Service (WMPNetworkSvc)" -recommendation "Disabled' or 'Not Installed"

# 5.37 (L1) Ensure 'Windows Mobile Hotspot Service (icssvc)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath37 -valueName "Start" -expectedValue 4 -sectionNumber "5.37" -level "(L1)" -description "Windows Mobile Hotspot Service (icssvc)" -recommendation "Disabled"

# 5.38 (L2) Ensure 'Windows Push Notifications System Service (WpnService)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath38 -valueName "Start" -expectedValue 4 -sectionNumber "5.38" -level "(L2)" -description "Windows Push Notifications System Service (WpnService)" -recommendation "Disabled"

# 5.39 (L2) Ensure 'Windows PushToInstall Service (PushToInstall)' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath39 -valueName "Start" -expectedValue 4 -sectionNumber "5.39" -level "(L2)" -description "Windows PushToInstall Service (PushToInstall)" -recommendation "Disabled"

#5.40 (L2) Ensure 'Windows Remote Management (WS-Management) (WinRM)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath44 -valueName "Start" -expectedValue 4 -sectionNumber "5.40" -level "(L2)" -description "Windows Remote Management (WS-Management) (WinRM)" -recommendation "Disabled"

# 5.41 (L1) Ensure 'World Wide Web Publishing Service (W3SVC)' is set to 'Disabled' or 'Not Installed' 
Check-GPSetting -policyPath $RegPath41 -valueName "Start" -expectedValue 4 -sectionNumber "5.41" -level "(L1)" -description "World Wide Web Publishing Service (W3SVC)" -recommendation "Disabled' or 'Not Installed"

# 5.42 (L1) Ensure 'Xbox Accessory Management Service (XboxGipSvc)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath42 -valueName "Start" -expectedValue 4 -sectionNumber "5.42" -level "(L1)" -description "Xbox Accessory Management Service (XboxGipSvc)" -recommendation "Disabled"

# 5.43 (L1) Ensure 'Xbox Live Auth Manager (XblAuthManager)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath43 -valueName "Start" -expectedValue 4 -sectionNumber "5.43" -level "(L1)" -description "Xbox Live Auth Manager (XblAuthManager)" -recommendation "Disabled"

# 5.44 (L1) Ensure 'Xbox Live Game Save (XblGameSave)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath44 -valueName "Start" -expectedValue 4 -sectionNumber "5.44" -level "(L1)" -description "Xbox Live Game Save (XblGameSave)" -recommendation "Disabled"

# 5.45 (L1) Ensure 'Xbox Live Networking Service (XboxNetApiSvc)' is set to 'Disabled' 
Check-GPSetting -policyPath $RegPath45 -valueName "Start" -expectedValue 4 -sectionNumber "5.45" -level "(L1)" -description "Xbox Live Networking Service (XboxNetApiSvc)" -recommendation "Disabled"