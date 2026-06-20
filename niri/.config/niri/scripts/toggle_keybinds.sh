#!/bin/bash

# ============================================================
# Script: Toggle Keybinds
# Platform: Arch Linux x Niri (Wayland)
# Function: Toggle keybinds between ON and OFF states, updating the symlink and sending a notification to indicate the current state.
# ============================================================

DIR="$HOME/.config/niri/config.d"
ON="$DIR/keybinds-on.kdl"
OFF="$DIR/keybinds-off.kdl"
ACTIVE="$DIR/keybinds.kdl"

if [ "$(readlink "$ACTIVE")" = "$OFF" ]; then
    ln -sf "$ON" "$ACTIVE"
    notify-send -t 800 "Niri" "🔓 Open keybinds (Normal)"
else
    ln -sf "$OFF" "$ACTIVE"
    notify-send -t 800 "Niri" "🔒 Close keybinds (Passthrough)"
fi