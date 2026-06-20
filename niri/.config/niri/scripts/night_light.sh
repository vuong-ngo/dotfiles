#!/bin/bash

# ============================================================
# Script: Blue Light Filter (Night Light) Toggle
# Platform: Arch Linux x Niri (Wayland)
# Tool: wlsunset (Works natively on Niri)
# Target Temperature: 4500K (Warm White)
# ============================================================

TEMP=4500

# Check if wlsunset is currently running
if pgrep -x "wlsunset" > /dev/null; then
    # --- DISABLE NIGHT LIGHT ---
    pkill -x wlsunset
    
    # Send a clean notification using a consistent stack-tag to prevent spam
    notify-send -h string:x-dunst-stack-tag:night_light \
                -i display-brightness-symbolic \
                -u low \
                "Night Light" "Mode: Standard (OFF) ☀️"
else
    # --- ENABLE NIGHT LIGHT ---
    # Niri doesn't need a dispatcher like 'hyprctl'. 
    # We execute it directly and disown the process to keep it in the background.
    wlsunset -T $TEMP > /dev/null 2>&1 &
    
    notify-send -h string:x-dunst-stack-tag:night_light \
                -i display-brightness-symbolic \
                -u low \
                "Night Light" "Mode: Eye Care (ON) 🌙\nTemp: ${TEMP}K"
fi