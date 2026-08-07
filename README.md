# 🌌 Arch Linux x Niri Wayland Dotfiles

A premium, keyboard-driven, high-performance dotfiles configuration built for **Arch Linux**, featuring the **Niri Wayland Scrollable Window Manager**, **Neovim IDE**, **VS Code**, **Foot Terminal**, **Tmux**, **Rofi Rasi Scripts**, and **Catppuccin Mocha / Graphite Minimalist Aesthetics**.

![Arch Linux](https://img.shields.io/badge/OS-Arch_Linux-blue?logo=arch-linux)
![Compositor-Niri_Wayland-cyan](https://img.shields.io/badge/Compositor-Niri_Wayland-cyan)
![Theme-Catppuccin_Mocha-purple](https://img.shields.io/badge/Theme-Catppuccin_Mocha-purple)
![Editor-Neovim_v0.12+-green?logo=neovim](https://img.shields.io/badge/Editor-Neovim_v0.12+-green?logo=neovim)
![Terminal-Foot_Terminal-black](https://img.shields.io/badge/Terminal-Foot_Terminal-black)
![License-MIT-yellow](https://img.shields.io/badge/License-MIT-yellow)

---

## 📐 Repository Structure & Architecture

The repository is modularly structured into core configuration buckets (`dotfiles-global`, `dotfiles-niri`, and `install-arch`) for clean deployment via GNU Stow or symlinking:

```
dotfiles/
├── README.md                          # Main repository documentation & guide
├── dotfiles-global/                   # Portable global CLI/GUI configurations
│   ├── README.md                      # Global tools overview & details
│   ├── .zshrc                         # Zsh profile, aliases & plugin sources
│   └── .config/
│       ├── btop/                      # System resource monitor config
│       ├── Code/                      # VS Code user settings & keybindings
│       ├── fastfetch/                 # System info fetch theme
│       ├── foot/                      # Foot terminal emulator config
│       ├── ranger/                    # File manager config & helper scripts
│       ├── starship.toml              # Starship prompt theme
│       ├── tmux/                      # Tmux terminal multiplexer & guide
│       ├── code-flags.conf            # Wayland flags for VS Code
│       └── electron-flags.conf        # Wayland flags for Electron apps
├── dotfiles-niri/                     # Wayland desktop environment configurations
│   ├── README.md                      # Desktop environment setup guide
│   └── .config/
│       ├── hypr/                      # Hyprlock screen locker configuration
│       ├── niri/                      # Niri compositor config & helper scripts
│       ├── rofi/                      # Rofi menus (Clipboard, Power, Wallpaper)
│       └── swaync/                    # Sway Notification Center styles
├── install-arch/                      # Automated Arch Linux installer scripts
│   ├── README.md                      # Installer scripts guide & manifest
│   ├── install_yay_AUR.sh             # Bootstraps yay AUR helper from source
│   ├── install_WM_niri.sh             # Full Niri Wayland ecosystem installer
│   ├── install_WM_hyprland.sh         # Full Hyprland ecosystem installer
│   ├── install_DE_gnome.sh            # Minimal GNOME desktop installer
│   ├── install_DE_KDE.sh              # Minimal KDE Plasma desktop installer
│   ├── install_driver_acer_nitro_...  # Intel + NVIDIA hybrid drivers
│   ├── install_fcitx5_bamboo.sh       # Vietnamese input method installer
│   ├── install_package_neovim.sh      # Neovim & LazyVim dependency installer
│   ├── install_package_gtk.sh         # GTK tools & system monitors installer
│   ├── install_package_yazi.sh        # Yazi terminal file manager installer
│   ├── install_shell_zsh.sh           # Zsh & Oh-My-Zsh installer
│   └── install_zram.sh                # ZRAM compressed memory optimizer
└── preview/                           # Desktop screenshots & media preview
```

---

## ✨ Core Features & Technical Highlights

### 1. Niri Wayland Window Manager (`dotfiles-niri`)
- **Scrollable Tiling Layout**: Unlimited horizontal workspace scrolling with dynamic column sizing.
- **Physics-Based Animations**: Smooth spring curve physics for window switching and workspace scrolling.
- **Glassmorphism & Transparency**: 100% transparent terminal backgrounds with rounded geometry (`geometry-corner-radius 12`).
- **Automated Helper Scripts**: Scripts in `.config/niri/scripts/` for volume, brightness, power modes, airplane mode, night light, and wallpaper switching.

### 2. Neovim & Vim Stack (`vim-stack` External Repository)
- **Dedicated Repository**: Neovim and Vim configurations are modularly managed in the **[vuong-ngo/vim-stack](https://github.com/vuong-ngo/vim-stack.git)** repository.
- **Ultra-Fast Neovim IDE**: Built on LazyVim with `blink.cmp` autocompletion, Mason LSP installer, Treesitter syntax highlighting, Conform format-on-save, Grug-far workspace search & replace, and Flash jump motions.
- **Zero-Plugin Native Vim**: Pure native Vimscript setup with `<leader>/` code commenting and zero third-party plugin bloat.
- **Absolute Line Numbers & Keymaps**: Native 1-to-1 absolute line numbers and synchronized `<Space>` Leader keymap workflows across Neovim, Vim, and VS Code.

### 3. Tmux Multiplexer (`dotfiles-global/.config/tmux`)
- **Prefix Key**: Remapped to `Ctrl+a` for ergonomic keyboard navigation.
- **Zero Typing Interference**: All navigation keys require the Prefix key so text editing in shells/editors is 100% clean and untouched.
- **Custom Dual-Tone Status Bar**: Dynamic status indicator showing active mode (NORMAL, PREFIX, VISUAL) and connected session badges.

### 4. Rofi Rasi Modules (`dotfiles-niri/.config/rofi`)
- **Clipboard Manager**: Integrated `cliphist` manager with permanent pinning (`Alt+P`), item unpinning (`Alt+D` / `Alt+X`), continuous multi-item session workflow, and a distinct red warning highlight for `Clear All History`.
- **Power Menu**: Minimalist icon launcher for lock, suspend, reboot, and poweroff.
- **Wallpaper Picker**: Visual wall selector with live preview and automatic `swaybg` wallpaper updates.

---

## ⌨️ Global Keybindings Reference

### 🖥️ Niri Window Manager
| Shortcut | Action |
| :--- | :--- |
| `Super + Return` | Open Foot Terminal |
| `Super + D` / `Super + Space` | Launch Rofi Application Menu |
| `Super + V` | Open Rofi Clipboard Manager |
| `Super + X` | Open Rofi Power Menu |
| `Super + W` | Open Rofi Wallpaper Picker |
| `Super + Q` | Close Active Window |
| `Super + H / J / K / L` | Move Window Focus (Left / Down / Up / Right) |
| `Super + Shift + H / J / K / L` | Move Window Position |
| `Super + R` | Resize Window Columns |
| `Super + F` | Toggle Window Fullscreen |
| `Super + Shift + F` | Toggle Window Floating State |

### ⚡ Neovim & VS Code
| Shortcut | Action |
| :--- | :--- |
| `<Space>` | Leader Key |
| `<leader>q` | Close Active Tab / Buffer (Instant 0ms) |
| `<leader>Q` | Quit All Windows |
| `H` / `L` | Switch to Previous / Next Tab |
| `Alt + 1..9` | Jump directly to Tab 1..9 |
| `<leader>e` | Toggle File Explorer |
| `Ctrl + P` / `<leader>ff` | Find Files |
| `Ctrl + F` / `<leader>fg` | Search Text in Project (Grep) |
| `<leader>sr` | Global Workspace Search & Replace |
| `<leader>ca` | LSP Code Action |
| `<leader>rn` | LSP Rename Symbol |
| `<leader>cf` | Format Document |
| `<leader>gg` | Open LazyGit Floating Window |
| `Ctrl + /` | Toggle Integrated Floating Terminal |

### 📟 Tmux Terminal Multiplexer
| Shortcut | Action |
| :--- | :--- |
| `Ctrl + a` | Prefix Key |
| `Prefix, h / j / k / l` | Focus Left / Down / Up / Right Pane |
| `Prefix, H / L` | Switch to Previous / Next Window |
| `Prefix, |` | Split Window Vertically |
| `Prefix, -` | Split Window Horizontally |
| `Prefix, Shift + H / J / K / L` | Resize Active Pane |
| `Prefix, v` | Enter Vim-Style Copy Mode |
| `Prefix, r` | Reload Tmux Configuration |

### 📋 Rofi Clipboard Manager
| Shortcut | Action |
| :--- | :--- |
| `Enter` | Copy selected item to clipboard & exit |
| `Alt + P` | Pin selected item permanently (preserves across clears) |
| `Alt + D` / `Alt + X` | Delete item from history / Unpin pinned item |
| `Row 0 (Red Highlight)` | `🚨 CLEAR ALL HISTORY` (Clears unpinned history) |

---

## 🛠️ Automated Setup & Installation

### Option 1: Automated Installation via `install-arch/`
If you are setting up a fresh Arch Linux system, use the modular scripts in [`install-arch/`](file:///home/ngoducvuong/Documents/projects/dotfiles/dotfiles/install-arch/README.md):

```bash
# 1. Clone dotfiles & vim-stack repositories
git clone https://github.com/vuong-ngo/dotfiles.git ~/dotfiles
git clone https://github.com/vuong-ngo/vim-stack.git ~/.config/nvim

# 2. Install AUR helper (yay)
cd ~/dotfiles/install-arch
chmod +x install_yay_AUR.sh
./install_yay_AUR.sh

# 3. Install Niri Wayland Environment & Developer Tools
chmod +x install_WM_niri.sh install_package_neovim.sh install_shell_zsh.sh
./install_WM_niri.sh
./install_package_neovim.sh
./install_shell_zsh.sh
```

---

### Option 2: Manual Symlinking / GNU Stow Deployment

```bash
# 1. Symlink Global Configurations
cp -rs ~/dotfiles/dotfiles-global/.config/* ~/.config/
cp -s ~/dotfiles/dotfiles-global/.zshrc ~/.zshrc

# 2. Symlink Niri Desktop Configurations
cp -rs ~/dotfiles/dotfiles-niri/.config/* ~/.config/

# 3. Clone Vim & Neovim Stack Repository
git clone https://github.com/vuong-ngo/vim-stack.git ~/.config/nvim

# 4. Reload Shell & Niri Compositor
source ~/.zshrc
niri msg action load-config-file
```

---

## 📜 License
This repository is licensed under the [MIT License](LICENSE). Free to use, modify, and distribute.
