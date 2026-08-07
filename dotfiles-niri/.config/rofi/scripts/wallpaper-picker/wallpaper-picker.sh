#!/usr/bin/env bash

# ============================================================
# Script: Rofi Wallpaper Picker (Monochrome Icons Theme)
# Platform: Arch Linux x Niri (Wayland)
# ============================================================

set -euo pipefail

WALL_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/wallpapers"
LOCK_BG="$HOME/.cache/current_wallpaper"
THEME="$HOME/.config/rofi/scripts/wallpaper-picker/wallpaper-picker.rasi"

if [ ! -d "$WALL_DIR" ]; then
    notify-send -u critical "Error" "Wallpaper directory not found: $WALL_DIR"
    exit 1
fi

mapfile -d '' files < <(find "$WALL_DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) -print0 | sort -z)

if [ ${#files[@]} -eq 0 ]; then
    notify-send -u critical "Error" "No images found in $WALL_DIR"
    exit 1
fi

ROFI_CMD=(rofi -dmenu -i -show-icons -p " Wallpaper" -theme "$THEME")

selected_name=$(
    {
        for f in "${files[@]}"; do
            name=$(basename "$f")
            printf '%s\x00icon\x1f%s\n' "$name" "$f"
        done
    } | "${ROFI_CMD[@]}"
)

if [ -z "$selected_name" ]; then
    exit 0
fi

FULL_PATH=""
for f in "${files[@]}"; do
    if [ "$(basename "$f")" = "$selected_name" ]; then
        FULL_PATH="$f"
        break
    fi
done

if [ -z "$FULL_PATH" ]; then
    notify-send -u critical "Error" "Path resolution failed for: $selected_name"
    exit 1
fi

mkdir -p "$(dirname "$LOCK_BG")"
ln -sf "$FULL_PATH" "$LOCK_BG"

if command -v swaybg >/dev/null 2>&1; then
    pkill swaybg || true
    swaybg -i "$FULL_PATH" -m fill &
    notify-send -h string:x-dunst-stack-tag:wallpaper "Wallpaper" "Applied: $selected_name"
else
    notify-send -u critical "Error" "swaybg is not installed."
fi

exit 0
