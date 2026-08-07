#!/usr/bin/env bash

# ============================================================
# Script: Rofi NVIDIA App Launcher
# Description: Launches applications on discrete NVIDIA GPU using prime-run
# ============================================================

show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTION]

Description:
  Opens Rofi Application Launcher configured to run selected apps
  using NVIDIA PRIME offload (prime-run).

Options:
  -h, --help    Show this help message and exit

Examples:
  $(basename "$0")       Launch NVIDIA Rofi runner
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    show_help
    exit 0
fi

if ! command -v prime-run &> /dev/null; then
    notify-send "NVIDIA Error" "[ERR] prime-run driver tool not found"
    exit 1
fi

rofi -normal-window -show drun \
    -theme "$HOME/.config/rofi/config.rasi" \
    -run-list-command ". $HOME/.bashrc" \
    -run-command "prime-run {cmd}" \
    -display-drun "[GPU]" \
    -drun-display-format "{name}"
