#!/usr/bin/env bash

# File to store the current toggle state
FLAG="/tmp/manual_power_save_mode"

if [ ! -f "$FLAG" ]; then
  # --- ENABLE POWER SAVING MODE ---
  touch "$FLAG"

  # 1. Set CPU profile to power-saver (via power-profiles-daemon)
  powerprofilesctl set power-saver

  # 2. Dim screen brightness to 10%
  brightnessctl set 20%

  # 3. Disable Hyprland eye-candy to save GPU resources (GTX 1650)
  hyprctl keyword animations:enabled 0

  # Send notification via SwayNC
  notify-send -u critical -a "Power System" "MANUAL POWER SAVE: ON" "Animations disabled & Performance throttled."
else
  # --- RESTORE NORMAL MODE ---
  rm "$FLAG"

  # 1. Restore CPU profile to performance
  powerprofilesctl set performance

  # 2. Restore screen brightness to 60%
  brightnessctl set 85%

  # 3. Re-enable Hyprland eye-candy
  hyprctl keyword animations:enabled 1

  # Send notification via SwayNC
  notify-send -u normal -a "Power System" "MANUAL POWER SAVE: OFF" "Animations enabled & Performance restored."
fi
