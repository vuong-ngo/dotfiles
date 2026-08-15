#!/usr/bin/env bash

# ============================================================
# INSTALL DEPENDENCIES FOR RANGER FILE MANAGER
# Supports: Arch Linux (pacman), Debian/Ubuntu (apt), Fedora (dnf)
# Features: Archive compression/extraction tools, File previews,
# Clipboard integration, and Fast navigation helpers.
# ============================================================

set -e

# ANSI Color Codes
BOLD="\033[1m"
GREEN="\033[32m"
BLUE="\033[34m"
YELLOW="\033[33m"
RED="\033[31m"
RESET="\033[0m"

echo -e "${BOLD}${BLUE}=====================================================${RESET}"
echo -e "${BOLD}${BLUE}   Installing Ranger Dependencies & Preview Tools    ${RESET}"
echo -e "${BOLD}${BLUE}=====================================================${RESET}\n"

detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    else
        DISTRO="unknown"
    fi
}

install_arch() {
    echo -e "${BOLD}${YELLOW}[+] Arch Linux detected (pacman)${RESET}"
    
    # Package list for Arch
    PACKAGES=(
        ranger
        # Archives & Compression
        atool zip unzip tar gzip bzip2 p7zip unrar zstd xz
        # Previews & Inspection
        bat highlight jq poppler mediainfo ffmpeg perl-image-exiftool imagemagick chafa tree
        # Clipboard & GUI
        wl-clipboard xclip
        # Search & Navigation
        fzf ripgrep fd
    )

    echo -e "${GREEN}Running: sudo pacman -S --needed ${PACKAGES[*]}${RESET}\n"
    sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"
}

install_debian() {
    echo -e "${BOLD}${YELLOW}[+] Debian/Ubuntu detected (apt)${RESET}"
    
    # Package list for Debian/Ubuntu
    PACKAGES=(
        ranger
        # Archives & Compression
        atool zip unzip tar gzip bzip2 p7zip-full unrar zstd xz-utils
        # Previews & Inspection
        bat highlight jq poppler-utils mediainfo ffmpeg libimage-exiftool-perl imagemagick chafa tree
        # Clipboard & GUI
        wl-clipboard xclip
        # Search & Navigation
        fzf ripgrep fd-find
    )

    echo -e "${GREEN}Updating apt cache and installing packages...${RESET}\n"
    sudo apt update
    sudo apt install -y "${PACKAGES[@]}"
}

install_fedora() {
    echo -e "${BOLD}${YELLOW}[+] Fedora detected (dnf)${RESET}"
    
    PACKAGES=(
        ranger
        # Archives & Compression
        atool zip unzip tar gzip bzip2 p7zip unrar zstd xz
        # Previews & Inspection
        bat highlight jq poppler-utils mediainfo ffmpeg perl-Image-ExifTool ImageMagick chafa tree
        # Clipboard & GUI
        wl-clipboard xclip
        # Search & Navigation
        fzf ripgrep fd-find
    )

    echo -e "${GREEN}Running: sudo dnf install -y ${PACKAGES[*]}${RESET}\n"
    sudo dnf install -y "${PACKAGES[@]}"
}

detect_distro

case "$DISTRO" in
    arch|manjaro|endeavouros|garuda)
        install_arch
        ;;
    ubuntu|debian|pop|mint)
        install_debian
        ;;
    fedora|nobara)
        install_fedora
        ;;
    *)
        if command -v pacman >/dev/null 2>&1; then
            install_arch
        elif command -v apt >/dev/null 2>&1; then
            install_debian
        elif command -v dnf >/dev/null 2>&1; then
            install_fedora
        else
            echo -e "${RED}[!] Unsupported Linux distribution. Please install packages manually.${RESET}"
            exit 1
        fi
        ;;
esac

echo -e "\n${BOLD}${GREEN}=====================================================${RESET}"
echo -e "${BOLD}${GREEN}   All Dependencies Installed Successfully!          ${RESET}"
echo -e "${BOLD}${GREEN}=====================================================${RESET}\n"
echo -e "${BOLD}Summary of available keybindings in Ranger:${RESET}"
echo -e "  • ${YELLOW}<Space>${RESET}     : Toggle mark single file/directory"
echo -e "  • ${YELLOW}V / uV${RESET}      : Enter Visual mode to multi-select / deselect"
echo -e "  • ${YELLOW}va / <C-a>${RESET}  : Select ALL files/directories in current dir"
echo -e "  • ${YELLOW}uv / <C-d>${RESET}  : Deselect ALL files/directories"
echo -e "  • ${YELLOW}vt / vi${RESET}     : Invert current selection"
echo -e "  • ${YELLOW}cz${RESET}          : Compress selected to .zip"
echo -e "  • ${YELLOW}cg${RESET}          : Compress selected to .tar.gz"
echo -e "  • ${YELLOW}cx${RESET}          : Compress selected to .tar.xz"
echo -e "  • ${YELLOW}c7${RESET}          : Compress selected to .7z"
echo -e "  • ${YELLOW}ex / ax${RESET}     : Extract selected archive(s)"
echo -e "  • ${YELLOW}ep / ee${RESET}     : Export selected files to target directory"
echo -e "  • ${YELLOW}ey / yp${RESET}     : Copy full file path(s) to system clipboard"
echo -e "  • ${YELLOW}yn${RESET}          : Copy file name(s) to system clipboard"
echo -e "  • ${YELLOW}yd${RESET}          : Copy current folder path to clipboard"
echo -e "  • ${YELLOW}cw${RESET}          : Bulk rename selected files"
echo -e ""
