#!/bin/bash

#    ____         __       ____               __     __
#   /  _/__  ___ / /____ _/ / / __ _____  ___/ /__ _/ /____ ___
#  _/ // _ \(_-</ __/ _ `/ / / / // / _ \/ _  / _ `/ __/ -_|_-<
# /___/_//_/___/\__/\_,_/_/_/  \_,_/ .__/\_,_/\_,_/\__/\__/___/
#                                 /_/
#

sleep 1
clear
figlet -f smslant "Updates"
echo

# ------------------------------------------------------
# Confirm Start
# ------------------------------------------------------
if gum confirm "DO YOU WANT TO START THE UPDATE NOW?"; then
    echo
    echo ":: Update started."
else
    echo
    echo ":: Update canceled."
    exit
fi

# ------------------------------------------------------
# Define AUR Helper
# ------------------------------------------------------
aur_helper="$(cat ~/.config/ml4w/settings/aur.sh)"

# ------------------------------------------------------
# Function to Check If a Package is Installed
# ------------------------------------------------------
_isInstalled() {
    package="$1"
    check="$($aur_helper -Qs --color always "${package}" | grep "local" | grep "${package} ")"

    if [ -n "${check}" ]; then
        echo 0 #'0' means 'true' in Bash
        return # true
    fi
    echo 1 #'1' means 'false' in Bash
    return # false
}

# ------------------------------------------------------
# Check for Timeshift and Create Snapshot If Installed
# ------------------------------------------------------
if [[ $(_isInstalled "timeshift") == "0" ]]; then
    echo
    if gum confirm "DO YOU WANT TO CREATE A SNAPSHOT?"; then
        echo
        c=$(gum input --placeholder "Enter a comment for the snapshot...")
        sudo timeshift --create --comments "$c"
        sudo timeshift --list
        sudo grub-mkconfig -o /boot/grub/grub.cfg
        echo ":: DONE. Snapshot '$c' created!"
        echo
    else
        echo ":: Snapshot skipped."
    fi
    echo
fi

# ------------------------------------------------------
# Run System Update
# ------------------------------------------------------
$aur_helper -Syu

# ------------------------------------------------------
# Upgrade Flatpak Apps If Installed
# ------------------------------------------------------
if [[ $(_isInstalled "flatpak") == "0" ]]; then
    flatpak upgrade
fi

# ------------------------------------------------------
# Notify and Exit
# ------------------------------------------------------
notify-send "Update complete"
echo
echo ":: Update complete"
echo
echo "Press [ENTER] to close."
read
