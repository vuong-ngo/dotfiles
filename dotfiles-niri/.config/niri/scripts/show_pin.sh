#!/usr/bin/env bash

# ============================================================
# Script: show_pin.sh
# Description: Displays a PIN entry dialog for unlocking the screen
# ============================================================

echo 󰁹 Your Battery: $(cat /sys/class/power_supply/BAT1/capacity 2>/dev/null || echo 100)%