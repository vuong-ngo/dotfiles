#!/usr/bin/env bash
# Professional Wallpaper Picker for Swaybg & Hyprland/Sway
# Optimized for: Ngô Đức Vương (Systems Engineering Setup)

set -euo pipefail

# --- Configuration ---
WALL_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/wallpapers"
LOCK_BG="$HOME/.cache/current_wallpaper"
THEME="$HOME/.config/rofi/scripts/wallpaper-picker/wallpaper-picker.rasi"

# Check if directory exists
if [ ! -d "$WALL_DIR" ]; then
    notify-send -u critical "Error" "Wallpaper directory not found: $WALL_DIR"
    exit 1
fi

# 1. Scan for images safely (Handling spaces and special characters)
mapfile -d '' files < <(find "$WALL_DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) -print0 | sort -z)

if [ ${#files[@]} -eq 0 ]; then
    notify-send -u critical "Error" "No images found in $WALL_DIR"
    exit 1
fi

# 2. Prepare Rofi command with icon support
# Note: Using -show-icons allows Rofi to preview the wallpaper as an icon
ROFI_CMD=(rofi -dmenu -i -show-icons -p " Wallpaper" -theme "$THEME")

# 3. Build input for Rofi (Filename \0 icon \x1f FullPath)
selected_name=$(
    {
        for f in "${files[@]}"; do
            name=$(basename "$f")
            printf '%s\x00icon\x1f%s\n' "$name" "$f"
        done
    } | "${ROFI_CMD[@]}"
)

# Exit if escape or nothing selected
if [ -z "$selected_name" ]; then
    exit 0
fi

# 4. Resolve the Full Path
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

# 5. Update Cache for Lockscreen (Hyprlock/Swaylock)
mkdir -p "$(dirname "$LOCK_BG")"
ln -sf "$FULL_PATH" "$LOCK_BG"

# 6. Apply Wallpaper using swaybg
if command -v swaybg >/dev/null 2>&1; then
    # SYSTEMS LOGIC: Kill previous swaybg instances to prevent memory leaks
    pkill swaybg || true
    
    # Run swaybg in the background (detached)
    # Mode 'fill' is best for 16:9 laptop screens
    swaybg -i "$FULL_PATH" -m fill &
    
    notify-send "Wallpaper Applied" "$selected_name"
else
    notify-send -u critical "Error" "swaybg is not installed. Run: sudo pacman -S swaybg"
fi

exit 0
