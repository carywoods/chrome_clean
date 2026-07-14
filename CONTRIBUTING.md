# Contributing to Chrome Clean

Chrome Clean welcomes focused, testable contributions that preserve its narrow scope and safety controls.

## Before opening an issue

- Confirm that the policy appears at `chrome://policy`.
- Confirm that the computer is yours or that you are authorized to administer it.
- Search existing issues for the same behavior.
- Remove names, email addresses, enrollment tokens, organization identifiers, and other private data from logs or screenshots.

## Pull requests

Please keep changes readable in standard Windows batch syntax and explain:

- The problem being addressed
- The policy location or Windows behavior involved
- The Windows and Chrome versions tested
- The expected output and exit code
- The rollback or failure behavior

Changes that delete Windows Group Policy directories, disable device management, remove Chrome user data, or bypass legitimate organizational controls are outside this project's scope.

## Testing checklist

- Run without administrator access and confirm that the script exits safely.
- Run with no targeted keys present and confirm that no changes occur.
- Cancel at the confirmation prompt and confirm that no changes occur.
- Test with a disposable policy key and confirm that a `.reg` backup is created before deletion.
- Confirm that backup failure prevents deletion.
- Confirm that Chrome profiles and Windows Group Policy directories remain untouched.
