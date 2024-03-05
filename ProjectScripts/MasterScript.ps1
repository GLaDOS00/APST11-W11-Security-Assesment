# Dynamically set the root directory to where the script is executed from
$rootDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define a log file to store the output, adjust the path as needed
$logFile = Join-Path -Path $rootDirectory -ChildPath "CIS_Checks_Result.log"

# Delete the log file if it exists to ensure it's overwritten
if (Test-Path $logFile) {
    Remove-Item $logFile
}

function Execute-ScriptsInDirectory {
    param (
        [string]$directoryPath,
        [int]$totalScripts,
        [ref]$scriptCounter
    )

    $scripts = Get-ChildItem -Path $directoryPath -Filter *.ps1

    foreach ($script in $scripts) {
        $scriptPath = Join-Path -Path $directoryPath -ChildPath $script.Name
        
        $percentComplete = ($scriptCounter.Value / $totalScripts) * 100
        Write-Progress -PercentComplete $percentComplete -Status "Running CIS Benchmarks Checks" -Activity "Executing $scriptPath"

        # Execute the script and capture the output, overwrite the file on the first write, then append
        $scriptOutput = & powershell.exe -ExecutionPolicy Bypass -File $scriptPath
        if ($scriptCounter.Value -eq 0) {
            $scriptOutput | Out-File -FilePath $logFile
        } else {
            $scriptOutput | Out-File -FilePath $logFile -Append
        }

        $scriptCounter.Value++
    }
}

function Traverse-And-Execute {
    param (
        [string]$basePath,
        [int]$totalScripts,
        [ref]$scriptCounter
    )

    $directories = Get-ChildItem -Path $basePath -Directory

    foreach ($dir in $directories) {
        $dirPath = Join-Path -Path $basePath -ChildPath $dir.Name

        Execute-ScriptsInDirectory -directoryPath $dirPath -totalScripts $totalScripts -scriptCounter $scriptCounter

        Traverse-And-Execute -basePath $dirPath -totalScripts $totalScripts -scriptCounter $scriptCounter
    }
}

$totalScripts = (Get-ChildItem -Path $rootDirectory -Recurse -Filter *.ps1).Count
$scriptCounter = [ref]0

Traverse-And-Execute -basePath $rootDirectory -totalScripts $totalScripts -scriptCounter $scriptCounter
Write-Host "CIS Benchmarks Checks completed. Check the log file at $logFile for details."
