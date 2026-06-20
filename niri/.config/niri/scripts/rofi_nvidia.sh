#!/bin/bash

# ============================================================
# Script: Rofi NVIDIA Launcher
# Platform: Arch Linux x Niri (Wayland)
# Function: This script provides a graphical interface to launch applications using NVIDIA's prime-run command, allowing users to run applications on the NVIDIA GPU. It checks for the presence of the prime-run command and displays an error notification if it's not found. The script uses Rofi to present a list of applications to the user, which can be launched with the NVIDIA GPU.
# ============================================================

if ! command -v prime-run &> /dev/null; then
    notify-send "Error" "Not found driver NVIDIA"
    exit 1
fi

rofi -show drun \
    -theme "$HOME/.config/rofi/config.rasi" \
    -run-list-command ". $HOME/.bashrc" \
    -run-command "prime-run {cmd}" \
    -display-drun "󰾲  GPU" \
    -drun-display-format "{name}"
