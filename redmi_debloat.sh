#!/bin/bash

# Automatically use the folder where this script is located
PLATFORM_TOOLS="$(cd "$(dirname "$0")" && pwd)"
ADB="$PLATFORM_TOOLS/adb"

# Verify adb exists at the given path
if [ ! -f "$ADB" ]; then
    echo "ERROR: adb not found at '$ADB'"
    echo "Please edit this script and set PLATFORM_TOOLS to the correct folder."
    echo "Example: PLATFORM_TOOLS=\"/home/yourname/platform-tools\""
    exit 1
fi

echo "Using adb at: $ADB"
echo "############################"

start() {
    echo "Stopping Previous ADB Services..."
    "$ADB" kill-server

    echo "Starting ADB Services..."
    "$ADB" devices

    read -p "Please confirm that the phone has prompted you for USB Debugging Permissions. You may need to Revoke permissions in Developer Options. [Y] to continue, [N] to start again: " c

    if [[ "$c" =~ ^[Yy]$ ]]; then
        continue_script
    elif [[ "$c" =~ ^[Nn]$ ]]; then
        start
    else
        echo "Invalid input. Please enter Y or N."
        start
    fi
}

continue_script() {
    echo ""
    echo "Uninstalling Redmi Bloatwares"
    echo "#############################"
    echo ""

    echo "Uninstalling GetApps"
    "$ADB" shell "pm uninstall --user 0 com.xiaomi.mipicks"

    echo "Uninstalling Game Center"
    "$ADB" shell "pm uninstall --user 0 com.xiaomi.glgm"

    echo "Uninstalling Yellow Page"
    "$ADB" shell "pm uninstall --user 0 com.miui.yellowpage"

    echo "Uninstalling Xiaomi Cloud"
    "$ADB" shell "pm uninstall --user 0 com.miui.cloudservice"

    echo "Uninstalling Mi Cloud Sync"
    "$ADB" shell "pm uninstall --user 0 com.miui.micloudsync"

    echo "Uninstalling Cloud Backup"
    "$ADB" shell "pm uninstall --user 0 com.miui.cloudbackup"

    echo "Uninstalling Cleaner"
    "$ADB" shell "pm uninstall --user 0 com.miui.cleaner"

    echo "Uninstalling MI Coin"
    "$ADB" shell "pm uninstall --user 0 com.xiaomi.payment"

    echo "Uninstalling Music"
    "$ADB" shell "pm uninstall --user 0 com.miui.player"

    # echo "Uninstalling Gallery App"
    # "$ADB" shell "pm uninstall --user 0 com.miui.gallery"

    # echo "Uninstalling Gallery player app"
    # "$ADB" shell "pm uninstall --user 0 com.gallery.player"

    # echo "Uninstalling SMS App"
    # "$ADB" shell "pm uninstall --user 0 com.android.mms"

    # echo "Uninstalling Analytics"
    # "$ADB" shell "pm uninstall --user 0 com.miui.analytics"

    # echo "Uninstalling Mi Backup"
    # "$ADB" shell "pm uninstall --user 0 com.miui.backup"

    # echo "Uninstalling MIUI Daemon"
    # "$ADB" shell "pm uninstall --user 0 com.miui.daemon"

    echo "Uninstalling FM"
    "$ADB" shell "pm uninstall --user 0 com.miui.fm"

    echo "Uninstalling FM Service"
    "$ADB" shell "pm uninstall --user 0 com.miui.fmservice"

    # echo "Uninstalling Services and Feedback"
    # "$ADB" shell "pm uninstall --user 0 com.miui.miservice"

    # echo "Uninstalling msa"
    # "$ADB" shell "pm uninstall --user 0 com.miui.msa.global"

    echo "Uninstalling Frequent Phrases"
    "$ADB" shell "pm uninstall --user 0 com.miui.phrase"

    echo ""
    echo "Uninstalling Google Bloatwares"
    echo "#############################"
    echo ""

    echo "Uninstalling Youtube Music"
    "$ADB" shell "pm uninstall --user 0 com.google.android.apps.youtube.music"

    echo "Uninstalling Google TV"
    "$ADB" shell "pm uninstall --user 0 com.google.android.videos"

    echo "Uninstalling Photos"
    "$ADB" shell "pm uninstall --user 0 com.google.android.apps.photos"

    echo ""
    echo "FaceBook APKs"
    echo "##############"
    echo "Disable all the APKs manually"

    echo ""
    echo "Xiomi Earphones app"
    echo "##############"
    echo "Disable the app manually to disable the unwanted EQ settings"

    echo ""
    echo "End of Uninstall Script"
    echo ""
    echo "Press Enter to exit. Your current ADB session will remain active."
    read
}

start
