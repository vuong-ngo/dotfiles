#!/bin/bash

case "$1" in
    up)
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    mic)
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        ;;
esac

# Get Volume and Status
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')
IS_MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "MUTED")
IS_MIC_MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -o "MUTED")

if [[ "$1" == "mic" ]]; then
    if [ -z "$IS_MIC_MUTED" ]; then
        notify-send -h string:x-canonical-private-synchronous:mic -i microphone-sensitivity-high "Microphone" "Enabled"
    else
        notify-send -h string:x-canonical-private-synchronous:mic -i microphone-sensitivity-muted "Microphone" "Muted"
    fi
else
    if [ -n "$IS_MUTED" ]; then
        notify-send -h string:x-canonical-private-synchronous:volume -i audio-volume-muted "Volume" "Muted"
    else
        notify-send -h string:x-canonical-private-synchronous:volume -h int:value:"$VOLUME" -i audio-volume-high "Volume" "${VOLUME}%"
    fi
fi