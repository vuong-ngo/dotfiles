#!/bin/bash

# 1. Ensure the screenshot directory exists
SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

# 2. Capture focused window coordinates
# A short sleep ensures Sway has updated the focus state after the keypress
sleep 0.1
GEOM=$(swaymsg -t get_tree | jq -r '.. | select(.type? == "con" or .type? == "floating_con") | select(.focused? == true) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')

# Validate geometry (Check if GEOM is empty or null)
if [ -z "$GEOM" ] || [ "$GEOM" == "null" ]; then
    notify-send "Screenshot Error" "Could not detect an active window" -u critical
    exit 1
fi

# 3. Define file naming convention
FILENAME="window_$(date +%Y%m%d_%H%M%S).png"
FILEPATH="$SAVE_DIR/$FILENAME"

# 4. Execute screen capture
grim -g "$GEOM" "$FILEPATH"

# 5. Copy to clipboard and send notification
if [ -f "$FILEPATH" ]; then
    wl-copy < "$FILEPATH"
    notify-send "Screenshot Captured" "Saved and copied: $FILENAME" -i "$FILEPATH"
else
    notify-send "Screenshot Error" "Failed to save the image file" -u critical
fi