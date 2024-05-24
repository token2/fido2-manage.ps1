
param (
    [switch]$list,
    [switch]$info,
    [string]$device,
	[string]$pin,
    [switch]$storage,
    [switch]$residentKeys,
    [string]$domain,
    [switch]$delete,
    [string]$credential,
	[switch]$changePIN,
	[switch]$setPIN,
	[switch]$reset,
	[switch]$uvs,
	[switch]$uvd,
	[switch]$help
)


function Test-Administrator  
{  
    [OutputType([bool])]
    param()
    process {
        [Security.Principal.WindowsPrincipal]$user = [Security.Principal.WindowsIdentity]::GetCurrent();
        return $user.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator);
    }
}

if(-not (Test-Administrator))
{
    # TODO: define proper exit codes for the given errors 
    Write-Error "This tool  must be executed as Administrator.";
    exit 1;
}


# Function to display formatted messages
function Show-Message {
    param(
        [string]$message,
        [string]$type = "Info"
    )

    Write-Host -ForegroundColor Yellow "[$type] $message"
}

function Show-Help {
    Write-Output "FIDO2 Token Management Tool"
	Write-Output "v 0.2.2"
	Write-Output "This is a wrapper for libfido2 library"
	Write-Output " "
	Write-Output "(c) Token2 Sarl"
	Write-Output " "
    Write-Output "Usage: .\fido2-manage.exe [-list] [-info -device <number>] [-storage -device <number>] [-residentKeys -device <number> -domain <domain>] [-uvs] [-uvd] [-delete -device <number> -credential <credential>] [-help]"
    Write-Output ""
    Write-Output "Examples:"
    Write-Output "- List available devices:"
    Write-Output "  .\fido2-manage.exe -list"
    Write-Output ""
    Write-Output "- Retrieve information about a specific device:"
    Write-Output "  .\fido2-manage.exe -info -device 1 or just .\fido2-manage.exe  -device 1"
    Write-Output ""
    Write-Output "- Retrieve storage data for credentials (number of resident keys stored and available) on a specific device:"
    Write-Output "  .\fido2-manage.exe -storage -device 2"
    Write-Output ""
    Write-Output "- Retrieve resident keys on a specific device for a domain:"
    Write-Output "  .\fido2-manage.exe -residentKeys -device 1 -domain login.microsoft.com"
    Write-Output ""
	    Write-Output ""
    Write-Output "- Enforce user verification to be always requested on a specific device:"
    Write-Output "  .\fido2-manage.exe -uvs -device 1"
    Write-Output ""
		    Write-Output ""
    Write-Output "- Disable enforcing user verification to be always requested on a specific device:"
    Write-Output "  .\fido2-manage.exe -uvd -device 1"
    Write-Output ""
    Write-Output "- Sets PIN of  a specific device:"
    Write-Output "  .\fido2-manage.exe -setPIN -device 1"
	  Write-Output ""
    Write-Output "- Perform a factory reset on a specific device:"
    Write-Output "  .\fido2-manage.exe -reset -device 1"
     
    Write-Output ""
    Write-Output "- Change PIN of  a specific device:"
    Write-Output "  .\fido2-manage.exe -changePIN -device 1"
     
    Write-Output ""
    Write-Output "- Delete a credential on a specific device:"
    Write-Output "  .\fido2-manage.exe -delete -device 2 -credential Y+Dh/tSy/Q2IdZt6PW/G1A=="
    Write-Output ""
    Write-Output "- Display script help information:"
    Write-Output "  .\fido2-manage.exe -help"
}



# Display help if -help parameter is provided
if ($help) {
    Show-Help
    return
}



# Check if $pin is set
if ($pin -ne $null -and $pin -ne "") {
    # Add -w $pin to the command
    $pincom= " -w '$pin'"
}



# Check if no arguments are specified, then show help
if (-not $list -and -not $info -and -not $device -and -not $storage -and -not $residentKeys -and -not $domain -and -not $delete -and -not $credential -and -not $changePIN -and -not $setPIN -and -not $reset -and -not $uvs -and -not $uvd -and -not $help) {
    Show-Help
    exit
}

# Change PIN logic
# Change PIN logic


# Main script logic
if ($list) {
    try {
        # Run the command and capture the output
		#$commandOutput = Start-Process -FilePath .\t2f2.dll -Argumentlist "-L"  -Wait -NoNewWindow
        $commandOutput = .\libfido2-ui.exe -L
        #Show-Message "Raw Output of t2f2.exe -L:"
        
        # Iterate through each line of the output
        $orderNumber = 1
        foreach ($line in $commandOutput) {
			
			$match = [regex]::Match($line, '\((.*?)\)')
			
            Write-Output "Device [$orderNumber] :  $match  "
            $orderNumber++
        }
		Write-Output ""
		 #Show-Message "This is the list of the detected FIDO2 keys. Use device number to select the key you need. I.e. '.\fido2-manage.exe -device 1 -info ' will output info of the first device. The command  '.\fido2-manage.exe -device 1 -residentkeys ' will list the relying parties stored."
    } catch {
        Show-Message "Error executing t2f2.exe -L: $_" -type "Error"
    }
}

if ($device) {
    try {
        if (-not $commandOutput) {
            # Run the command and capture the output only if not already done
            $commandOutput = .\libfido2-ui.exe -L
			
        }
 
        # Ensure $device is within the valid range
        $deviceIndex = [int]$device - 1
        if ($deviceIndex -ge 0 -and $deviceIndex -lt $commandOutput.Count) {
            # Get the full line from the output corresponding to the specified device
            $deviceString = $commandOutput[$deviceIndex]
			#if ($deviceString -like "pcsc://slot0:*") { 			$deviceString = "pcsc://slot0"			}
            # Remove everything after the last }
			 
			if ($deviceString -like "pcsc://slot0:*") 
			{ 			$deviceString = "pcsc://slot0"			}
			else {
            $deviceString = $deviceString.Substring(0, $deviceString.LastIndexOf('}') + 1)
	}
			
			


if ($reset -and $device) {
    # Show a warning message
    Show-Message "WARNING: Factory reset will remove all data and settings of the device, including its PIN, fingerprints, and passkeys stored. The factory reset process is irreversible. Are you sure you want to proceed? (Y/N)"
    $confirmation = Read-Host

    if ($confirmation -eq 'Y' -or $confirmation -eq 'y') {
        try {
            # Run the command to delete the credential and capture the output
			
			Show-Message "Touch or press the security key button when it starts blinking."
			
            $output = .\libfido2-ui.exe  -R $deviceString 2>&1
			  
            # Check if the output contains FIDO_ERR_NOT_ALLOWED
            if ($output -match 'FIDO_ERR_NOT_ALLOWED') {
                Show-Message "Error: Factory reset not allowed.Factory reset is only allowed within 10 seconds of powering up of the security key. Please unplug and plug the device back in and retry within 10 seconds after plugging in."
            } else {
                Show-Message "Factory reset completed."
            }

            Write-Output ""
            Exit
        } catch {
            Show-Message "Error executing libfido2-ui.exe -R ${deviceString}: $_" -type "Error"
        }
    } else {
        Show-Message "Deletion canceled."
		Exit
    }
}



if ($changePIN -and $device) {
    try {
        Show-Message "Enter the old and new PIN below."
		Write-Output ""
		# Run the command to change the PIN
        .\libfido2-ui.exe -C $deviceString
		Read-Host -Prompt "Close this window to proceed further"
        Exit 
    } catch {
        Show-Message "Error executing libfido2-ui.exe -C $device : $_" -type "Error"
    }
}

if ($uvs -and $device) {
	
	 
    try {
        Show-Message "Enforcing user verification."
		Write-Output ""
		# Run the command to change the PIN
        .\libfido2-ui.exe -Su $deviceString
        Exit 
    } catch {
        Show-Message "Error executing libfido2-ui.exe -Su $device : $_" -type "Error"
    }
	
	}
	
if ($uvd -and $device) {
    try {
        Show-Message "Disabling user verification."
		Write-Output ""
		# Run the command to change the PIN
        .\libfido2-ui.exe -Du $deviceString
        Exit 
    } catch {
        Show-Message "Error executing libfido2-ui.exe -Du $device : $_" -type "Error"
    }
	
	}
	
	
 

if ($setPIN -and $device) {
    try {
        Show-Message "Enter and confirm the PIN as prompted below."
		Write-Output ""
		# Run the command to change the PIN
        .\libfido2-ui.exe -S $deviceString
	Read-Host -Prompt "Close this window to proceed further"
        Exit
    } catch {
        Show-Message "Error executing libfido2-ui.exe -S $device : $_" -type "Error"
    }
}






			if ($delete -and $credential -and $device) {
    # Show a warning message
    Show-Message "WARNING: Deleting a credential is irreversible. Are you sure you want to proceed? (Y/N)"
    $confirmation = Read-Host

    if ($confirmation -eq 'Y' -or $confirmation -eq 'y') {
        try {
            # Run the command to delete the credential
            .\libfido2-ui.exe -D -i $credential $deviceString
            Show-Message "Credential deleted successfully."
			Write-Output ""
			Exit
        } catch {
            Show-Message "Error executing libfido2-ui.exe -D -i ${credential} ${deviceString}: $_" -type "Error"
        }
    } else {
        Show-Message "Deletion canceled."
    }
}



            if ($storage) {
                # Run the command to retrieve storage for credentials
				$storageCommand=".\libfido2-ui.exe $pincom -I -c '$deviceString'"
                try {
					
					Invoke-Expression $storageCommand
                } catch {
                    Show-Message "Error executing t2f2.exe -I -c ${deviceString}: $_" -type "Error"
                }
            } elseif ($residentKeys) {
				
				 
                # Run the command to retrieve resident keys
                if ($domain) {
                    try {
						
						#Show resident keys
				 #Show-Message "This will show the list of resident keys (aka passkeys) for $domain. PIN is needed to continue"
				 Write-Output ""
                        # Run the command to list individual accounts for a domain
						$domCommand =".\libfido2-ui.exe $pincom -L -k $domain '$deviceString'"
						
                        $domainOutput = Invoke-Expression $domCommand

                        # Split the output into lines and process each line
                        $domainOutput -split "`r?`n" | ForEach-Object {
                            if ($_ -match '(\d+): (\S+) (.+)') {
                                $keyID = $Matches[1]
                                $credentialID = $Matches[2]
                                $details = $Matches[3]

                                # Extract user information from the details
                                if ($details -match '(\S+\s+\S+).+ es256') {
                                    $user = $Matches[1].Trim()
                                } else {
                                    $user = ""
                                }

                                Show-Message "Credential ID: $credentialID, User: $user"
                            }
							
			
							
                        }
						
									Write-Output ""
			if ($credentialID){						
			 
			}
						
                    } catch {
                        Show-Message "Error executing t2f2.exe -L -k ${domain} ${deviceString}: $_" -type "Error"
                    }
                } else {
					
					#Show domains
				
				 # Show-Message "This will show the list of domains (aka relying parties) present on this FIDO2 key. PIN is needed to continue."
				Write-Output ""
				
                    try {
						
                        $listRK =".\libfido2-ui.exe $pincom -L -r '$deviceString'"
						Invoke-Expression $listRK
                        Write-Output ""
						 
                        #Show-Message "To view individual accounts, run this command with -domain parameter (for example,  '.\fido2-manage.exe -info -device $device -residentkeys  -domain login.microsoft.com ') "
                    } catch {
                        Show-Message "Error executing t2f2.exe -L -r ${deviceString}: $_" -type "Error"
                    }
                }
            } else {
                # Run the command and capture the output for the specified device
                try {
                    $commandOutput2 = .\libfido2-ui.exe -I $deviceString
                    # Display the output for the specified device
                    Show-Message "Device $device Information:"
                    foreach ($line in $commandOutput2) {
                        Write-Output $line
                    }
                } catch {
                    Show-Message "Error executing t2f2.exe -I ${deviceString}: $_" -type "Error"
                }
            }
        } else {
            Show-Message "Invalid device number: $device" -type "Error"
        }
    } catch {
        Show-Message "Error processing device information. Is device plugged in? Error description : $_" -type "Error"
    }
	

}


