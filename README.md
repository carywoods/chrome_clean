# Chrome Clean

Chrome Clean is a small, auditable Windows utility for removing Google Chrome and Chromium policies from the registry. It can help diagnose a personal computer where `chrome://policy` shows unwanted policies left behind by old management software, unwanted extensions, or malware remediation.

## Safety first

Chrome Clean changes the Windows registry. Version 1.0 previews every targeted key, requires the user to type `REMOVE`, and exports each existing key before deleting it.

Do not use Chrome Clean to bypass controls on a computer managed by an employer, school, or another organization. Authorized management software can restore policies after they are removed. Contact the responsible administrator when the device is legitimately managed.

Chrome Clean does not delete:

- Windows Group Policy directories
- Chrome profiles, bookmarks, history, passwords, or other user data
- General Google or Chrome application registry data
- Chrome itself

## Requirements

- Windows 10 or Windows 11
- Administrator access
- Google Chrome or Chromium, if you want to inspect the result

## Usage

1. Download [`chrome_clean.bat`](chrome_clean.bat).
2. Read the script. Its complete behavior is visible in one text file.
3. Right-click the downloaded file and select **Run as administrator**.
4. Review the policies displayed by the script.
5. Type `REMOVE` to approve the cleanup, or close the window to make no changes.
6. Restart Chrome, visit `chrome://policy`, and select **Reload policies**.

Registry backups are written to a uniquely named `Chrome-Clean-Backup` folder on the current user's desktop. Double-click an exported `.reg` file to restore that key if necessary.

## Targeted policy keys

Chrome Clean checks the following locations:

```text
HKLM\Software\Policies\Google\Chrome
HKLM\Software\Policies\Google\Update
HKLM\Software\Policies\Chromium
HKLM\Software\WOW6432Node\Policies\Google\Chrome
HKLM\Software\WOW6432Node\Policies\Google\Update
HKCU\Software\Policies\Google\Chrome
HKCU\Software\Policies\Google\Update
HKCU\Software\Policies\Chromium
```

## Troubleshooting

Policies that return after cleanup are probably being supplied by Windows Group Policy, cloud management, security software, or another administrator-controlled service. Chrome Clean deliberately does not disable those systems.

Windows may display a SmartScreen warning because the batch file is unsigned. Choose **More info** only after verifying that the downloaded file matches the source in this repository.

## Contributing

Bug reports, tested improvements, and pull requests are welcome. Please describe the Windows version used, the expected behavior, the actual behavior, and any relevant console output. Remove private information from screenshots and registry exports before posting them publicly.

## License and attribution

Chrome Clean is free and open-source software licensed under the [GNU General Public License v3.0](LICENSE).

The project was inspired by Stefan Van Damme's Chrome Policy Remover for Windows. Chrome and Chromium are trademarks of their respective owners. This project is independent and is not endorsed by or affiliated with Google.

## Disclaimer

This software is provided without warranty. Review the source, maintain current backups, and use it only on systems you own or are authorized to administer.
