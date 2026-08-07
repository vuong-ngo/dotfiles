#!/usr/bin/env bash

# ============================================================
# Script: Night Light (Eye Care) Toggle
# Description: Toggles wlsunset color temperature filter for eye comfort
# ============================================================

show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTION]

Description:
  Toggles blue light filter (wlsunset) at 4500K warm color temperature.

Options:
  -h, --help    Show this help message and exit

Examples:
  $(basename "$0")       Toggle night light filter
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    show_help
    exit 0
fi

TEMP=4500

if pgrep -x "wlsunset" > /dev/null; then
    pkill -x wlsunset
    notify-send -h string:x-dunst-stack-tag:night_light \
                -i display-brightness-symbolic \
                -u low \
                "Night Light" "[OFF] Mode: Standard"
else
    wlsunset -T $TEMP > /dev/null 2>&1 &
    notify-send -h string:x-dunst-stack-tag:night_light \
                -i display-brightness-symbolic \
                -u low \
                "Night Light" "[ON] Mode: Eye Care (${TEMP}K)"
fi