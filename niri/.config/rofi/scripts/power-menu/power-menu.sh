#!/usr/bin/env bash

# ============================================================
# Script: Rofi Power Menu
# Platform: Arch Linux x Niri (Wayland)
# Function: Provides a power menu with options to Lock, Logout, Suspend, Reboot,
#           and Shutdown, using Rofi for the interface and systemctl for actions.
# ============================================================

# Define options with Nerd Font icons
lock="  Lock"
logout="  Logout"
suspend="  Suspend"
reboot="  Reboot"
shutdown="  Shutdown"

# Combined message for a professional look
message="System"
options="$lock\n$logout\n$suspend\n$reboot\n$shutdown"

# Launch Rofi
chosen="$(echo -e "$options" | rofi -dmenu -i -p "Power" \
    -theme ~/.config/rofi/scripts/power-menu/power-menu.rasi \
    -mesg "$message")"

case "$chosen" in
    "$lock")
        hyprlock
        ;;
    "$logout")
        # Correct Niri action to exit the session
        niri msg action quit --skip-confirmation
        ;;
    "$suspend")        
        swaync-client -cp &
        hyprlock & 
        sleep 0.5
        systemctl suspend
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$shutdown")
        systemctl poweroff
        ;;
esac
