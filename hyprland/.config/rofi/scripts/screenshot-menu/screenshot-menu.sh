#!/usr/bin/env bash

# Options for the Rofi menu
option_region="󰹑  Region"y
option_window="󱂬  Window"
option_screen="󰍹  Screen"

options="$option_region\n$option_window\n$option_screen"

# Call Rofi using your clipboard/powermenu theme
# Adjust the theme path if you want to use a specific .rasi file
chosen="$(echo -e "$options" | rofi -dmenu -i -p "󰄄 Screenshot" -theme ~/.config/rofi/scripts/screenshot-menu/screenshot-menu.rasi)"

# Execute Hyprshot based on selection
case $chosen in
$option_region)
    # Adding a small sleep prevents Rofi from being captured in the screenshot
    sleep 0.5 && hyprshot -m region
    ;;
$option_window)
    sleep 0.5 && hyprshot -m window
    ;;
$option_screen)
    sleep 0.5 && hyprshot -m output
    ;;
esac

