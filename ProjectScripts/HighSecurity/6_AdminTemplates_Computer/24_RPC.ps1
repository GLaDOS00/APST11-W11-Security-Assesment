# Function to check the status of: Administrative Templates (Computer) - Remote Procedure Call (RPC)
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
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Rpc"


# 18.9.35.1 (L1) Ensure 'Enable RPC Endpoint Mapper Client Authentication' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "EnableAuthEpResolution" -expectedValue 1 -sectionNumber "18.9.35.1" -description "Enable RPC Endpoint Mapper Client Authentication" -recommendation "Enabled"

# 18.9.35.2 (L1) Ensure 'Restrict Unauthenticated RPC clients' is set to 'Enabled: Authenticated'
Check-GPSetting -policyPath $RegPath -valueName "RestrictRemoteClients" -expectedValue 1 -sectionNumber "18.9.35.2" -description "Restrict Unauthenticated RPC clients" -recommendation "Enabled: Authenticated"
