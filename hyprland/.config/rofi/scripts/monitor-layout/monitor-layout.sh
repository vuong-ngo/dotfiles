#!/bin/bash

# 1. Define options (Standard Windows naming convention)
options="💻 PC screen only\n🪞 Duplicate\n🖥️ Extend\n📺 Second screen only"

# 2. Call Rofi with an English prompt
choice=$(echo -e "$options" | rofi -dmenu -i -p "📺 Project:" -theme ~/.config/rofi/scripts/monitor-layout/monitor-layout.rasi)

# Exit if user presses Esc
if [ -z "$choice" ]; then
    exit 0
fi

# 3. Detect monitors using hyprctl and jq
LAPTOP=$(hyprctl monitors all -j | jq -r '.[] | select(.name | contains("eDP")) | .name' | head -n 1)
EXTERNAL=$(hyprctl monitors all -j | jq -r '.[] | select(.name | contains("eDP") | not) | .name' | head -n 1)

# Error handling if no external monitor is connected
if [ -z "$EXTERNAL" ]; then
    notify-send -u critical -i video-display "Projection Error" "No external monitor detected!"
    exit 1
fi

# 4. Handle choices based on English keywords
case "$choice" in
    *"PC screen only"*)
        hyprctl keyword monitor "$EXTERNAL, disable"
        hyprctl keyword monitor "$LAPTOP, preferred, auto, 1"
        notify-send -i computer "Monitor Layout" "Switched to: PC screen only"
        ;;
    *"Duplicate"*)
        hyprctl keyword monitor "$LAPTOP, preferred, auto, 1"
        hyprctl keyword monitor "$EXTERNAL, preferred, auto, 1, mirror, $LAPTOP"
        notify-send -i video-display "Monitor Layout" "Switched to: Duplicate"
        ;;
    *"Extend"*)
        hyprctl keyword monitor "$LAPTOP, preferred, auto, 1"
        hyprctl keyword monitor "$EXTERNAL, preferred, auto-right, 1"
        notify-send -i video-display "Monitor Layout" "Switched to: Extend"
        ;;
    *"Second screen only"*)
        hyprctl keyword monitor "$LAPTOP, disable"
        hyprctl keyword monitor "$EXTERNAL, preferred, auto, 1"
        notify-send -i video-television "Monitor Layout" "Switched to: Second screen only"
        ;;
esac