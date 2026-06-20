#!/bin/bash

# ============================================================
# Script: Manual Power Saving Toggle (Extreme Mode)
# Platform: Arch Linux x Niri (Wayland)
# Function: Toggle power-saving mode between ACTIVE and RESTORED states, adjusting CPU performance and screen brightness, and sending notifications to indicate the current state.
# ============================================================

# Temporary flag file to track the current state
LOCK_FILE="/tmp/niri_power_save_active"

if [ -f "$LOCK_FILE" ]; then
    # --- RESTORE PERFORMANCE MODE ---
    rm -f "$LOCK_FILE"

    powerprofilesctl set balanced
    brightnessctl set 80%

    notify-send "Power System" "NORMAL MODE: RESTORED ⚡\nBalanced Performance" \
                -i battery-full-symbolic \
                -h string:x-canonical-private-synchronous:niri-power
    exit 0
fi

# ---- ENABLE POWER SAVING MODE ----
touch "$LOCK_FILE"

powerprofilesctl set power-saver
brightnessctl set 20%

notify-send "Power System" "MANUAL POWER SAVE: ACTIVE 🔋\nCPU Throttled | Brightness Reductions" \
            -u critical \
            -i battery-caution-symbolic \
            -h string:x-canonical-private-synchronous:niri-power