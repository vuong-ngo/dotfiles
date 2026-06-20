#!/usr/bin/env bash

# ============================================================
# Script: Niri Clipboard Manager (with Persistent Pinning)
# Platform: Arch Linux x Niri (Wayland)
# Dependencies: cliphist, rofi-wayland, wl-clipboard
# ============================================================

# Directory to store pinned items (survives 'cliphist wipe')
PIN_DIR="$HOME/.cache/niri_clipboard_pins"
mkdir -p "$PIN_DIR"

# Theme path - Adjust to your setup
THEME="$HOME/.config/rofi/scripts/clipboard-manager/clipboard-manager.rasi"

# Function to generate the Rofi list
get_list() {
    echo "󰎟 Clear History (Keep Pins)"
    
    # 1. Show Pinned Items (📌)
    for f in "$PIN_DIR"/*.preview; do
        [ -e "$f" ] || continue
        hash=$(basename "$f" .preview)
        preview=$(cat "$f")
        echo "📌 $hash: $preview"
    done

    # 2. Show Normal History from Cliphist ()
    # Using 'head' to keep the list manageable
    cliphist list | head -n 50 | while read -r line; do
        echo " $line"
    done
}

# Run Rofi with custom keybindings:
# Alt+P (Pin) -> Custom 1 (Exit code 10)
# Alt+D (Delete/Unpin) -> Custom 2 (Exit code 11)
RESULT=$(get_list | rofi -dmenu -i -p "󰅌 Clipboard" \
    -kb-custom-1 "alt+p" \
    -kb-custom-2 "alt+d" \
    -mesg "Enter: Copy | Alt+P: Pin | Alt+D: Delete" \
    -theme "$THEME")

EXIT_CODE=$?

# Exit if no selection
[ -z "$RESULT" ] && exit 0

# --- ACTION: CLEAR HISTORY ---
if [[ "$RESULT" == "󰎟 Clear History"* ]]; then
    cliphist wipe
    notify-send -h string:x-dunst-stack-tag:clipboard -u normal "Clipboard" "History cleared! (Pins safe)"
    exit 0
fi

# --- ACTION: INTERACT WITH PINNED ITEMS ---
if [[ "$RESULT" == 📌* ]]; then
    # Extract Hash (The string between 📌 and :)
    HASH=$(echo "$RESULT" | awk '{print $2}' | tr -d ':')
    
    if [ $EXIT_CODE -eq 0 ]; then
        # ENTER -> Copy pinned content
        cat "$PIN_DIR/$HASH.content" | wl-copy
        notify-send -h string:x-dunst-stack-tag:clipboard -u low "Clipboard" "Pinned item copied! 📋"
        
    elif [ $EXIT_CODE -eq 11 ]; then
        # Alt+D -> Unpin
        rm -f "$PIN_DIR/$HASH.preview" "$PIN_DIR/$HASH.content"
        notify-send -h string:x-dunst-stack-tag:clipboard -u low "Clipboard" "Item unpinned. 🗑️"
    fi

# --- ACTION: INTERACT WITH NORMAL ITEMS ---
elif [[ "$RESULT" == * ]]; then
    # Strip the icon prefix
    RAW_DATA="${RESULT#* }"
    
    if [ $EXIT_CODE -eq 0 ]; then
        # ENTER -> Decode and copy to clipboard
        echo "$RAW_DATA" | cliphist decode | wl-copy
        notify-send -h string:x-dunst-stack-tag:clipboard -u low "Clipboard" "Copied to clipboard! 📋"
        
    elif [ $EXIT_CODE -eq 10 ]; then
        # Alt+P -> Pin the item
        HASH=$(date +%s%N | md5sum | head -c 8)
        # Save preview (truncated) and full content
        echo "${RAW_DATA:0:100}" > "$PIN_DIR/$HASH.preview"
        echo "$RAW_DATA" | cliphist decode > "$PIN_DIR/$HASH.content"
        notify-send -h string:x-dunst-stack-tag:clipboard -u low "Clipboard" "Pinned successfully! 📌"
        
    elif [ $EXIT_CODE -eq 11 ]; then
        # Alt+D -> Delete from history
        echo "$RAW_DATA" | cliphist delete
        notify-send -h string:x-dunst-stack-tag:clipboard -u low "Clipboard" "Removed from history. 🗑️"
    fi
fi