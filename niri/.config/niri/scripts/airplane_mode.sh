#!/bin/bash

# ============================================================
# Script: Airplane Mode Toggle
# Platform: Arch Linux x Niri (Wayland)
# Function: Synchronizes software and hardware radio states
# ============================================================

# Fetch current Wi-Fi radio status using NetworkManager CLI
WIFI_STATE=$(nmcli radio wifi)

if [ "$WIFI_STATE" = "enabled" ]; then
    # Disable all radio transmissions via NetworkManager
    nmcli radio all off

    # Force hardware-level block using rfkill (Requires Polkit for auth)
    # The '&' ensures the script doesn't hang if the prompt is open
    pkexec rfkill block all &

    # Dispatch a persistent notification to indicate offline status
    notify-send -u critical -i airplane-mode-symbolic \
        "Airplane Mode" "SYSTEM IS NOW OFFLINE ✈️\nRadios Disabled"
else
    # Lift hardware-level restrictions first
    pkexec rfkill unblock all &

    # Re-enable radio transmissions via NetworkManager
    nmcli radio all on

    # Latency buffer: Wait for the network card to re-initialize before notifying
    sleep 1

    # Dispatch a standard notification to indicate online status
    notify-send -u normal -i network-wireless-signal-excellent-symbolic \
        "Airplane Mode" "SYSTEM IS ONLINE 📶\nRadios Enabled"
fi