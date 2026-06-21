#!/usr/bin/env bash

# ==============================================================================
# SCRIPT: arch-clean.sh
# DESCRIPTION: Advanced system maintenance & junk removal for Arch Linux
# ==============================================================================

# --- Terminal Colors ---
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}====================================================${NC}"
echo -e "${GREEN}    🛡️  ARCH SYSTEM ARCHITECT - CLEANUP TOOL        ${NC}"
echo -e "${BLUE}====================================================${NC}"

# Function: Display space usage of Root partition
check_space() {
    df -h / | awk 'NR==2 {print $4}'
}

BEFORE=$(check_space)
echo -e "${YELLOW}Starting cleanup... Current free space: $BEFORE${NC}\n"

# ------------------------------------------------------------------------------
# 1. PACMAN PACKAGE MANAGER CLEANUP
# ------------------------------------------------------------------------------
echo -e "${BLUE}[1/5] Cleaning Pacman Cache...${NC}"

# Ensure pacman-contrib (which contains paccache) is installed
if ! command -v paccache &>/dev/null; then
    echo -e "${YELLOW}pacman-contrib not found. Installing dependency...${NC}"
    sudo pacman -S --noconfirm pacman-contrib
fi

# Double check if installation succeeded before running
if command -v paccache &>/dev/null; then
    # -r: Keeps 3 versions of installed | -rk1: Keeps 1 version of uninstalled
    sudo paccache -r
    sudo paccache -rk1
else
    echo -e "${RED}Skipping Pacman cache cleanup: pacman-contrib could not be installed.${NC}"
fi

# ------------------------------------------------------------------------------
# 2. REMOVE ORPHANED DEPENDENCIES
# ------------------------------------------------------------------------------
echo -e "\n${BLUE}[2/5] Scanning for Orphaned Packages...${NC}"

# Use mapfile to safely grab orphans into an array, preventing word-splitting bugs
mapfile -t ORPHANS < <(pacman -Qtdq 2>/dev/null)

if [ ${#ORPHANS[@]} -gt 0 ]; then
    echo -e "${YELLOW}Removing orphaned packages: ${ORPHANS[*]}${NC}"
    sudo pacman -Rns "${ORPHANS[@]}" --noconfirm
else
    echo -e "${GREEN}No orphaned packages found.${NC}"
fi

# ------------------------------------------------------------------------------
# 3. SYSTEMD JOURNAL TRIMMING
# ------------------------------------------------------------------------------
echo -e "\n${BLUE}[3/5] Vacuuming Systemd Journal Logs...${NC}"
# Retain either the last 2 days OR up to 50M of logs (whichever triggers first)
sudo journalctl --vacuum-time=2d
sudo journalctl --vacuum-size=50M

# ------------------------------------------------------------------------------
# 4. USER-LEVEL CACHE & TRASH (Safe Removal)
# ------------------------------------------------------------------------------
echo -e "\n${BLUE}[4/5] Cleaning User Cache & Junk...${NC}"

# Clean thumbnails safely
if [ -d "$HOME/.cache/thumbnails" ]; then
    find "$HOME/.cache/thumbnails" -type f -delete 2>/dev/null
fi

# Clean system trash bin completely without breaking the directory structure
if [ -d "$HOME/.local/share/Trash" ]; then
    rm -rf "$HOME/.local/share/Trash/files"/* 2>/dev/null
    rm -rf "$HOME/.local/share/Trash/info"/* 2>/dev/null
fi

# Clean VS Code cache safely if directory exists
if [ -d "$HOME/.config/Code/CachedData" ]; then
    find "$HOME/.config/Code/CachedData" -type f -delete 2>/dev/null
fi

echo -e "${GREEN}User-level junk cleaned.${NC}"

# ------------------------------------------------------------------------------
# 5. BROKEN SYMBOLIC LINKS
# ------------------------------------------------------------------------------
echo -e "\n${BLUE}[5/5] Removing Broken Symbolic Links...${NC}"
# Safely find and delete broken symlinks inside local bin directory
if [ -d "$HOME/.local/bin" ]; then
    find "$HOME/.local/bin" -xtype l -delete 2>/dev/null
fi

# ------------------------------------------------------------------------------
# SUMMARY
# ------------------------------------------------------------------------------
AFTER=$(check_space)
echo -e "\n${BLUE}====================================================${NC}"
echo -e "${GREEN}✅ CLEANUP FINISHED!${NC}"
echo -e "${YELLOW}Space before: $BEFORE | Space after: $AFTER${NC}"
echo -e "${BLUE}====================================================${NC}"
