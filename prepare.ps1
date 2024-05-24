Set-ExecutionPolicy -Scope Process Bypass

# Check if ps2exe is installed, if not, install it
if (-not (Get-Command ps2exe.exe -ErrorAction SilentlyContinue)) {
    Write-Host "ps2exe is not installed. Installing..."
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/MScholtes/PS2EXE/master/Module/ps2exe.ps1'))
}

# Compile fido2-manage.ps1 to fido2-manage.exe, console with admin rights requirement
Write-Host "Compiling fido2-manage.ps1 to fido2-manage.exe..."
ps2exe -inputFile fido2-manage.ps1 -outputFile fido2-manage.exe  -requireAdmin

# Compile gui.ps1 to "_FIDO2.1 Manager.exe", no-console with admin rights requirement and icon of t2.ico (same folder)
Write-Host "Compiling gui.ps1 to _FIDO2.1 Manager.exe..."
ps2exe -inputFile gui.ps1 -outputFile "_FIDO2.1 Manager.exe" -noConsole -requireAdmin -icon "t2.ico"
