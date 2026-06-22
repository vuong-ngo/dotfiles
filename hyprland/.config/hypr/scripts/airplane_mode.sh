#!/bin/bash

# Use the -t (terse) flag to get the exact Wi-Fi status from NetworkManager
WIFI_STATE=$(nmcli -t -f WIFI radio)

if [ "$WIFI_STATE" = "enabled" ]; then
    # Force software block (NetworkManager)
    nmcli radio all off
    # Force hardware block (Kernel)
    rfkill block all
    notify-send -u normal -i airplane-mode-symbolic "Airplane Mode" "ON ✈️ (Radios Disabled)"
else
    # Unblock software
    nmcli radio all on
    # Unblock hardware
    rfkill unblock all
    notify-send -u normal -i network-wireless-signal-excellent-symbolic "Airplane Mode" "OFF ✈️ (Radios Enabled)"
fi
