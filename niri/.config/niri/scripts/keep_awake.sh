#!/bin/bash

# ============================================================
# Script: Keep-Awake Toggle
# Platform: Arch Linux x Niri (Wayland)
# Dependency: hypridle, swaync
# ============================================================

LOCK_FILE="/tmp/niri_keep_awake.lock"

# ---- DISABLE KEEP-AWAKE MODE----
if [ -f "$LOCK_FILE" ]; then
    echo "Disabling keep-awake mode. Re-enabling hypridle..."
    
    rm -f "$LOCK_FILE"
    
    if ! pgrep -x "hypridle" > /dev/null; then
        hypridle &
    fi
    
    notify-send "Screen Mode" "Keep-Awake DISABLED (Screen will sleep normally)" -i display -h string:x-canonical-private-synchronous:niri-awake
    exit 0
fi

# ---- ENABLE KEEP-AWAKE MODE ----
echo "Inhibiting hypridle to keep the screen alive..."

touch "$LOCK_FILE"

pkill -x "hypridle"

notify-send "Screen Mode" "Keep-Awake ENABLED (Screen will stay alive)" -i display-brightness -h string:x-canonical-private-synchronous:niri-awake