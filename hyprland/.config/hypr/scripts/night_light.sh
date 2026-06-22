#!/bin/bash

TEMP=4500

if pgrep -x "wlsunset" > /dev/null; then
    pkill -x wlsunset
    notify-send -h string:x-canonical-private-synchronous:night_light -i display-brightness "Night Light" "Status: Disabled"
else
    hyprctl dispatch exec "wlsunset -T $TEMP"
    notify-send -h string:x-canonical-private-synchronous:night_light -i display-brightness-symbolic "Night Light" "Status: Enabled"
fi