#!/bin/bash

# Define the options with Nerd Font icons
# The extra spaces ensure the text looks balanced when centered
lock="  Lock"
logout="  Logout"
suspend="  Suspend"
reboot="  Reboot"
shutdown="➜]  Shutdown"

# Define the greeting/title message based on the current user and hostname
host=$(cat /etc/hostname)
user=$(whoami)
message="Power Menu"

# Combine the options into a single string separated by newlines
options="$lock\n$logout\n$suspend\n$reboot\n$shutdown"

# Pipe the options into Rofi
# -mesg: displays the custom greeting message
chosen="$(echo -e "$options" | rofi -dmenu -i -p "Power" -theme ~/.config/rofi/scripts/power-menu/power-menu.rasi -mesg "$message")"

# Execute the appropriate command based on the user's selection
case $chosen in
    $lock)
        # Assuming you use hyprlock (change to swaylock if needed)
        hyprlock
        ;;
    $logout)
        # Safely exit Hyprland
        hyprctl dispatch exit
        ;;
    $suspend)
        # Lock the screen first, then suspend
        hyprlock & disown
        sleep 1
        systemctl suspend
        ;;
    $reboot)
        systemctl reboot
        ;;
    $shutdown)
        systemctl poweroff
        ;;
esac