@echo off
REM Get the directory of the current .bat file
set CurrentDir=%~dp0

REM Change to that directory
cd /d "%CurrentDir%"

REM Run the PowerShell script
powershell -ExecutionPolicy Bypass -File "%CurrentDir%gui.ps1"
