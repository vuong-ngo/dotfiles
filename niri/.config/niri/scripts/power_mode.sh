#!/bin/bash

# ============================================================
# Script: Power Profile Switcher
# Platform: Arch Linux x Niri (Wayland)
# Dependency: power-profiles-daemon, swaync
# ============================================================

# 1. Capture target mode (performance, balanced, power-saver)
TARGET_MODE=$1

# 2. Validation: Ensure the mode is valid before execution
if [[ "$TARGET_MODE" != "performance" && "$TARGET_MODE" != "balanced" && "$TARGET_MODE" != "power-saver" ]]; then
    notify-send -u low "Power Script" "Invalid Mode: $TARGET_MODE"
    exit 1
fi

# 3. Apply the system-wide power profile
# This talks directly to the kernel to adjust CPU frequency/scaling
powerprofilesctl set "$TARGET_MODE"

# 4. Dispatch specialized notification
# Using 'x-dunst-stack-tag' to replace old power notifications
notify-send -h string:x-dunst-stack-tag:power_profile \
            -u normal \
            -i speedometer-symbolic \
            "Power Strategy" "Active Profile: ${TARGET_MODE^^} ⚡"

# 5. Synchronize SwayNC (Notification Center)
# Forces SwayNC to re-scan state so your Waybar/Dashboard updates instantly
swaync-client -rs > /dev/null 2>&1