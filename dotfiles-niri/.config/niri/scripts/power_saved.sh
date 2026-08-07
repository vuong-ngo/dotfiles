#!/usr/bin/env bash

# ============================================================
# Script: Manual Extreme Power Save Toggle
# Description: Toggles extreme battery saving (CPU throttle + low brightness)
# ============================================================

show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTION]

Description:
  Toggles extreme manual power saving state. Reduces brightness to 20%
  and throttles CPU to power-saver profile when enabled. Restores
  balanced mode and 80% brightness when disabled.

Options:
  -h, --help    Show this help message and exit

Examples:
  $(basename "$0")       Toggle extreme power saver state
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    show_help
    exit 0
fi

LOCK_FILE="/tmp/niri_power_save_active"

if [ -f "$LOCK_FILE" ]; then
    rm -f "$LOCK_FILE"
    powerprofilesctl set balanced 2>/dev/null || true
    brightnessctl set 80% 2>/dev/null || true

    notify-send "Power System" "[RESTORED] Normal Mode (Balanced 80%)" \
                -i battery-full-symbolic \
                -h string:x-canonical-private-synchronous:niri-power
    exit 0
fi

touch "$LOCK_FILE"
powerprofilesctl set power-saver 2>/dev/null || true
brightnessctl set 20% 2>/dev/null || true

notify-send "Power System" "[ACTIVE] Extreme Saver (CPU Throttled 20%)" \
            -u critical \
            -i battery-caution-symbolic \
            -h string:x-canonical-private-synchronous:niri-power