# FIDO2 Token Management Tool

## Overview

The FIDO2 Token Management Tool (`fido2-manage.ps1`) is a PowerShell script designed to enhance the usability of the libfido2 toolset. This tool provides a convenient way to perform various operations related to FIDO2 tokens, making it easier for users to manage their FIDO2 authentication devices.

## Key Features

- **User-Friendly Interface**: The tool uses a modified version libfido2 executable to allow for more intuitive interaction, including human-readable device names.
- **PIN Entry as an Argument**: Simplifies the process by allowing PIN entry directly as a command-line argument.

## Getting Started

### Prerequisites

- Windows operating system
- PowerShell
- FIDO2 authentication device


### Installation

1. Download the script and run it as an administrator

### Usage

You can use the FIDO2 Token Management Tool by either running the `fido2-manage.ps1` script directly with PowerShell or compiling it to an executable using ps2exe.

You can compile the script to an executable using ps2exe for easier distribution:

`ps2exe .\fido2-manage.ps1 .\fido2-manage.exe`

#### Running with PowerShell

To run the tool with PowerShell, open a PowerShell prompt and execute the script with the desired options. For example:

```powershell
.\fido2-manage.ps1 -list
```



# Libfido2 Executable

This executable is included as a compiled `.exe` file and signed with the Token2 Code Signing certificate. However, the source code of the tool is available in the main project at [https://github.com/token2/fido2-manage](https://github.com/token2/fido2-manage).
