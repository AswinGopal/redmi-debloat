@echo off
setlocal

REM Use the folder where this script is located (path ends with a backslash)
set "PLATFORM_TOOLS=%~dp0"
set "ADB=%PLATFORM_TOOLS%adb.exe"

REM Verify adb exists
if not exist "%ADB%" (
    echo ERROR: adb.exe not found at "%ADB%"
    echo Place this script in the platform-tools folder, or edit PLATFORM_TOOLS above.
    echo Example: set "PLATFORM_TOOLS=C:\platform-tools\"
    pause
    exit /b 1
)

echo Using adb at: %ADB%
echo ############################

:start
echo Stopping Previous ADB Services...
"%ADB%" kill-server

echo Starting ADB Services...
"%ADB%" devices

set "c="
set /p "c=Please confirm that the phone has prompted you for USB Debugging Permissions. You may need to Revoke permissions in Developer Options. [Y] to continue, [N] to start again: "

if /i "%c%"=="Y" goto continue_script
if /i "%c%"=="N" goto start
echo Invalid input. Please enter Y or N.
goto start

:continue_script
echo.
echo Uninstalling Redmi Bloatwares
echo #############################
echo.

call :uninstall "GetApps" com.xiaomi.mipicks
call :uninstall "Game Center" com.xiaomi.glgm
call :uninstall "Yellow Page" com.miui.yellowpage
call :uninstall "Xiaomi Cloud" com.miui.cloudservice
call :uninstall "Mi Cloud Sync" com.miui.micloudsync
call :uninstall "Cloud Backup" com.miui.cloudbackup
call :uninstall "Cleaner" com.miui.cleaner
call :uninstall "MI Coin" com.xiaomi.payment
call :uninstall "Music" com.miui.player

REM call :uninstall "Gallery App" com.miui.gallery
REM call :uninstall "Gallery player app" com.gallery.player
REM call :uninstall "SMS App" com.android.mms
REM call :uninstall "Analytics" com.miui.analytics
REM call :uninstall "Mi Backup" com.miui.backup
REM call :uninstall "MIUI Daemon" com.miui.daemon

call :uninstall "FM" com.miui.fm
call :uninstall "FM Service" com.miui.fmservice

REM call :uninstall "Services and Feedback" com.miui.miservice
REM call :uninstall "msa" com.miui.msa.global

call :uninstall "Frequent Phrases" com.miui.phrase

echo.
echo Uninstalling Google Bloatwares
echo #############################
echo.

call :uninstall "Youtube Music" com.google.android.apps.youtube.music
call :uninstall "Google TV" com.google.android.videos
call :uninstall "Photos" com.google.android.apps.photos

echo.
echo FaceBook APKs
echo ##############
echo Disable all the APKs manually

echo.
echo Xiaomi Earphones app
echo ##############
echo Disable the app manually to disable the unwanted EQ settings

echo.
echo End of Uninstall Script
echo.
echo Press any key to exit. Your current ADB session will remain active.
pause >nul
endlocal
exit /b 0

:uninstall
echo Uninstalling %~1
"%ADB%" shell "pm uninstall --user 0 %~2"
exit /b
