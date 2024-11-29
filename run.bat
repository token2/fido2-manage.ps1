@echo off
REM Get the directory of the current .bat file
set CurrentDir=%~dp0

REM Change to that directory
cd /d "%CurrentDir%"

REM Rename the file if it exists
if exist "FIDO2.1.Manager.ps1.txt" (
    rename "FIDO2.1.Manager.ps1.txt" "FIDO2.1.Manager.ps1"
)

REM Run the PowerShell script
powershell -ExecutionPolicy Bypass -File "%CurrentDir%FIDO2.1.Manager.ps1"
