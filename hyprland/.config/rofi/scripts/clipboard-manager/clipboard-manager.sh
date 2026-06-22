#!/bin/bash

# Directory to store securely pinned items
PIN_DIR="$HOME/.cache/rofi_clipboard_pins"
mkdir -p "$PIN_DIR"

# Function to generate the list for Rofi
get_list() {
    # 1. Option to clear all (always at the top)
    echo "󰎟 Clear All (Keep pinned items)"
    
    # 2. Display pinned items (Icon 📌)
    for f in "$PIN_DIR"/*.preview; do
        [ -e "$f" ] || continue
        hash=$(basename "$f" .preview)
        preview=$(cat "$f")
        # Format: 📌 [Hidden Hash for script identification]: Preview content
        echo "📌 $hash: $preview"
    done

    # 3. Display data from cliphist (Icon )
    cliphist list | while IFS= read -r line; do
        echo "  $line"
    done
}

# Run Rofi with custom keybindings
# -kb-custom-1: Assign custom action 1 to Alt+P
# -kb-custom-2: Assign custom action 2 to Alt+D
RESULT=$(get_list | rofi -dmenu -i -p "󰅌 Clipboard" \
    -kb-custom-1 "alt+p" \
    -kb-custom-2 "alt+d" \
    -theme ~/.config/rofi/scripts/clipboard-manager/clipboard-manager.rasi)

EXIT_CODE=$?

# Exit if user presses Esc or selects nothing
[ -z "$RESULT" ] && exit 0

# ACTION: Clear all
if [ "$RESULT" == "󰎟 Clear All (Keep pinned items)" ]; then
    cliphist wipe
    notify-send -u normal "Clipboard" "Clipboard cleared\n(Pinned items are safe!)"
    exit 0
fi

# ACTION: Interact with PINNED items
if [[ "$RESULT" == 📌* ]]; then
    # Extract Hash (between 📌 icon and : mark)
    HASH=$(echo "$RESULT" | awk '{print $2}' | tr -d ':')
    
    if [ $EXIT_CODE -eq 0 ]; then
        # Press Enter -> Copy pinned content to clipboard
        cat "$PIN_DIR/$HASH.content" | wl-copy
        notify-send -u low "Clipboard" "Pinned item copied!"
        
    elif [ $EXIT_CODE -eq 11 ]; then
        # Press Alt+D -> Unpin (Delete file)
        rm -f "$PIN_DIR/$HASH.preview" "$PIN_DIR/$HASH.content"
        notify-send -u low "Clipboard" "Item unpinned."
    fi

# ACTION: Interact with NORMAL items (From Cliphist)
elif [[ "$RESULT" == * ]]; then
    # Remove "  " prefix to get standard cliphist ID
    CLIP_ID_PREVIEW="${RESULT:3}"
    
    if [ $EXIT_CODE -eq 0 ]; then
        # Press Enter -> Decode and copy
        echo "$CLIP_ID_PREVIEW" | cliphist decode | wl-copy
        
    elif [ $EXIT_CODE -eq 10 ]; then
        # Press Alt+P -> Pin this item
        # Generate an 8-character random hash to save the file
        HASH=$(date +%s%N | md5sum | head -c 8) 
        
        # Extract preview content (Ignore cliphist ID)
        PREVIEW=$(echo "$CLIP_ID_PREVIEW" | cut -f2-)
        
        # Save preview and content (decoded) files
        echo "$PREVIEW" > "$PIN_DIR/$HASH.preview"
        echo "$CLIP_ID_PREVIEW" | cliphist decode > "$PIN_DIR/$HASH.content"
        
        notify-send -u low "Clipboard" "📌 Pinned successfully!"
        
    elif [ $EXIT_CODE -eq 11 ]; then
        # Press Alt+D -> Delete item from cliphist
        echo "$CLIP_ID_PREVIEW" | cliphist delete
    fi
fi