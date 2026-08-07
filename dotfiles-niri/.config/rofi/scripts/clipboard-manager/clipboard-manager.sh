#!/usr/bin/env bash

# ============================================================
# Script: Niri Clipboard Manager (Monochrome Icons Theme)
# Platform: Arch Linux x Niri (Wayland)
# Dependencies: cliphist, rofi-wayland, wl-clipboard
# ============================================================

# Directory to store pinned items (permanently saved until manually unpinned)
PIN_DIR="$HOME/.cache/clipboard_pins"
mkdir -p "$PIN_DIR"

THEME="$HOME/.config/rofi/scripts/clipboard-manager/clipboard-manager.rasi"

# Function to generate the Rofi list
get_list() {
  # 1. Clear Action
  echo "🚨 [CLEAR ALL HISTORY]"

  # 2. Show Pinned Items
  for f in "$PIN_DIR"/*.preview; do
    [ -e "$f" ] || continue
    preview=$(cat "$f")
    echo "📌 [PIN] $preview"
  done

  # 3. Show Normal History from Cliphist
  cliphist list | head -n 50 | while read -r line; do
    echo "󰅌  $line"
  done
}

# Continuous loop allowing multi-pinning & multi-unpinning in one session
while true; do
  RESULT=$(get_list | rofi -dmenu -i -u 0 -p "󰅌 " \
    -kb-custom-1 "Alt+p,Alt+P" \
    -kb-custom-2 "Alt+d,Alt+D,Alt+x,Alt+X" \
    -mesg "󰌌 Enter: Copy  |  📌 Alt+P: Pin  |  🗑️ Alt+D/Alt+X: Delete" \
    -theme "$THEME")

  EXIT_CODE=$?

  # Exit if no selection / user pressed Esc
  [ -z "$RESULT" ] && exit 0

  # --- ACTION 1: CLEAR HISTORY (Preserves Pinned Items) ---
  if [[ "$RESULT" == *"CLEAR ALL HISTORY"* ]]; then
    cliphist wipe
    notify-send -h string:x-dunst-stack-tag:clipboard -u normal "Clipboard" "History cleared! 🗑️ (Pinned items preserved)"
    continue
  fi

  # --- ACTION 2: INTERACT WITH PINNED ITEMS ---
  if [[ "$RESULT" == "📌 [PIN] "* ]]; then
    SELECTED_TEXT="${RESULT#📌 [PIN] }"
    TARGET_HASH=""

    for f in "$PIN_DIR"/*.preview; do
      [ -e "$f" ] || continue
      hash=$(basename "$f" .preview)
      preview=$(cat "$f")
      if [ "$preview" = "$SELECTED_TEXT" ]; then
        TARGET_HASH="$hash"
        break
      fi
    done

    if [ -n "$TARGET_HASH" ]; then
      if [ $EXIT_CODE -eq 0 ]; then
        cat "$PIN_DIR/$TARGET_HASH.content" | wl-copy
        notify-send -h string:x-dunst-stack-tag:clipboard -u low "Clipboard" "Pinned item copied! 📋"
        exit 0

      elif [ $EXIT_CODE -eq 11 ]; then
        rm -f "$PIN_DIR/$TARGET_HASH.preview" "$PIN_DIR/$TARGET_HASH.content"
        notify-send -h string:x-dunst-stack-tag:clipboard -u low "Clipboard" "Item unpinned. 🗑️"
        continue
      fi
    else
      # Fallback match if exact string match missed
      if [ $EXIT_CODE -eq 11 ]; then
        for f in "$PIN_DIR"/*.preview; do
          [ -e "$f" ] || continue
          hash=$(basename "$f" .preview)
          preview=$(cat "$f")
          if [[ "$SELECTED_TEXT" == *"$preview"* ]] || [[ "$preview" == *"$SELECTED_TEXT"* ]]; then
            rm -f "$PIN_DIR/$hash.preview" "$PIN_DIR/$hash.content"
            notify-send -h string:x-dunst-stack-tag:clipboard -u low "Clipboard" "Item unpinned. 🗑️"
            break
          fi
        done
        continue
      fi
    fi
    continue
  fi

  # --- ACTION 3: INTERACT WITH NORMAL HISTORY ITEMS ---
  if [[ "$RESULT" == *"󰅌 "* ]]; then
    RAW_DATA="${RESULT#*󰅌  }"

    if [ $EXIT_CODE -eq 0 ]; then
      echo "$RAW_DATA" | cliphist decode | wl-copy
      notify-send -h string:x-dunst-stack-tag:clipboard -u low "Clipboard" "Copied to clipboard! 📋"
      exit 0

    elif [ $EXIT_CODE -eq 10 ]; then
      CONTENT_HASH=$(echo "$RAW_DATA" | cliphist decode | md5sum | head -c 12)
      # Use cut -c to safely preserve UTF-8 Vietnamese characters
      SNIPPET=$(echo "$RAW_DATA" | cut -d' ' -f2- | tr -d '\r\n' | cut -c 1-75)

      echo "$SNIPPET" >"$PIN_DIR/$CONTENT_HASH.preview"
      echo "$RAW_DATA" | cliphist decode >"$PIN_DIR/$CONTENT_HASH.content"
      notify-send -h string:x-dunst-stack-tag:clipboard -u low "Clipboard" "Pinned successfully! 📌"
      continue

    elif [ $EXIT_CODE -eq 11 ]; then
      echo "$RAW_DATA" | cliphist delete
      notify-send -h string:x-dunst-stack-tag:clipboard -u low "Clipboard" "Removed from history. 🗑️"
      continue
    fi
  fi
done
