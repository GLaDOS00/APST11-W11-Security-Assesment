# READ ME
# PROJECT INFORMATION
Created By: Zack Clarke, Logan Hotrum, Benjamin Mathew, & Mirudhubashini Subramaniam

This automated assesment tool utilizes PowerShell scripts to check registry and group policy values of a Windows 11 Enterprise environment in accordance to recommendations outlined within CIS's W11 Enterprise Benchmarks.

CIS W11 Enterprise Benchmarks can be downloaded from here: https://www.cisecurity.org/benchmark/microsoft_windows_desktop

# INSTRUCTIONS
This assesment tool has 3 different configurations that are organized in the following sub-directories; General Security, High Security, & BitLocker

General Security = Level 1 (L1)
High Security = Level 1 (L1) + Level 2 (L2) and/or (BL)
BitLocker = BL

Run the desired assesment by locating the "MasterScript.ps1" file in the sub-directory. The master script will sequentially run the subsequent configuration check scripts and produce a log file within the subdirectory containing the results of the automated assesment.
