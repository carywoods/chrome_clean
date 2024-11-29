# Chrome Clean

Chrome Clean is a batch script designed to remove Google Chrome-related policies from Windows registry. This tool is particularly useful for troubleshooting or restoring default settings when Chrome policies are being enforced, often due to organizational configurations or malware.

## Features
- Deletes machine-wide and user-specific Chrome policies.
- Lists all Chrome-related registry keys before removal for verification.
- Ensures all Google Chrome-related policies are fully removed to allow a fresh start.

## Prerequisites
- **Windows Administrator Privileges**: The script must be run as an administrator to successfully access and delete registry keys.
- **Windows OS**: This script is intended for Windows systems that have Google Chrome installed.

## Usage
1. **Download the Script**: Save the `chrome_clean.bat` file to your local machine.
2. **Run as Administrator**:
   - Right-click on the `chrome_clean.bat` file.
   - Select **Run as administrator**.
3. **Review Listed Policies**:
   - The script will list existing Chrome policies from the registry for your review.
4. **Confirm Deletion**:
   - Once confirmed, the script will proceed to delete the policies.

## Warning
- This script modifies the Windows registry, which can affect system behavior. Use with caution and ensure you have backups of important data.
- Running this script will remove all Chrome policies, including potentially valid configurations from corporate environments.

## Commands Overview
- **Registry Key Listing**: The script will list all the Chrome policies present in the registry before any deletion for your verification.
- **Registry Key Deletion**: Chrome policies will be removed from the following locations:
  - `HKEY_LOCAL_MACHINE\Software\Policies\Google\Chrome`
  - `HKEY_LOCAL_MACHINE\Software\Google\Chrome`
  - `HKEY_CURRENT_USER\Software\Policies\Google\Chrome`
  - `HKEY_CURRENT_USER\Software\Google\Chrome`

## License
This project is open-sourced under the MIT License. Feel free to use, modify, and distribute as needed.

## Disclaimer
Chrome Clean is provided as-is, without any warranty or guarantee. Use at your own risk. The author takes no responsibility for any issues caused by the use of this script.

## Contributing
If you'd like to contribute to Chrome Clean, feel free to submit a pull request on GitHub. Issues and suggestions are always welcome.

