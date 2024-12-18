# FIDO2 Token Management Tool
> [!NOTE]  
> Due to frequent antivirus false positives on PowerShell executables, we’re replacing wrappers and GUI apps with a new C++-based project under a different [repo](https://github.com/token2/fido2-manage.cpp). Both will remain open source but the C++ will be harder to compile than the one-click PowerShell version. This repo will probably not maintained any further


## Overview

The FIDO2 Token Management Tool (`fido2-manage.exe`) is a wrapper tool designed to enhance the usability of the libfido2 toolset. This tool provides a convenient way to perform various operations related to FIDO2 tokens, making it easier for users to manage their FIDO2 authentication devices.

## Key Features

- **User-Friendly Interface**: The tool uses a modified version libfido2 executable to allow for more intuitive interaction, including human-readable device names.
- **PIN Entry as an Argument**: Simplifies the process by allowing PIN entry directly as a command-line argument.

## Getting Started

### Prerequisites

- Windows operating system
- PowerShell
- FIDO2 authentication device




### Usage
You can use the FIDO2 Token Management Tool by either running the `FIDO2.1.Manager.ps1` script directly with PowerShell or with `run.bat`. **Note that this tool should be launched as administrator**

 



# Libfido2 Executable

This executable is included as a compiled `.exe` file and signed with the Token2 Code Signing certificate. The source code of the tool is available in the main project at [https://github.com/token2/fido2-manage](https://github.com/token2/fido2-manage).
