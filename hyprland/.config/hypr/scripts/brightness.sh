#!/bin/bash

# Execute brightness change
if [[ "$1" == "up" ]]; then
    brightnessctl -e4 -n2 set 5%+
elif [[ "$1" == "down" ]]; then
    brightnessctl -e4 -n2 set 5%-
fi

# Get the current brightness percentage
CURRENT=$(brightnessctl -m | cut -d, -f4 | sed 's/%//')

# Send notification
notify-send -h string:x-canonical-private-synchronous:brightness \
            -h int:value:"$CURRENT" \
            -i display-brightness \
            "Brightness" "${CURRENT}%"