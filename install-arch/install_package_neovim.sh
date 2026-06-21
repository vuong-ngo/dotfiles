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
echo -e "${GREEN}             Neovim Package Toolkit                ${NC}"
echo -e "${BLUE}====================================================${NC}\n"

# ------------------------------------------------------------------------------
# THE ULTIMATE PACKAGE LIST (CLI Based & Optimized for Nitro 5)
# ------------------------------------------------------------------------------
ESSENTIAL_TOOLS=(
    "neovim"           # Neovim - The Ultimate System Toolkit for Nitro 5
    "git"              # Version control system
    "nodejs"           # JavaScript runtime (for Neovim plugins)
    "npm"              # Node package manager (for Neovim plugins)
    "python-pip"       # Python package installer (for Neovim plugins)
    "python-pynvim"    # Python client for Neovim
    "unzip"            # For extracting plugin files
    "wget"            # For downloading plugins and tools
    "curl"            # For fetching plugin data and updates
    "tree-sitter"      # For enhanced syntax highlighting
    "ripgrep"         # Fast searching within Neovim
    "fd"               # Fast file searching (alternative to find)
    "fd-find"         # Another version of fd for compatibility
    "luarocks"        # Lua package manager (for Neovim plugins)
    "fzf"             # Fuzzy finder for Neovim
)

# ------------------------------------------------------------------------------
# EXECUTE INSTALLATION
# ------------------------------------------------------------------------------
echo -e "${YELLOW}[1/2] Syncing databases and deploying Neovim ecosystem...${NC}"
sudo pacman -Sy --needed "${ESSENTIAL_TOOLS[@]}"

# ------------------------------------------------------------------------------
# COMPLETION
# ------------------------------------------------------------------------------
echo -e "\n${BLUE}====================================================${NC}"
echo -e "${GREEN}[2/2] ✅ SYSTEM IS READY FOR WORK!${NC}"
echo -e "${BLUE}====================================================${NC}"