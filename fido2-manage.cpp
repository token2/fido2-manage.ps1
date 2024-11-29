#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#define NOMINMAX // Prevents Windows from defining the max and min macros
#include <windows.h>
#include <stdexcept>
#include <regex>
#include <algorithm>
#include <cctype>

// Convert a string to lowercase
std::string ToLower(const std::string& str) {
    std::string lowerStr = str;
    std::transform(lowerStr.begin(), lowerStr.end(), lowerStr.begin(), [](unsigned char c) {
        return std::tolower(c);
        });
    return lowerStr;
}

// Helper function to execute commands and capture output
std::string ExecuteCommand(const std::string& command) {
    char buffer[128];
    std::string result;
    FILE* pipe = _popen(command.c_str(), "r");
    if (!pipe) throw std::runtime_error("Failed to run command");
    while (fgets(buffer, sizeof(buffer), pipe) != nullptr) {
        result += buffer;
    }
    _pclose(pipe);
    return result;
}

// Display help information
void ShowHelp() {
    std::cout << "FIDO2 Token Management Tool (C++ version)\n";
    std::cout << "Usage: fido2_manage <operation> [-pin <PIN>] [-device <device_number>] [additional_args]\n";
    std::cout << "\nOperations:\n";
    std::cout << "  -list                     List all connected FIDO2 devices\n";
    std::cout << "  -info                     Retrieve detailed information about a specific device\n";
    std::cout << "  -storage                  Retrieve storage data for credentials on a device\n";
    std::cout << "  -residentkeys             List all relying parties with resident keys stored on the device\n";
    std::cout << "  -residentkeys -domain <domain>\n";
    std::cout << "                            Retrieve resident keys for accounts or relying parties in the specified domain\n";
    std::cout << "  -delete -credential <credential_id>\n";
    std::cout << "                            Delete a specific credential from the device\n";
    std::cout << "  -setpin                   Set or reset the PIN for the device (requires no existing PIN)\n";
    std::cout << "  -changepin                Change the PIN for the device\n";
    std::cout << "  -forcepinchange           Force a PIN change for the device\n";
    std::cout << "  -setminimumpin <length>   Set the minimum PIN length (must be between 4 and 63)\n";
    std::cout << "  -reset                    Perform a factory reset on the device\n";
    std::cout << "  -uvs                      Enable User Verification (UV) on the device\n";
    std::cout << "  -uvd                      Disable User Verification (UV) on the device\n";
    std::cout << "  -fingerprint              Enroll a fingerprint (requires 4 samples)\n";
    std::cout << "  -fingerprintlist          List all enrolled fingerprints on the device\n";
    std::cout << "  -deletefingerprint <id>   Delete a fingerprint by its ID\n";
    std::cout << "\nExamples:\n";
    std::cout << "  fido2_manage -list\n";
    std::cout << "  fido2_manage -info -device 1\n";
    std::cout << "  fido2_manage -residentkeys -device 1\n";
    std::cout << "  fido2_manage -residentkeys -domain example.com -device 1\n";
    std::cout << "  fido2_manage -delete -credential ABC123 -device 1\n";
    std::cout << "  fido2_manage -setminimumpin 8 -device 1 -pin 773456\n";
    std::cout << "  fido2_manage -deletefingerprint 5 -device 1 -pin 773456\n";
    std::cout << "\nNote:\n";
    std::cout << "  - All operations (except -list) require the -device parameter to specify the device index.\n";
    std::cout << "  - Some operations, like -delete and -setminimumpin, require additional arguments.\n";
    std::cout << "  - Always run this tool with administrative privileges.\n";
}


// Check if the program is running with administrative privileges
bool IsAdministrator() {
    BOOL isAdmin = FALSE;
    HANDLE token = nullptr;

    if (OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, &token)) {
        TOKEN_ELEVATION elevation;
        DWORD size;
        if (GetTokenInformation(token, TokenElevation, &elevation, sizeof(elevation), &size)) {
            isAdmin = elevation.TokenIsElevated;
        }
    }

    if (token) CloseHandle(token);

    return isAdmin;
}

std::vector<std::pair<std::string, std::string>> ParseDeviceList(const std::string& output) {
   // std::cout << "[DEBUG] Input data: " << output << std::endl;

    std::vector<std::pair<std::string, std::string>> devices;
    std::istringstream stream(output);
    std::string line;

    while (std::getline(stream, line)) {
       // std::cout << "[DEBUG] Line read: " << line << std::endl;

        size_t pos = line.find('}');
        std::regex re("\\((.*?)\\)"); // Regex to match the name inside parentheses
        std::smatch match;

        // Check if the line contains a user-friendly name
        if (std::regex_search(line, match, re)) {
           // std::cout << "[DEBUG] Found user-friendly name: " << match[1] << std::endl;

            std::string deviceString;

            // Check if the line contains a pcsc://slotX format
            if (line.find("pcsc://") != std::string::npos) {
                std::regex pcscRegex(R"(pcsc://slot\d)");
                std::smatch pcscMatch;
                if (std::regex_search(line, pcscMatch, pcscRegex)) {
                    deviceString = pcscMatch[0].str();
                  //  std::cout << "[DEBUG] Found pcsc://slotX device: " << deviceString << std::endl;
                }
                else {
                 //   std::cout << "[DEBUG] pcsc://slotX not matched in line: " << line << std::endl;
                }
            }
            else if (pos != std::string::npos) {
                deviceString = line.substr(0, pos + 1);
               // std::cout << "[DEBUG] Found device string ending with `}`: " << deviceString << std::endl;
            }
            else {
               // std::cout << "[DEBUG] No valid device string found in line: " << line << std::endl;
            }

            // Add to the result if a device string was extracted
            if (!deviceString.empty()) {
                devices.emplace_back(deviceString, match[1].str());
                //std::cout << "[DEBUG] Added device: " << deviceString << ", " << match[1] << std::endl;
            }
        }
        else {
           // std::cout << "[DEBUG] No user-friendly name found in line: " << line << std::endl;
        }
    }

    return devices;
}




// Helper function to validate and fetch the device
std::pair<std::string, std::string> GetSelectedDevice(int deviceIndex, const std::vector<std::pair<std::string, std::string>>& devices) {
    if (deviceIndex < 0 || deviceIndex >= devices.size()) {
        throw std::invalid_argument("Invalid device number.");
    }
    return devices[deviceIndex];
}

// Main function to handle commands
int main(int argc, char* argv[]) {
    if (argc < 2) {
        ShowHelp();
        return 1;
    }

    if (!IsAdministrator()) {
        std::cerr << "ERROR: This tool must be run with administrative privileges.\n";
        return 1;
    }

    SetConsoleOutputCP(CP_UTF8);
    std::ios::sync_with_stdio(false); // Disable synchronization for performance

    std::string operation = argv[1];
    std::string pin = "";
    std::string domain = ""; // Variable to store the domain argument
    int deviceIndex = -1;

    try {
        // Parse operation arguments
        for (int i = 2; i < argc; ++i) {
            if (std::string(argv[i]) == "-pin" && i + 1 < argc) {
                pin = argv[++i];
            }
            else if (std::string(argv[i]) == "-device" && i + 1 < argc) {
                deviceIndex = std::stoi(argv[++i]) - 1;
            }
            else if (std::string(argv[i]) == "-domain" && i + 1 < argc) {
                domain = argv[++i];
            }
        }

        if (deviceIndex == -1 && operation != "-list") {
            throw std::invalid_argument("Missing -device argument.");
        }

        // Fetch device list
        std::string output = ExecuteCommand(".\\libfido2-ui.exe -L");
         
        auto devices = ParseDeviceList(output);
        std::string quotedDevice = "";

        if (deviceIndex != -1) {
            auto selectedDevice = GetSelectedDevice(deviceIndex, devices);
            quotedDevice = "\"" + selectedDevice.first + "\"";
        }
        std::string pincom = pin.empty() ? "" : "-w " + pin + " ";

      
        // Operations
        if (ToLower(operation) == "-list") {
            if (devices.empty()) {
                std::cout << "No devices found.\n";
                return 0;
            }

            //std::cout << "Available Devices:\n";
            for (size_t i = 0; i < devices.size(); ++i) {
                std::cout << "Device [" << (i + 1) << "]: " << devices[i].second << "\n";
            }

             

            return 0;
        }

        if (ToLower(operation) == "-info") {
            std::string commandOutput = ExecuteCommand(".\\libfido2-ui.exe -I " + quotedDevice);
             std::cout << commandOutput;
            return 0;
        }

         
        if (ToLower(operation) == "-storage") {
            std::string commandOutput = ExecuteCommand(".\\libfido2-ui.exe " + pincom + " -I -c "  + quotedDevice);
            std::cout << commandOutput;
            return 0;
        }

        if (ToLower(operation) == "-residentkeys") {
            // Build the base command
            std::string command = ".\\libfido2-ui.exe " + pincom + " -L -r";
            if (!domain.empty()) {
                command += " -k " + domain;
            }
            command += " " + quotedDevice;

            // Debug output for the constructed command
            //std::cout << "Executing command: " << command << "\n";

            // Execute the command
            std::string commandOutput = ExecuteCommand(command);

            // Define a regex for matching email addresses
            std::regex emailRegex(R"(([\w\.-]+@[\w\.-]+\.\w+))"); // Match emails like user@example.com

            // Process and format the output
            std::istringstream stream(commandOutput);
            std::string line;

            while (std::getline(stream, line)) {
                std::istringstream lineStream(line);
                std::string index, credentialID, user, word;
                std::smatch match;

                // Extract the index and credential ID (first and second fields)
                lineStream >> index >> credentialID;

                // Look for an email in the line
                if (std::regex_search(line, match, emailRegex)) {
                    user = match.str(); // Use the matched email
                }
                else {
                    // If no email is found, fall back to the third column
                    int columnCount = 0;
                    while (lineStream >> word) {
                        ++columnCount;
                        if (columnCount == 1) { // Third column is the first one after index and credential ID
                            user = word;
                            break;
                        }
                    }
                }

                // Format and print the output
                if (!credentialID.empty() && !user.empty()) {
                    std::cout << "Credential ID: " << credentialID << ", User: " << user << "\n";
                }
            }
            return 0;
        }



        if (ToLower(operation) == "-delete") {
            // Check if -credential argument is provided
            std::string credential = "";
            for (int i = 2; i < argc; ++i) {
                if (std::string(argv[i]) == "-credential" && i + 1 < argc) {
                    credential = argv[++i];
                }
            }

            // Validate that credential was provided
            if (credential.empty()) {
                std::cerr << "ERROR: Missing -credential argument for -delete operation.\n";
                return 1;
            }

            // Build the command
            std::string command = ".\\libfido2-ui.exe " + pincom + " -D -i " + credential + " " + quotedDevice;

            // Confirmation prompt
            std::cout << "The following credential will be deleted:\n" << credential << "\n";
            std::cout << "Are you sure you want to execute this command? (yes/no): ";

            std::string userInput;
            std::getline(std::cin, userInput);

            // Check user response
            if (userInput == "yes" || userInput == "y") {
                // Debug output for the constructed command
               // std::cout << "Executing command: " << command << "\n";

                // Execute the command
                std::string commandOutput = ExecuteCommand(command);

                // Output the result
                std::cout << commandOutput;
            }
            else {
                std::cout << "Command execution canceled.\n";
            }

            return 0;
        }


        if (ToLower(operation) == "-uvs") {
            std::cout << "Enabling user verification always_uv option" << "\n";
            std::string commandOutput = ExecuteCommand(".\\libfido2-ui.exe -Su " + quotedDevice);
             
            return 0;
        }

        if (ToLower(operation) == "-uvd") {
            std::cout << "Disabling user verification always_uv option" << "\n";
            std::string commandOutput = ExecuteCommand(".\\libfido2-ui.exe -Du " + quotedDevice);
            
            return 0;
        }

        if (ToLower(operation) == "-changepin") {
            std::cout << "Changing PIN..." << "\n";

            // Execute the change PIN command
            std::string commandOutput = ExecuteCommand(".\\libfido2-ui.exe -C " + quotedDevice);

            // Check if the output contains "FIDO_ERR_PIN_NOT_SET"
            if (commandOutput.find("FIDO_ERR_PIN_NOT_SET") != std::string::npos) {
                std::cerr << "Error: This key does not have a PIN set. Use the -setpin command to set a new PIN.\n";
            }
            else {
                std::cout << commandOutput;
            }

            return 0;
        }


        if (ToLower(operation) == "-setpin") {
            std::cout << "Setting PIN (new or reset device only)" << "\n";
            std::string commandOutput = ExecuteCommand(".\\libfido2-ui.exe -S " + quotedDevice);

            return 0;
        }

        if (ToLower(operation) == "-reset") {
            std::cout << "Factory reset is only allowed within 10 seconds of powering up the security key. "
                << "Please unplug and plug the device back, then press any key. "
                << "When the device starts blinking, touch the sensor or button to complete the process.\n";
            std::cout << "Press any key to continue (when the device starts blinking, touch the sensor)...\n";

            // Wait for a key press
            std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');

            // Execute the reset command
            std::string commandOutput = ExecuteCommand(".\\libfido2-ui.exe -R " + quotedDevice);

            // Check if the output contains FIDO_ERR_NOT_ALLOWED
            if (commandOutput.find("FIDO_ERR_NOT_ALLOWED") != std::string::npos) {
                std::cerr << "Error: The factory reset was not completed within 10 seconds. Please unplug the device, "
                    << "plug it back in, and try again.\n";
            }
            else {
                std::cout << commandOutput;
            }

            return 0;
        }




        if (ToLower(operation) == "-forcepinchange") {
            std::string commandOutput = ExecuteCommand(".\\libfido2-ui.exe " + pincom + " -S -f " + quotedDevice);
            std::cout << commandOutput;
            return 0;
        }



        if (ToLower(operation) == "-setminimumpin") {
            int minPINLength = 0; // Default value
            bool foundSetMinPIN = false;
            std::string device = "";

            // Explicitly parse arguments
            for (int i = 1; i < argc; ++i) {
                std::string arg = ToLower(std::string(argv[i]));

                if (arg == "-setminimumpin") {
                    if (i + 1 < argc) {
                        try {
                            minPINLength = std::stoi(argv[++i]); // Parse the next argument as the minimum PIN length
                            foundSetMinPIN = true;
                        }
                        catch (const std::exception&) {
                            std::cerr << "Error: Invalid value for -setminimumpin. Must be an integer.\n";
                            return 1;
                        }
                    }
                    else {
                        std::cerr << "Error: Missing value for -setminimumpin.\n";
                        return 1;
                    }
                }
                else if (arg == "-device") {
                    if (i + 1 < argc) {
                        device = argv[++i]; // Capture device argument
                    }
                    else {
                        std::cerr << "Error: Missing value for -device.\n";
                        return 1;
                    }
                }
            }

            // Validate the minimum PIN length
            if (!foundSetMinPIN || minPINLength < 4 || minPINLength > 63) {
                std::cerr << "Error: Minimum PIN length must be between 4 and 63.\n";
                return 1;
            }

            // Construct the command
            std::cout << "Setting the minimum PIN length to " << minPINLength << "...\n";
            std::string commandOutput = ExecuteCommand(".\\libfido2-ui.exe " + pincom + " -S -l " + std::to_string(minPINLength) + " " + quotedDevice);

            std::cout << commandOutput;
            return 0;

             
        }



        if (ToLower(operation) == "-fingerprintlist") {
            std::cout << "List of enrolled fingerprints \n";

            std::string commandOutput = ExecuteCommand(".\\libfido2-ui.exe " + pincom + " -L -e " + quotedDevice);
            std::cout << commandOutput;

            std::cout <<  "\nTo delete a fingerprint record, use  -deletefingerprint [ID] , where [ID] is matches one of the fingerprint records shown above, i.e. fido2-manage.exe -deletefingerprint 1 -device 1";
            return 0;
        }


        if (ToLower(operation) == "-fingerprint") {

            std::cout << "Enrolling a fingerprint. The tool requires 4 samples of the same finger to complete the process. \n";


            std::string command = ".\\libfido2-ui.exe " + pincom + " -S -e " + quotedDevice;
             

            // Use system() to execute the command and display its output
            int result = system(command.c_str());

            // Check for execution errors
            if (result != 0) {
                std::cerr << "Error: Command execution failed with code " << result << "\n";
            }

            return result; // Return the result of the system command
        }


         

       

        if (ToLower(operation) == "-deletefingerprint") {
            std::string fingerprintIndexStr;
            int fingerprintIndex = -1;
            bool foundIndex = false;

            // Parse arguments for -deletefingerprint and its index
            for (int i = 1; i < argc; ++i) {
                std::string arg = ToLower(std::string(argv[i]));

                if (arg == "-deletefingerprint") {
                    if (i + 1 < argc) {
                        fingerprintIndexStr = argv[++i];
                        try {
                            fingerprintIndex = std::stoi(fingerprintIndexStr);
                            foundIndex = true;

                            if (fingerprintIndex < 0 || fingerprintIndex > 99) {
                                throw std::out_of_range("Index out of range");
                            }
                        }
                        catch (const std::exception&) {
                            std::cerr << "Error: Invalid index. Index must be an integer between 00 and 99.\n";
                            return 1;
                        }
                    }
                    else {
                        std::cerr << "Error: Missing value for -deletefingerprint.\n";
                        return 1;
                    }
                }
                
            }

            if (!foundIndex) {
                std::cerr << "Error: Missing index for -deletefingerprint operation.\n";
                return 1;
            }

            // Retrieve the fingerprint list
            std::string listCommand = ".\\libfido2-ui.exe " + pincom + "-L -e " + quotedDevice;
            
            std::string fingerlist = ExecuteCommand(listCommand);
             

            if (fingerlist.empty() || fingerlist.find("FIDO_ERR") != std::string::npos) {
                std::cerr << "Error: Failed to retrieve fingerprints. Check device connection and parameters.\n";
                return 1;
            }

            // Parse the fingerprint list
            std::vector<std::string> fingerprints(100, "");
            std::istringstream stream(fingerlist);
            std::string line;
            while (std::getline(stream, line)) {
                 
                size_t colonPos = line.find(":");
                size_t equalsPos = line.find("=");

                if (colonPos != std::string::npos && equalsPos != std::string::npos) {
                    int index = std::stoi(line.substr(0, colonPos));
                    std::string id = line.substr(colonPos + 2, equalsPos - colonPos - 2); // Extract the ID
                    if (index >= 0 && index < 100) {
                        fingerprints[index] = id;
                        
                    }
                }
                else {
                    std::cerr << "Warning: Line does not match expected format: " << line << "\n";
                }
            }

            if (fingerprints[fingerprintIndex].empty()) {
                std::cerr << "Error: No fingerprint found at index " << fingerprintIndexStr << ".\n";
                return 1;
            }

            // Get the actual fingerprint ID
            std::string fingerID = fingerprints[fingerprintIndex];
            std::cout << "Mapped fingerprint index " << fingerprintIndexStr << " to ID " << fingerID << "\n";

            // Confirm deletion
            std::cout << "Are you sure you want to delete fingerprint " << fingerprintIndexStr
                << " with ID " << fingerID << "? (Y/N): ";
            char confirm;
            std::cin >> confirm;

            if (confirm != 'Y' && confirm != 'y') {
                std::cout << "Operation cancelled.\n";
                return 0;
            }

            // Perform deletion using the actual ID
            std::string deleteCommand = ".\\libfido2-ui.exe " + pincom + "-D -e -i " + fingerID + "=" + " " + quotedDevice;
            std::cout << "Deleting fingerprint " << fingerprintIndexStr << ", ID=" << fingerID << "...\n";
            std::string commandOutput = ExecuteCommand(deleteCommand);

            // Output the result
            std::cout << commandOutput;
            return 0;
        }





        //End of options

        // Handle unknown operation
        std::cerr << "ERROR: Unknown operation: " << operation << "\n";
        ShowHelp();

        return 1;

    } catch (const std::exception& e) {
        std::cerr << "ERROR: " << e.what() << "\n";
        return 1;
    }
}
