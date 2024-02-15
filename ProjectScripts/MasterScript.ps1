# Master Script for Centralized Execution of CIS Benchmark Checks with Progress Bar

# Define the root directory where all scripts are stored
$rootDirectory = "C:\Users\User\Desktop\ProjectScripts"

# Define a log file to store the output
$logFile = "C:\Users\User\Desktop\CIS_Checks_Result.log"

# Function to execute scripts in a given directory
function Execute-ScriptsInDirectory {
    param (
        [string]$directoryPath,
        [int]$totalScripts,
        [ref]$scriptCounter
    )

    # Get all PowerShell scripts in the directory
    $scripts = Get-ChildItem -Path $directoryPath -Filter *.ps1

    foreach ($script in $scripts) {
        $scriptPath = Join-Path -Path $directoryPath -ChildPath $script.Name
        
        # Update progress
        $percentComplete = ($scriptCounter.Value / $totalScripts) * 100
        Write-Progress -PercentComplete $percentComplete -Status "Running CIS Benchmarks Checks" -Activity "Executing $scriptPath"

        # Execute the script and capture the output
        $scriptOutput = & powershell.exe -ExecutionPolicy Bypass -File $scriptPath
        $scriptOutput | Out-File -FilePath $logFile -Append

        $scriptCounter.Value++
    }
}

# Function to traverse directories and execute scripts, with progress tracking
function Traverse-And-Execute {
    param (
        [string]$basePath,
        [int]$totalScripts,
        [ref]$scriptCounter
    )

    # Get all directories in the base path
    $directories = Get-ChildItem -Path $basePath -Directory

    foreach ($dir in $directories) {
        $dirPath = Join-Path -Path $basePath -ChildPath $dir.Name

        # Execute scripts in the current directory
        Execute-ScriptsInDirectory -directoryPath $dirPath -totalScripts $totalScripts -scriptCounter $scriptCounter

        # Recursively traverse subdirectories
        Traverse-And-Execute -basePath $dirPath -totalScripts $totalScripts -scriptCounter $scriptCounter
    }
}

# Calculate total number of scripts to set the progress bar correctly
$totalScripts = (Get-ChildItem -Path $rootDirectory -Recurse -Filter *.ps1).Count
$scriptCounter = [ref]0

# Start execution with progress bar
Traverse-And-Execute -basePath $rootDirectory -totalScripts $totalScripts -scriptCounter $scriptCounter
Write-Host "CIS Benchmarks Checks completed. Check the log file at $logFile for details."
