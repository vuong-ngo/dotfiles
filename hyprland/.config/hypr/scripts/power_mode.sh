#!/bin/bash

# Target mode passed as the first argument (e.g., performance)
TARGET_MODE=$1

# Apply the power profile using the system daemon
powerprofilesctl set "$TARGET_MODE"

# Notify the user about the change
notify-send -h string:x-canonical-private-synchronous:power_profile \
            -i speedometer \
            "Power Mode" "Switching to: ${TARGET_MODE^^}"

# Reload SwayNC CSS/State to ensure the button lights up immediately
swaync-client -rs