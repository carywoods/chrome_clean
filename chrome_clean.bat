@echo off
setlocal EnableExtensions

rem Chrome Clean 1.0.0
rem Copyright (C) 2024-2026 Dr. Cary Woods
rem Licensed under GPL-3.0-only. See LICENSE.
rem Inspired by Stefan Van Damme's Chrome Policy Remover for Windows.

fltmc >nul 2>&1
if errorlevel 1 (
    echo ERROR: Chrome Clean must be run as an administrator.
    echo Right-click chrome_clean.bat and select "Run as administrator."
    pause
    exit /b 1
)

echo.
echo Chrome Clean 1.0.0
echo ==================
echo.
echo This tool removes Chrome and Chromium policy registry keys.
echo It does not remove Windows Group Policy folders or Chrome user data.
echo.
echo Policy keys currently present:
echo.

set "FOUND=0"
call :show "HKLM\Software\Policies\Google\Chrome"
call :show "HKLM\Software\Policies\Google\Update"
call :show "HKLM\Software\Policies\Chromium"
call :show "HKLM\Software\WOW6432Node\Policies\Google\Chrome"
call :show "HKLM\Software\WOW6432Node\Policies\Google\Update"
call :show "HKCU\Software\Policies\Google\Chrome"
call :show "HKCU\Software\Policies\Google\Update"
call :show "HKCU\Software\Policies\Chromium"

if "%FOUND%"=="0" (
    echo No targeted Chrome or Chromium policy keys were found.
    pause
    exit /b 0
)

echo.
echo WARNING: Legitimate policies installed by an employer, school, or
echo administrator will also be removed. Managed policies may return.
echo.
set /p "CONFIRM=Type REMOVE to continue: "
if /I not "%CONFIRM%"=="REMOVE" (
    echo Cancelled. No changes were made.
    pause
    exit /b 0
)

set "BACKUP=%USERPROFILE%\Desktop\Chrome-Clean-Backup-%RANDOM%"
mkdir "%BACKUP%" >nul 2>&1
if errorlevel 1 (
    echo ERROR: Could not create backup folder "%BACKUP%".
    pause
    exit /b 1
)

echo.
echo Closing Google Chrome...
taskkill /F /IM chrome.exe /T >nul 2>&1

set "FAILED=0"
call :backup_and_delete "HKLM\Software\Policies\Google\Chrome" "hklm-google-chrome.reg"
call :backup_and_delete "HKLM\Software\Policies\Google\Update" "hklm-google-update.reg"
call :backup_and_delete "HKLM\Software\Policies\Chromium" "hklm-chromium.reg"
call :backup_and_delete "HKLM\Software\WOW6432Node\Policies\Google\Chrome" "hklm-wow-google-chrome.reg"
call :backup_and_delete "HKLM\Software\WOW6432Node\Policies\Google\Update" "hklm-wow-google-update.reg"
call :backup_and_delete "HKCU\Software\Policies\Google\Chrome" "hkcu-google-chrome.reg"
call :backup_and_delete "HKCU\Software\Policies\Google\Update" "hkcu-google-update.reg"
call :backup_and_delete "HKCU\Software\Policies\Chromium" "hkcu-chromium.reg"

echo.
if "%FAILED%"=="0" (
    echo Chrome and Chromium policy cleanup completed successfully.
    echo Registry backups are stored at:
    echo %BACKUP%
    echo.
    echo Restart Chrome, then visit chrome://policy and select Reload policies.
    pause
    exit /b 0
)

echo Cleanup completed with one or more errors.
echo Review the messages above. Backups are stored at:
echo %BACKUP%
pause
exit /b 1

:show
reg query "%~1" >nul 2>&1
if not errorlevel 1 (
    set "FOUND=1"
    echo [%~1]
    reg query "%~1"
    echo.
)
exit /b 0

:backup_and_delete
reg query "%~1" >nul 2>&1
if errorlevel 1 exit /b 0

echo Backing up %~1...
reg export "%~1" "%BACKUP%\%~2" /y >nul
if errorlevel 1 (
    echo ERROR: Backup failed for %~1. This key was not deleted.
    set "FAILED=1"
    exit /b 0
)

echo Removing %~1...
reg delete "%~1" /f >nul
if errorlevel 1 (
    echo ERROR: Could not remove %~1.
    set "FAILED=1"
)
exit /b 0
