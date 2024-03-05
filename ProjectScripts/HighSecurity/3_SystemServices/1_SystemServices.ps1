# PowerShell Script to Check System Services Against CIS Benchmarks for Windows 11 Enterprise

# Export the system services configuration to a temporary file
$serviceExportPath = "$env:TEMP\service_config.csv"
Get-Service | Export-Csv -Path $serviceExportPath -NoTypeInformation

# Function to check the service status
function Check-ServiceStatus {
    param (
        [string]$serviceName,
        [string]$displayName,
        [string]$benchmarkNumber
    )
    $services = Import-Csv -Path $serviceExportPath
    $service = $services | Where-Object { $_.Name -eq $serviceName -or $_.DisplayName -eq $displayName }
    
    if ($null -eq $service) {
        Write-Host "$benchmarkNumber Ensure '$displayName' is set to 'Disabled' or 'Not Installed': Compliant"
    } elseif ($service.Status -eq "Stopped") {
        Write-Host "$benchmarkNumber Ensure '$displayName' is set to 'Disabled': Compliant"
    } else {
        Write-Host "$benchmarkNumber Ensure '$displayName' is set to 'Disabled': Non-Compliant"
    }
}

# Check each service

# List of services to check with their corresponding CIS Benchmark number
$servicesToCheck = @(
    @{ Name = "Browser"; DisplayName = "Computer Browser"; BenchmarkNumber = "5.3 (L1)" },
    @{ Name = "IISADMIN"; DisplayName = "IIS Admin Service"; BenchmarkNumber = "5.6 (L1)" },
    @{ Name = "irmon"; DisplayName = "Infrared monitor service"; BenchmarkNumber = "5.7 (L1)" },
    @{ Name = "SharedAccess"; DisplayName = "Internet Connection Sharing (ICS)"; BenchmarkNumber = "5.8 (L1)" },
    @{ Name = "LxssManager"; DisplayName = "LxssManager"; BenchmarkNumber = "5.10 (L1)" },
    @{ Name = "FTPSVC"; DisplayName = "Microsoft FTP Service"; BenchmarkNumber = "5.11 (L1)" },
    @{ Name = "sshd"; DisplayName = "OpenSSH SSH Server"; BenchmarkNumber = "5.13 (L1)" },
    @{ Name = "RpcLocator"; DisplayName = "Remote Procedure Call (RPC) Locator"; BenchmarkNumber = "5.24 (L1)" },
    @{ Name = "RemoteAccess"; DisplayName = "Routing and Remote Access"; BenchmarkNumber = "5.26 (L1)" },
    @{ Name = "simptcp"; DisplayName = "Simple TCP/IP Services"; BenchmarkNumber = "5.28 (L1)" },
    @{ Name = "sacsvr"; DisplayName = "Special Administration Console Helper"; BenchmarkNumber = "5.30 (L1)" },
    @{ Name = "SSDPSRV"; DisplayName = "SSDP Discovery"; BenchmarkNumber = "5.31 (L1)" },
    @{ Name = "upnphost"; DisplayName = "UPnP Device Host"; BenchmarkNumber = "5.32 (L1)" },
    @{ Name = "WMSvc"; DisplayName = "Web Management Service"; BenchmarkNumber = "5.33 (L1)" },
    @{ Name = "WMPNetworkSvc"; DisplayName = "Windows Media Player Network Sharing Service"; BenchmarkNumber = "5.36 (L1)" },
    @{ Name = "icssvc"; DisplayName = "Windows Mobile Hotspot Service"; BenchmarkNumber = "5.37 (L1)" },
    @{ Name = "W3SVC"; DisplayName = "World Wide Web Publishing Service"; BenchmarkNumber = "5.41 (L1)" },
    @{ Name = "XboxGipSvc"; DisplayName = "Xbox Accessory Management Service"; BenchmarkNumber = "5.42 (L1)" },
    @{ Name = "XblAuthManager"; DisplayName = "Xbox Live Auth Manager"; BenchmarkNumber = "5.43 (L1)" },
    @{ Name = "XblGameSave"; DisplayName = "Xbox Live Game Save"; BenchmarkNumber = "5.44 (L1)" },
    @{ Name = "XboxNetApiSvc"; DisplayName = "Xbox Live Networking Service"; BenchmarkNumber = "5.45 (L1)" }
)

foreach ($service in $servicesToCheck) {
    Check-ServiceStatus -serviceName $service.Name -displayName $service.DisplayName -benchmarkNumber $service.BenchmarkNumber
}

# Cleanup temporary file
Remove-Item $serviceExportPath -ErrorAction SilentlyContinue

# End of script
