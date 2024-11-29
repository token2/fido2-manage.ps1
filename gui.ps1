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
    Write-Error "This script must be executed as Administrator.";
    exit 1;
}



 
# Global variables
$global:storedPINCode = $null
$global:storedDeviceNumber = $null
Add-Type -AssemblyName System.Windows.Forms
# Function to show an input box
function Set-DataGridViewColumnWidths {
    param (
        [System.Windows.Forms.DataGridView]$dataGridView
    )

   $dataGridView.Columns | Foreach-Object{
    $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
}
	
}

# Example usage:
# Set-DataGridViewColumnWidths -dataGridView $yourDataGridView

 function Show-InputBox {
    param(
        [string]$prompt,
        [string]$title
    )

    # Create a form
    $inputForm = New-Object System.Windows.Forms.Form
    $inputForm.Text = $title
    $inputForm.Size = New-Object System.Drawing.Size(300, 180)
    $inputForm.StartPosition = "CenterParent"  # Set the StartPosition to CenterParent

    # Create a label
    $label = New-Object System.Windows.Forms.Label
    $label.Text = $prompt
    $label.Location = New-Object System.Drawing.Point(5, 20)
	$label.size = New-Object System.Drawing.Size(250, 50)
    $inputForm.Controls.Add($label)

    # Create a password text box
    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.PasswordChar = '*'  # Set the password character
    $textBox.UseSystemPasswordChar = $true  # Use the system password character
    $textBox.Location = New-Object System.Drawing.Point(20, 70)
    $inputForm.Controls.Add($textBox)

    # Create an OK button
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Text = "OK"
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $okButton.Location = New-Object System.Drawing.Point(20, 100)
    $inputForm.Controls.Add($okButton)

    # Create an event handler for Enter key press
    $inputForm.KeyPreview = $true
    $inputForm.Add_KeyDown({
        param($sender, $e)
        if ($e.KeyCode -eq 'Enter') {
            $inputForm.DialogResult = [System.Windows.Forms.DialogResult]::OK
            $inputForm.Close()
        }
    })






    # Show the form
	 
    $result = $inputForm.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        
		$global:storedPINCode = $textBox.Text
		
		return $textBox.Text
		
		
    }

    return $null
}


function RefreshButton_Click {
    # Implement the action you want to perform on refresh button click
    # For example, you might want to refresh the list of devices

    # Clear existing data
    $dataGrid.DataSource = $null
    $devicesDropdown.SelectedIndex = -1
    $devicesDropdown.Items.Clear()

    # Get the FIDO2 devices
    $devices = Get-FIDO2Devices

    # Add devices to the dropdown
    $devicesDropdown.Items.AddRange($devices)
	
	
	$statusLabel.Text = "status: ☑ ready"
}


function Get-Passkeys {
    
 # Debugging: Display the current values of global variables
       # Write-Host "Stored PIN Code: $global:storedPINCode"
       # Write-Host "Stored Device Number: $global:storedDeviceNumber"
    
        # Execute the fido2-manage.exe command with additional options (-residentKeys)
        $fido2ManageCommand = ".\fido2-manage.exe"
        $arguments = "-residentKeys", "-device", $global:storedDeviceNumber, "-pin", $global:storedPINCode
        $commandOutputResidentKeys = & $fido2ManageCommand $arguments

       # Write-Host "fido2-manage.exe Command Output (ResidentKeys):"
		#  Write-Host "Executing command: $fido2ManageCommand $arguments"

       # Write-Host $commandOutputResidentKeys
		
		# Parse the output to treat each line as a separate item
        $parsedOutput = $commandOutputResidentKeys -split "`n"
		
        # Open a new form to display the DataGridView
        Show-PasskeysForm -parsedOutput $parsedOutput
 
		
		
	}	

# Function to show the Passkeys form with DataGridView
function Show-PasskeysForm {
    param (
        [array]$parsedOutput
    )
# Debugging: Display the count of items in the array
     
	 $form.Text = "FIDO2.1 Manager 1.2.6"
	 $statusLabel.Text = "status: ⌛ loading"
	 
	 
	 
    # Create a new form
    $passkeysForm = New-Object Windows.Forms.Form
    $passkeysForm.Text = "Passkeys"
    $passkeysForm.Size = New-Object Drawing.Size(600, 400)
    $passkeysForm.StartPosition = "CenterParent"
    # Create a DataGridView control
    $dataGridView = New-Object Windows.Forms.DataGridView
    $dataGridView.Location = New-Object Drawing.Point(20, 20)
    $dataGridView.Size = New-Object Drawing.Size(550, 300)
    $passkeysForm.Controls.Add($dataGridView)

    # Create a DataTable to hold the data
    $dataTable = New-Object System.Data.DataTable

  # Add columns for Credential ID and User
    $columns = "ID", "Domain", "User"
    $columns | ForEach-Object {
        $column = New-Object System.Data.DataColumn($_)
		 
		
        $dataTable.Columns.Add($column)
		
    }
	
	
	
    # Add rows to the DataTable (filtering lines with values more than 10 characters)
     $parsedOutput | Where-Object { $_.Length -gt 10 } | ForEach-Object {
        $row = $dataTable.NewRow()

        # Split the line based on space
        $parts = $_ -split ' '

        # Set Domain value (last part)
        
		$domainI = $parts[-1]
        
		 # Execute the command to get resident keys
        $residentKeysCommand = ".\fido2-manage.exe -residentKeys -device $global:storedDeviceNumber -domain $domainI -pin '$global:storedPINCode'"
        $residentKeysOutput = Invoke-Expression $residentKeysCommand

		#Write-Host $residentKeysOutput
$residentKeysOutput -split "`r`n" | ForEach-Object {
    $row = $dataTable.NewRow()

    # Match the "Credential ID" and "User" values using regex
    $match = $_ -match 'Credential ID: (.+), User: (.+)'

    if ($match  ) {
        # Set Credential ID, User, and Domain values
		 $row["Domain"] = $domainI
        $row["ID"] = $matches[1].Trim()
       #$row["User"] = ($matches[2] -split ' ', 2)[0].Trim()
	   $row["User"] = $matches[2].Trim()

        if ($row["ID"].Length -gt 5) {
            $dataTable.Rows.Add($row)
        }
    }
}


		
    }

    # Set the DataGridView DataSource to the DataTable
    $dataGridView.DataSource = $dataTable
    Set-DataGridViewColumnWidths($dataGridView)
 
    # Show the form
	
	#$form.Text = "FIDO2.1 Manager 1.2"
	$statusLabel.Text = "status: ☑ ready"
	
	# Create a button for the double-click action
    $buttonDoubleClick = New-Object System.Windows.Forms.Button
    $buttonDoubleClick.Text = "Delete"
    $buttonDoubleClick.Location = New-Object System.Drawing.Point(10, 330)
	 # Add a click event to the button
    $buttonDoubleClick.Add_Click({
        # Get the selected Credential ID
    $selectedCredentialID = $dataGridView.SelectedCells[0].Value
	$passkeysForm.Close()
$passkeysForm.Dispose()
    # Delete the passkey
    # Execute the fido2-manage.exe command to delete the credential in a new console window
    $deleteCommand = ".\fido2-manage.exe -delete -credential $selectedCredentialID -pin $global:storedPINCode -device $global:storedDeviceNumber "
    # Write-Host $deleteCommand
	# Start a new CMD process to execute the deletion 
    # Start CMD process
$process = Start-Process "cmd.exe" -ArgumentList "/c $deleteCommand" -PassThru

# Wait for the CMD process to exit
$process.WaitForExit()

# Now you can run Get-Passkeys or any other code you want to execute after CMD is closed
Get-Passkeys
	
	
    }
	
	
	)
	   $passkeysForm.Controls.Add($buttonDoubleClick)
	   
    $passkeysForm.ShowDialog()
}


# Function to show the ResidentKeys form with DataGridView
function Show-ResidentKeysForm {
    param (
        [string]$residentKeysOutput
    )

    # Create a new form
    $residentKeysForm = New-Object Windows.Forms.Form
    $residentKeysForm.Text = "Resident Keys"
    $residentKeysForm.Size = New-Object Drawing.Size(600, 400)

    # Create a DataGridView control
    $dataGridView = New-Object Windows.Forms.DataGridView
    $dataGridView.Location = New-Object Drawing.Point(20, 20)
    $dataGridView.Size = New-Object Drawing.Size(600, 300)
    $residentKeysForm.Controls.Add($dataGridView)

    # Create a DataTable to hold the data
    $dataTable = New-Object System.Data.DataTable

    # Add a column for the Resident Keys
    

    # Add columns for Credential ID and User
    $columns = "ID", "User"
    $columns | ForEach-Object {
        $column = New-Object System.Data.DataColumn($_)
        $dataTable.Columns.Add($column)
    }

   # Parse the ResidentKeysOutput and add rows to the DataTable
$residentKeysOutput -split "`r`n" | ForEach-Object {
    $row = $dataTable.NewRow()

    # Match the "Credential ID" and "User" values using regex
    $match = $_ -match 'Credential ID: (.+), User: (.+)'

    if ($match) {
        # Set Credential ID and User values
        $row["ID"] = $matches[1].Trim()
        $row["User"] = $matches[2].Trim()

        $dataTable.Rows.Add($row)
    }
}

# Set the DataGridView DataSource to the DataTable
$dataGridView.DataSource = $dataTable
$dataGridView.Columns | ForEach-Object {
    $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
}

Set-DataGridViewColumnWidths($dataGridView)

 

# Create a button for the delete action
    $buttonDeleteCredential = New-Object System.Windows.Forms.Button
    $buttonDeleteCredential.Text = "Delete"
    $buttonDeleteCredential.Location = New-Object System.Drawing.Point(10, 330)
	# Create the label with the specified text
$labelDeleteInstruction = New-Object System.Windows.Forms.Label
$labelDeleteInstruction.Text = "Select first column to delete"
$labelDeleteInstruction.AutoSize = $true
# Position the label to the right of the button
$labelDeleteInstruction.Location = New-Object System.Drawing.Point(($buttonDeleteCredential.Location.X + $buttonDeleteCredential.Width + 10), 330)
	 $buttonDeleteCredential.Add_Click({
	# Get the selected credential ID
    $selectedRowIndex = $dataGridView.SelectedCells[0].RowIndex
    $selectedCredentialID = $dataGridView.Rows[$selectedRowIndex].Cells["ID"].Value

    # Show the Credential ID in a MessageBox
    [System.Windows.Forms.MessageBox]::Show("Selected Credential ID: $selectedCredentialID", "Credential ID")
	
	# Execute the fido2-manage.exe command to delete the credential in a new console window
    $deleteCommand = ".\fido2-manage.exe -delete -device $global:storedDeviceNumber -credential $selectedCredentialID -pin $global:storedPINCode"
    #Write-Host $deleteCommand
	# Start a new CMD process to execute the deletion command
    Start-Process "cmd.exe" -ArgumentList "/c $deleteCommand"
	# Close the current form after CMD command execution
    $residentKeysForm.Close()
	$passkeysForm.Close()
	  # Refresh the passkeys form
    Show-PasskeysForm $selectedDevice $global:storedPINCode
	
})
	 
		 
     $residentKeysForm.Controls.Add($buttonDeleteCredential)
	 
	$residentKeysForm.Controls.Add($labelDeleteInstruction)
    # Show the form
    $residentKeysForm.ShowDialog()
}
# Function to execute the fido2-manage.exe command and parse the results
function Get-FIDO2Devices {
    # Capture command output and clean up extra spaces
    $commandOutput = & ".\fido2-manage.exe" -list 2>&1
    $commandOutput = $commandOutput | ForEach-Object { $_.Trim() }
    
  

    # Simplified filtering to capture any line with "Device"
    $devices = $commandOutput | Where-Object { $_ -match "Device" }
    #Write-Host "Filtered Devices (simplified):"
 

    # Apply more specific regular expression replacement
    $devices = $devices | ForEach-Object {
      #  Write-Host "Before Replacement: $_"
        $replaced = $_ -replace "Device \[(\d+)\] : (.+)", '$1 - $2'
      #  Write-Host "After Replacement: $replaced"
        $replaced
    }
 

    return $devices
}

# Main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "FIDO2.1 Manager 1.2.5"

$form.Size = New-Object System.Drawing.Size(650, 380)
 
$form.minimumSize = New-Object System.Drawing.Size(650, 380)
$form.maximumSize = New-Object System.Drawing.Size(650, 380)


 
 

# List of devices
$devicesLabel = New-Object System.Windows.Forms.Label
$devicesLabel.Text = "List of Devices:"
$devicesLabel.Location = New-Object System.Drawing.Point(20, 14)
$form.Controls.Add($devicesLabel)

# List of devices
$infoLabel = New-Object System.Windows.Forms.Label
$infoLabel.Width = 400  # Set the desired width
$CopyFont = [System.Drawing.Font]::new('Segoe UI', 8, [System.Drawing.FontStyle]::Italic)
$infoLabel.Font= $CopyFont
$infoLabel.Text = "GUI for FIDO2.1 Security key management tool (c) Token2 Sàrl , Switzerland "
$infoLabel.Location = New-Object System.Drawing.Point(10, 320)
$form.Controls.Add($infoLabel)



# Data
$dataLabel = New-Object System.Windows.Forms.Label
$dataLabel.Text = "Device info:"
$dataLabel.Location = New-Object System.Drawing.Point(20, 87)
$form.Controls.Add($dataLabel)

 


# Function to show relying parties form (placeholder for now)
function Show-RelyingPartiesForm {
    param($selectedDevice)


# Loading - Wait

$statusLabel.Text = "status: ⌛ loading"


    $deviceNumber = $selectedDevice -replace '.*\[(\d+)\].*', '$1'
$global:storedDeviceNumber = $deviceNumber
    do {
        # Ask for a PIN code using the input box function
        $pinCode = Show-InputBox -prompt "Enter PIN Code:`r`n[enter 0000 if no PIN is set for this key]. For biometric keys, fingerprint may also be required." -title "PIN Code"
        
        if ($pinCode -eq $null) {
            # User canceled input, exit the loop
            return
        }

        if ($pinCode -eq "") {
            [System.Windows.Forms.MessageBox]::Show("PIN Code cannot be empty. Please enter a valid PIN.", "Invalid PIN", 0)
			
			
        }
    } while ($pinCode -eq "")

    # Implement logic to show the next form or perform the next action with $deviceNumber and $pinCode
    #Write-Host "Selected Device Number: $deviceNumber"
    
$dataGrid.DataSource = $null






	# Execute the fido2-manage.exe command with additional options
$fido2ManageCommand = ".\fido2-manage.exe"
$arguments =  "-info", "-pin", $pinCode, "-device", $deviceNumber
Write-Host 
$commandOutput = & $fido2ManageCommand $arguments 2>&1
 







 
 # Construct the arguments
$arguments = "-storage", "-pin", "`"$pinCode`"", "-device", $deviceNumber

 

# Execute the command
$commandOutputStorage = & $fido2ManageCommand $arguments 2>&1
	
 ##Check if UV is Supported
  
 

 
 
 
 ## ENd check UV
	
  # Add a new row to the DataTable (replace with actual data)
  $dataTable = New-Object System.Data.DataTable
  # Add columns to the DataTable
$dataTable.Columns.Add("Property")
$dataTable.Columns.Add("Value")
$changePINButton.Enabled = $false 
$setPINButton.Enabled = $false
	#Write-Host $commandOutputStorage
		# Check if key or value contains FIDO_ERR_PIN_REQUIRED
   if ($commandOutputStorage -match "FIDO_ERR_PIN_REQUIRED") {
    [System.Windows.Forms.MessageBox]::Show("This security key does not have a PIN set. This is a requirement to be able to manage this device. Click on 'Set PIN' to set a PIN for this key. ", "PIN Required", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
   $setPINButton.Enabled = $true
   $changePINButton.Enabled = $false 
   $form.Text = "FIDO2.1 Manager 1.2.5"
   $statusLabel.Text = "status: ☑ ready"
   return
}
		
		 if ($commandOutputStorage -match "FIDO_ERR_PIN_INVALID") {
			
			 [System.Windows.Forms.MessageBox]::Show("Invalid PIN was provided", "Wrong PIN", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
			 
			   $devicesDropdown.SelectedIndex = -1
        Get-FIDO2Devices
		$form.Text = "FIDO2.1 Manager 1.2.5"
		$statusLabel.Text = "status: ☑ ready"
	return
			}


 
 
 
if ( $commandOutputStorage -match "FIDO_ERR_INVALID_CBOR") {  

$mergedOutput = $commandOutput # You can replace "Default value" with whatever is appropriate
   
} else {
	 
    
	
	 $mergedOutput = $commandOutputStorage + "`n" + $commandOutput
	 
}
		
  

$parsedOutput = @{}

$relyingPartiesButton.Enabled = $false
$fingerprintsButton.Enabled = $false
$resetButton.Enabled = $false
		
	
		
		
    foreach ($line in $mergedOutput -split "`n") {
        $lineParts = $line -split ":", 2
		
		if ($line -match '\[Info\]') {
            continue
        }
		
        if ($lineParts.Count -eq 2) {
            $key = $lineParts[0].Trim()
            $value = $lineParts[1].Trim()
            $parsedOutput[$key] = $value
			
			if ($key -eq "sensor type") {
				
				$fingerprintsButton.Enabled = $true
			}
		
			if ($key -eq "existing rk(s)") {
                    $key = "used passkey slots"
					$relyingPartiesButton.Enabled = $true
					$resetButton.Enabled = $true
					$changePINButton.Enabled = $true 
					$setUVButton.Enabled = $true
					$usedSlots = [int]$value
                }
                elseif ($key -eq "remaining rk(s)") {
                    $key = "free passkey slots"
					 $freeSlots = [int]$value
                }
			
			 $newRow = $dataTable.NewRow()
    $newRow["Property"] = $key
    $newRow["Value"] = $value
    $dataTable.Rows.Add($newRow)
	
	  if ($key -eq "free passkey slots") {
	# Calculate total slots and add as a separate entry
$totalSlots = $usedSlots + $freeSlots
$newRow = $dataTable.NewRow()
$newRow["Property"] = "total passkey slots"
$newRow["Value"] = $totalSlots.ToString()
$dataTable.Rows.Add($newRow)



	 }
		
	
        }
    }
	
 #If Data is empty allow setting PIN
 
 
	if ($usedSlots -eq 0) {
 
	$relyingPartiesButton.Enabled = $false
}
	 
   

    $dataGrid.DataSource = $dataTable
	
	$dataGrid.Columns | Foreach-Object{
    $_.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
}

Set-DataGridViewColumnWidths( $dataGrid)
#Loaded

$form.Text = "FIDO2.1 Manager 1.2.5"
$statusLabel.Text = "status: ☑ ready"
}


# DataGrid
$dataGrid = New-Object System.Windows.Forms.DataGridView
$dataGrid.Location = New-Object System.Drawing.Point(20, 110)
$dataGrid.Size = New-Object System.Drawing.Size(600, 150)
$dataGrid.AllowUserToAddRows = $false  # Optional: Disable the ability to add new rows

 # Button for relying parties
 $ClickedFont = [System.Drawing.Font]::new('Segoe UI', 10, [System.Drawing.FontStyle]::Bold)
    $relyingPartiesButton = New-Object System.Windows.Forms.Button
    $relyingPartiesButton.Text = "show passkeys"
	
    $relyingPartiesButton.Width = 120
	 $relyingPartiesButton.Font =  $ClickedFont
    $relyingPartiesButton.Location = New-Object System.Drawing.Point(20, 280)
    $relyingPartiesButton.Enabled = $false;
    $relyingPartiesButton.Add_Click({
      
        Get-Passkeys
    })
    $form.Controls.Add($relyingPartiesButton)
# Button for reset
$resetButton = New-Object System.Windows.Forms.Button
$resetButton.Text = "Reset"
$resetButton.ForeColor = [System.Drawing.Color]::Red
$resetButton.Enabled = $false;
$resetButton.Location = New-Object System.Drawing.Point(540, 280)
$resetButton.Add_Click({
    # Ask for user confirmation
    $confirmation = [System.Windows.Forms.MessageBox]::Show("Please unplug your key and plug it back before continuing. You can reset the key only within 10 seconds after it was plugged. Also note that this operation will delete all data, including passkeys and PIN. Click on Yes to continue. ", "Confirmation", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Warning)

    if ($confirmation -eq [System.Windows.Forms.DialogResult]::Yes) {
        # Implement the action to launch .\fido2-manage.exe -reset -device ...
        $resetCommand = ".\fido2-manage.exe -reset -device $global:storedDeviceNumber"
		#Write-Host $resetCommand
        $dataGrid.DataSource = $null

        # Execute the reset command
        Start-Process "cmd.exe" -ArgumentList "/c $resetCommand" -Wait

        # Refresh the FIDO2 devices
		 # Clear the selection in the ComboBox
        $devicesDropdown.SelectedIndex = -1
		$setPINButton.Enabled = $false
		$resetButton.Enabled = $false
		$setPINButton.Enabled = $false
		$relyingPartiesButton.Enabled = $false
		$changePINButton.Enabled = $false
		$dataGrid.DataSource = $null
        Get-FIDO2Devices
    }
})


# Create a button for changing PIN
$changePINButton = New-Object System.Windows.Forms.Button
$changePINButton.Text = "Change PIN"
$changePINButton.Location = New-Object System.Drawing.Point(320, 280)
$changePINButton.Enabled = $false  # Disable the button by default
$changePINButton.Add_Click({
    # Implement the action you want to perform on Change PIN button click
    # For example, you might want to open a form to input the new PIN
    # Placeholder: Add your code here
	
	 # Implement the action to launch .\fido2-manage.exe -reset -device ...
        $resetCommand = ".\fido2-manage.exe -changePIN -device $global:storedDeviceNumber"
		#Write-Host $resetCommand
        $dataGrid.DataSource = $null

        # Execute the reset command
        Start-Process "cmd.exe" -ArgumentList "/c $resetCommand" -Wait

        # Refresh the FIDO2 devices
		 # Clear the selection in the ComboBox
        $devicesDropdown.SelectedIndex = -1
		$setPINButton.Enabled = $false
		$resetButton.Enabled = $false
		$setPINButton.Enabled = $false
		$relyingPartiesButton.Enabled = $false
		$changePINButton.Enabled = $false
        Get-FIDO2Devices
		
		
})

# Create the Set UV button
$setUVButton = New-Object System.Windows.Forms.Button
$setUVButton.Text = "Enforce UV"
$setUVButton.Location = New-Object System.Drawing.Point(420, 280)  # Position it next to the Change PIN button
$setUVButton.Enabled = $false  # Disable the button by default
$setUVButton.Add_Click({
    # Implement the action you want to perform on Set UV button click
    $setUVCommand = ".\fido2-manage.exe -uvs -device $global:storedDeviceNumber"
    Start-Process "cmd.exe" -ArgumentList "/c $setUVCommand" -Wait
    $devicesDropdown.SelectedIndex = -1
    $setPINButton.Enabled = $false
    $resetButton.Enabled = $false
    $setPINButton.Enabled = $false
    $relyingPartiesButton.Enabled = $false
    $changePINButton.Enabled = $false
    $setUVButton.Enabled = $false
    Get-FIDO2Devices
})

# Add the Change PIN button to the form
$form.Controls.Add($changePINButton)
$form.Controls.Add($setUVButton)

#Fingerprints

# Create the Fingerprints button
$fingerprintsButton = New-Object System.Windows.Forms.Button
$fingerprintsButton.Text = "fingerprints"
$fingerprintsButton.Location = New-Object System.Drawing.Point(150, 280)  # Position it below the Change PIN button

$fingerprintsButton.Enabled = $false;

#FP Window Start 
   
   $fingerprintsButton.Add_Click({
    # Create a new form for fingerprints
    $fingerprintsForm = New-Object System.Windows.Forms.Form
    $fingerprintsForm.Text = "Manage Fingerprints"
    $fingerprintsForm.Size = New-Object System.Drawing.Size(600, 400)
    $fingerprintsForm.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Sizable  # Make window resizable
    
    # Create a panel to hold the DataGridView and make it scrollable
    $panel = New-Object System.Windows.Forms.Panel
    $panel.Size = New-Object System.Drawing.Size(580, 280)
    $panel.Location = New-Object System.Drawing.Point(10, 10)
    $panel.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right
    $panel.AutoScroll = $true
    
    # Create a DataGridView to display the output
    $dataGridView = New-Object System.Windows.Forms.DataGridView
    $dataGridView.Size = New-Object System.Drawing.Size(560, 260)
    $dataGridView.Location = New-Object System.Drawing.Point(0, 0)
    $dataGridView.AutoSizeColumnsMode = [System.Windows.Forms.DataGridViewAutoSizeColumnsMode]::Fill
    $dataGridView.SelectionMode = [System.Windows.Forms.DataGridViewSelectionMode]::FullRowSelect
    $dataGridView.MultiSelect = $false
    
    # Execute the command and capture the output
    $fingerprintCommand = ".\fido2-manage.exe -fingerprintlist -device $global:storedDeviceNumber -pin  $global:storedPINCode "
	 
    $output = & cmd.exe /c $fingerprintCommand
    # Check if $output contains "FingerPrint0" (case-sensitive)
if ($output -Match "FingerPrint0") {
        
		
		
    }  else {
		
		
		[System.Windows.Forms.MessageBox]::Show("Wrong PIN provided or PIN was blocked after several attempts. PIN is needed to manage fingerprints. Replug and try again.  ")
		 $devicesDropdown.SelectedIndex = -1
		 $dataGrid.DataSource = $null
         
		
        return
		
		
	}
    # Split the output into lines
    $lines = $output -split "`r`n"
    $rows = $lines[0..($lines.Length - 2)]  # Remove the last line from the list
    
    # Add a single "Fingerprint" column to the DataGridView
    $col = New-Object System.Windows.Forms.DataGridViewTextBoxColumn
    $col.Name = "Fingerprint"
    $col.HeaderText = "Fingerprint"
    $dataGridView.Columns.Add($col)
    
    # Add rows to the DataGridView
    foreach ($row in $rows) {
        $dataGridView.Rows.Add($row)
    }
    
    # Add the DataGridView to the panel
    $panel.Controls.Add($dataGridView)
    
    # Create the "Delete Fingerprint" button
    $deleteButton = New-Object System.Windows.Forms.Button
    $deleteButton.Text = "Delete"
    $deleteButton.Location = New-Object System.Drawing.Point(10, 300)
    $deleteButton.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left
    $deleteButton.Add_Click({
        if ($dataGridView.SelectedRows.Count -gt 0) {
            $selectedRow = $dataGridView.SelectedRows[0]
            $fingerprint = $selectedRow.Cells["Fingerprint"].Value
            
            # Extract the identifier before the colon
            $identifier = ($fingerprint -split ":")[0].Trim()
            
            # Construct the delete command
            $deleteCommand = ".\fido2-manage.exe -deletefingerprint $identifier -device $global:storedDeviceNumber  "
            Start-Process "cmd.exe" -ArgumentList "/c $deleteCommand" -Wait
            
            # Close the fingerprint dialog
            $fingerprintsForm.Close()
        } else {
            [System.Windows.Forms.MessageBox]::Show("Please select a fingerprint to delete.")
        }
    })
    
    # Create the "Add Fingerprint" button
    $addButton = New-Object System.Windows.Forms.Button
    $addButton.Text = "Add"
    $addButton.Location = New-Object System.Drawing.Point(150, 300)
    $addButton.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left
    $addButton.Add_Click({
        # Implement the action to add a fingerprint
        $addCommand = ".\fido2-manage.exe -fingerprint  -device $global:storedDeviceNumber "
        Start-Process "cmd.exe" -ArgumentList "/c $addCommand" -Wait
        
        # Close the fingerprint dialog
        $fingerprintsForm.Close()
    })
    
    # Add the controls to the form
    $fingerprintsForm.Controls.Add($panel)
    $fingerprintsForm.Controls.Add($deleteButton)
    $fingerprintsForm.Controls.Add($addButton)
    

    # Show the new window
    $fingerprintsForm.ShowDialog()
})



#FP Window End

$form.Controls.Add($fingerprintsButton)

# Button for Set PIN
$setPINButton = New-Object System.Windows.Forms.Button
$setPINButton.Text = "Set PIN"
$setPINButton.Location = New-Object System.Drawing.Point(240, 280)
$setPINButton.Enabled = $false  # Disabled by default

# Add_Click event for Set PIN button
$setPINButton.Add_Click({
	
	   # Implement the action to launch .\fido2-manage.exe -reset -device ...
        $resetCommand = ".\fido2-manage.exe -device $global:storedDeviceNumber -setPIN"
		#Write-Host $resetCommand
        $dataGrid.DataSource = $null

        # Execute the reset command
        Start-Process "cmd.exe" -ArgumentList "/c $resetCommand" -Wait

        # Refresh the FIDO2 devices
		 # Clear the selection in the ComboBox
        $devicesDropdown.SelectedIndex = -1
        Get-FIDO2Devices
		$setPINButton.Enabled = $false
     
    
})


$form.Controls.Add($setPINButton)


$form.Controls.Add($resetButton)


$form.Controls.Add($dataGrid)
# Set up data bindings


# Create a Refresh button
$refreshButton = New-Object System.Windows.Forms.Button
$refreshButton.Text = "Refresh"
$refreshButton.Location = New-Object System.Drawing.Point(430, 38)
$form.Controls.Add($refreshButton)

# Add a click event to the Refresh button
$refreshButton.Add_Click({
    # Implement the action you want to perform on refresh button click
    # For example, you might want to refresh the list of devices
	$dataGrid.DataSource = $null
	$devicesDropdown.SelectedIndex = -1
$devicesDropdown.Items.Clear()
$devices = Get-FIDO2Devices
$devicesDropdown.Items.AddRange($devices)
   
})

 # List of devices
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = "status: ⌛ loading"
$statusLabel.Location = New-Object System.Drawing.Point(530, 320)
 
$form.Controls.Add($statusLabel)


$devicesDropdown = New-Object System.Windows.Forms.ComboBox
$devicesDropdown.Location = New-Object System.Drawing.Point(20, 40)
$devicesDropdown.Width = 400
$form.Controls.Add($devicesDropdown)

# Event handler for device selection
$devicesDropdown.Add_SelectedIndexChanged({
    $selectedDevice = $devicesDropdown.SelectedItem
    if ($selectedDevice) {
        # Call the next function or form to proceed with the selected device
        Show-RelyingPartiesForm $selectedDevice
    }
})

$form.Add_Shown({
    Start-Sleep -Seconds 2
    RefreshButton_Click
})
 
# Show the form
$form.ShowDialog()  | Out-Null
 
 
