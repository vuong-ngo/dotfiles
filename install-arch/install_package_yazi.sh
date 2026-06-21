#!/usr/bin/env bash

# --- COLOR DEFINITIONS ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
LAVENDER='\033[0;35m'
NC='\033[0m'

# ==============================================================================
# TERMINAL COLOR CODES
# ==============================================================================

echo -e "${BLUE}====================================================${NC}"
echo -e "${GREEN}              Yazi Package Toolkit                 ${NC}"
echo -e "${BLUE}====================================================${NC}\n"

# ------------------------------------------------------------------------------
# THE ULTIMATE PACKAGE LIST (CLI Based & Optimized for Nitro 5)
# ------------------------------------------------------------------------------
ESSENTIAL_TOOLS=(
    "yazi"              # Yazi - The Ultimate System Toolkit for Nitro 5
    "ffmpeg"            # Multimedia framework for audio/video processing
    "ffmpegthumbnailer" # Fast video thumbnailer for previewing video files
    "python-pillow"     # Python Imaging Library (PIL) for image processing
    "7zip"              # High compression file archiver
    "jq"                # Command-line JSON processor for configuration management
    "poppler"           # PDF rendering library (for PDF manipulation and viewing)
    "fd"                # Simple, fast and user-friendly alternative to 'find'
    "ripgrep"           # Fast search tool for codebases and files
    "fzf"               # Command-line fuzzy finder for efficient file searching
    "zoxide"            # Smarter cd command with fuzzy matching
    "resvg"             # High-quality SVG rendering library
    "imagemagick"       # Image manipulation tool (for converting PDFs to images)
)

# ------------------------------------------------------------------------------
# EXECUTE INSTALLATION
# ------------------------------------------------------------------------------
echo -e "${YELLOW}[1/2] Syncing databases and deploying YAZI ecosystem...${NC}"
sudo pacman -Sy --needed "${ESSENTIAL_TOOLS[@]}"

# ------------------------------------------------------------------------------
# COMPLETION
# ------------------------------------------------------------------------------
echo -e "\n${BLUE}====================================================${NC}"
echo -e "${GREEN}[2/2] ✅ SYSTEM IS READY FOR WORK!${NC}"
echo -e "${BLUE}====================================================${NC}"
