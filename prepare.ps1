# Check if ps2exe is installed, if not, install it from PowerShell Gallery
if (-not (Get-Command ps2exe -ErrorAction SilentlyContinue)) {
    Write-Host "ps2exe is not installed. Installing from PowerShell Gallery..."

    # Install ps2exe module from PowerShell Gallery
    Install-Module -Name ps2exe -Force -Scope CurrentUser
}

# Import ps2exe module to ensure it's loaded
Import-Module ps2exe

# Compile fido2-manage.ps1 to fido2-manage.exe, console with admin rights requirement
Write-Host "Compiling fido2-manage.ps1 to fido2-manage.exe..."
ps2exe -inputFile fido2-manage.ps1 -outputFile fido2-manage.exe -requireAdmin

# Compile gui.ps1 to "_FIDO2.1 Manager.exe", no-console with admin rights requirement and icon of t2.ico (same folder)
Write-Host "Compiling gui.ps1 to _FIDO2.1 Manager.exe..."
ps2exe -inputFile gui.ps1 -outputFile "_FIDO2.1 Manager.exe" -noConsole -requireAdmin -icon "t2.ico"
