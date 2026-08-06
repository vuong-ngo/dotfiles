#!/usr/bin/env bash

# ============================================================
# SCOPE SH - RANGER BUILT-IN PREVIEWER SCRIPT
# Handles text, image info, video metadata, archive contents
# ============================================================

set -o pipefail

FILE_PATH="${1}"         # Full path of selected file
PV_WIDTH="${2}"          # Preview width (columns)
PV_HEIGHT="${3}"         # Preview height (lines)
IMAGE_CACHE_PATH="${4}"  # Cache path for image preview
PV_IMAGE_ENABLED="${5}"  # Image preview status ("true"/"false")

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"

# ------------------------------------------------------------
# 1. TEXT & SOURCE CODE PREVIEWS
# ------------------------------------------------------------
handle_extension() {
    case "${FILE_EXTENSION_LOWER}" in
        # Archives
        zip) unzip -l "${FILE_PATH}" && exit 5 ;;
        tar|gz|bz2|xz) tar -tvf "${FILE_PATH}" && exit 5 ;;
        7z) 7z l "${FILE_PATH}" && exit 5 ;;
        rar) unrar l "${FILE_PATH}" && exit 5 ;;
        
        # Documents
        pdf) pdftotext -l 5 -layout "${FILE_PATH}" - && exit 5 ;;
        
        # JSON / Data Format
        json) jq '.' "${FILE_PATH}" 2>/dev/null && exit 5 ;;
    esac
}

handle_mime() {
    local mimetype="${1}"
    case "${mimetype}" in
        # Text Files
        text/* | */xml | */json | */javascript | */x-shellscript)
            if command -v bat >/dev/null 2>&1; then
                bat --color=always --style=plain --line-range :500 "${FILE_PATH}" && exit 5
            else
                head -n 500 "${FILE_PATH}" && exit 5
            fi
            ;;
            
        # Media / Video Information
        video/*)
            if command -v ffprobe >/dev/null 2>&1; then
                ffprobe -hide_banner "${FILE_PATH}" 2>&1 && exit 5
            fi
            echo "Video File: ${FILE_PATH}"
            exit 5
            ;;

        # Audio Information
        audio/*)
            if command -v mediainfo >/dev/null 2>&1; then
                mediainfo "${FILE_PATH}" && exit 5
            fi
            echo "Audio File: ${FILE_PATH}"
            exit 5
            ;;

        # Images
        image/*)
            echo "Image File: ${FILE_PATH}"
            if command -v file >/dev/null 2>&1; then
                file -b "${FILE_PATH}"
            fi
            exit 5
            ;;
    esac
}

MIMETYPE="$(file --dereference --brief --mime-type -- "${FILE_PATH}")"

handle_extension
handle_mime "${MIMETYPE}"

# Default fallback text preview
head -n 500 "${FILE_PATH}" && exit 5
exit 1
