:: Chrome Cleaner version 0.8 - November 29, 2024
:: Dr. Cary Woods
:: hcwoods.com 
::
:: This program was based on Stefan Vd's Chrome Policy Remover for Windows
:: version 1.0 - 21 May 2022

@echo off
REM Chrome Policy Remover for Windows
REM Enhanced Version

REM Check if script is run as administrator
openfiles >nul 2>&1 || (
    echo This script must be run as administrator.
    pause
    exit /b
)

REM Close Google Chrome
echo Closing Google Chrome...
taskkill /F /IM chrome.exe /T > nul
echo.

REM Delete Group Policy folders if they exist
IF EXIST "%WINDIR%\System32\GroupPolicy" (
    echo Deleting GroupPolicy folder...
    RD /S /Q "%WINDIR%\System32\GroupPolicy" || goto error
    echo.
)

IF EXIST "%WINDIR%\System32\GroupPolicyUsers" (
    echo Deleting GroupPolicyUsers folder...
    RD /S /Q "%WINDIR%\System32\GroupPolicyUsers" || goto error
    echo.
)

REM Delete Google Policy folders in Program Files
IF EXIST "%ProgramFiles(x86)%\Google\Policies" (
    echo Deleting Google Policies folder (x86)...
    RD /S /Q "%ProgramFiles(x86)%\Google\Policies" || goto error
    echo.
)

IF EXIST "%ProgramFiles%\Google\Policies" (
    echo Deleting Google Policies folder...
    RD /S /Q "%ProgramFiles%\Google\Policies" || goto error
    echo.
)

REM Force Group Policy Update
echo Updating Group Policy...
gpupdate /force
echo.

REM Delete Chrome policies from the registry
echo Deleting policies from Windows registries...
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Google\Chrome /f
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Google\Update /f
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Chromium /f
reg delete HKEY_LOCAL_MACHINE\Software\Google\Chrome /f
reg delete HKEY_LOCAL_MACHINE\Software\WOW6432Node\Google\Enrollment /f
reg delete HKEY_CURRENT_USER\Software\Policies\Google\Chrome /f
reg delete HKEY_CURRENT_USER\Software\Policies\Chromium /f
reg delete HKEY_CURRENT_USER\Software\Google\Chrome /f
reg delete "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Google\Update\ClientState\{430FD4D0-B729-4F61-AA34-91526481799D}" /v "CloudManagementEnrollmentToken" /f

REM Confirm cleanup
echo Chrome policies deleted successfully.
pause
exit

:error
echo.
echo An unexpected error has occurred. Have you opened the program as an administrator (right-click, run as administrator)?
echo.
pause
exit
