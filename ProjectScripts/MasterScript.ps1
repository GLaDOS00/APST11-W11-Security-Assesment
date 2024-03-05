# Check if the script is running as an Administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Relaunch the script with administrator rights
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

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

    # Retrieve all script files and sort them by name in numeric order
    $scripts = Get-ChildItem -Path $directoryPath -Filter *.ps1 | Sort-Object { [regex]::Match($_.Name, '\d+').Value -as [int] }

    foreach ($script in $scripts) {
        $scriptPath = Join-Path -Path $directoryPath -ChildPath $script.Name
        
        $percentComplete = ($scriptCounter.Value / $totalScripts) * 100
        Write-Progress -PercentComplete $percentComplete -Status "Running CIS Benchmarks Checks" -Activity "Executing $scriptPath"

        # Execute the script and capture the output, overwrite the file on the first write, then append
        $scriptOutput = & powershell.exe -ExecutionPolicy Bypass -File $scriptPath
        if ($scriptCounter.Value -eq 1) {
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

function ParseAndDisplayLogContent {
    $logContent = Get-Content -Path $logFile
    $results = @()

    foreach ($line in $logContent) {
        if ($line -match '(\d+\.\d+\.\d+)\s+\((L\d+)\)\s+Ensure\s+(.*?):\s*(Compliant|Non-Compliant)') {
            $results += [PSCustomObject]@{
                SectionNumber = $matches[1]
                Level = $matches[2]
                Description = $matches[3]
                Compliance = $matches[4]
            }
        }
    }

    # Sort results by SectionNumber
    $sortedResults = $results | Sort-Object { [version]($_.SectionNumber) }

    # Define the path for the formatted log file
    $formattedLogFile = Join-Path -Path $rootDirectory -ChildPath "CIS_Checks_Formatted_Result.log"

    # Clear or create the formatted log file
    if (Test-Path $formattedLogFile) {
        Remove-Item $formattedLogFile
    }

    # Output sorted results to the formatted log file
    foreach ($result in $sortedResults) {
        $formattedOutput = "Section Number: $($result.SectionNumber)`r`nLevel: $($result.Level)`r`nDescription/Recommendation: $($result.Description)`r`nCompliance: $($result.Compliance)`r`n`r`n"
        Add-Content -Path $formattedLogFile -Value $formattedOutput
    }
}


$totalScripts = (Get-ChildItem -Path $rootDirectory -Recurse -Filter *.ps1).Count
$scriptCounter = [ref]1

Traverse-And-Execute -basePath $rootDirectory -totalScripts $totalScripts -scriptCounter $scriptCounter
Write-Host "CIS Benchmarks Checks completed. Check the log file at $logFile for details."

# After all scripts have been executed and the log file has been generated, parse and display the log content
ParseAndDisplayLogContent
