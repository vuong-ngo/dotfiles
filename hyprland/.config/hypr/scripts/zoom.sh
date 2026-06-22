#!/bin/bash

CURRENT_ZOOM=$(hyprctl getoption cursor:zoom_factor | grep "float:" | awk '{print $2}')

STEP="0.5"

case "$1" in
in)
    NEW_ZOOM=$(awk "BEGIN {print $CURRENT_ZOOM + $STEP}")
    hyprctl keyword cursor:zoom_factor $NEW_ZOOM
    ;;

out)
    NEW_ZOOM=$(awk "BEGIN {print $CURRENT_ZOOM - $STEP}")


    if awk "BEGIN {exit !($NEW_ZOOM <= 1.0)}"; then
        hyprctl keyword cursor:zoom_factor 1.0
    else
        hyprctl keyword cursor:zoom_factor $NEW_ZOOM
    fi
    ;;

reset)
    hyprctl keyword cursor:zoom_factor 1.0
    ;;

*)
    echo "Cách dùng: $0 {in|out|reset}"
    exit 1
    ;;
esac
