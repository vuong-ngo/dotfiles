#!/usr/bin/env bash

# ============================================================
# Script: Rofi File Opener Chooser for Ranger
# Description: Displays an interactive Rofi menu of applications to open selected file
# ============================================================

FILE_PATH="$1"

if [ -z "$FILE_PATH" ]; then
    exit 0
fi

FILE_NAME="$(basename "$FILE_PATH")"

# Define menu list
CHOICE_1="󰌾 System Default (xdg-open)"
CHOICE_2=" swayimg (Image Viewer)"
CHOICE_3="󰕧 mpv (Media Player)"
CHOICE_4="󰅍 Neovim (Terminal Editor)"
CHOICE_5="󰅩 VS Code (IDE)"
CHOICE_6="󰈦 Zathura (PDF Reader)"
CHOICE_7="󰈙 Nautilus (File Manager)"

MENU="$CHOICE_1\n$CHOICE_2\n$CHOICE_3\n$CHOICE_4\n$CHOICE_5\n$CHOICE_6\n$CHOICE_7"

CHOSEN=$(echo -e "$MENU" | rofi -dmenu -i -p "Open '$FILE_NAME'" \
    -theme-str 'window { width: 560px; border-radius: 20px; } listview { lines: 7; }' \
    -theme ~/.config/rofi/config.rasi)

case "$CHOSEN" in
    "$CHOICE_1")
        xdg-open "$FILE_PATH" &
        ;;
    "$CHOICE_2")
        swayimg -- "$FILE_PATH" 2>/dev/null || mpv --image-display-duration=inf -- "$FILE_PATH" &
        ;;
    "$CHOICE_3")
        mpv --force-window -- "$FILE_PATH" &
        ;;
    "$CHOICE_4")
        footclient -e nvim "$FILE_PATH" &
        ;;
    "$CHOICE_5")
        code "$FILE_PATH" &
        ;;
    "$CHOICE_6")
        zathura -- "$FILE_PATH" &
        ;;
    "$CHOICE_7")
        nautilus "$FILE_PATH" &
        ;;
esac
