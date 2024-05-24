# FIDO2 Token Management Tool

## Overview

The FIDO2 Token Management Tool (`fido2-manage.ps1`) is a PowerShell script designed to enhance the usability of the libfido2 toolset. This tool provides a convenient way to perform various operations related to FIDO2 tokens, making it easier for users to manage their FIDO2 authentication devices.

## Key Features

- **User-Friendly Interface**: The tool modifies the original libfido2 executable to allow for more intuitive interaction, including human-readable device names.
- **PIN Entry as an Argument**: Simplifies the process by allowing PIN entry directly as a command-line argument.
- **Comprehensive Token Management**: Supports a wide range of operations related to FIDO2 tokens, leveraging the capabilities of libfido2.

## Getting Started

### Prerequisites

- Windows operating system
- PowerShell
- FIDO2 authentication device
- libfido2 library

### Installation

1. Download the `fido2-manage.ps1` script from the [releases page](link-to-releases).
2. Ensure that the libfido2 library is installed and accessible from your system.

### Usage

You can use the FIDO2 Token Management Tool by either running the `fido2-manage.ps1` script directly with PowerShell or compiling it to an executable using ps2exe.

#### Running with PowerShell

To run the tool with PowerShell, open a PowerShell prompt and execute the script with the desired options. For example:

```powershell
.\fido2-manage.ps1 -l
