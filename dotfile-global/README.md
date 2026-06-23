# 🌍 Global System Configurations & Toolkits (`dotfile-global/`)

This directory contains configuration files and helper scripts that apply system-wide, regardless of which Wayland window manager (Niri, Hyprland, or Sway) is active. It covers terminal emulators, text editors, shell customizations, hardware monitors, performance indicators, and automated maintenance tasks.

---

## 📂 Directory Map

These files are situated under `.config/` (or in the root of the user home folder, in the case of `.zshrc`):

```text
dotfile-global/
├── .config/
│   ├── btop/             # Btop system monitor theme and options
│   ├── Code/             # Config visual code
│   ├── MangoHud/         # MangoHud gaming statistics overlay config
│   ├── nvim/             # LazyVim text editor configuration
│   ├── terminal/         # Configs for Kitty, Alacritty, and Foot terminals
│   ├── tmux/             # Tmux terminal multiplexer (with Vim-keybindings)
│   ├── yazi/             # Yazi terminal file manager settings and plugins
│   ├── clean.sh          # Disk cleanup automation script
│   ├── snapshot.sh       # System snapshot & boot menu updater script
│   ├── code-flags.conf   # GPU and ozone flags for VS Code on Wayland
│   └── electron-flags.conf # Ozone flags for Electron applications
└── .zshrc                # Zsh shell customization file
```

---

## 🔧 Component Explanations

### 1. Zsh Shell (`.zshrc`)
* Configured using **Oh My Zsh** and the `avit` theme.
* Features Vim-style keybindings in the terminal prompt command mode.
* Binds quick keys `Alt + H/J/K/L` for visual navigation.
* Displays system information using `fastfetch` upon shell initialization.
* Includes plugins for syntax highlighting and autocomplete predictions.

### 2. Neovim (`.config/nvim`)
* Customized using the **LazyVim** framework.
* Features optimized plugin loaders, custom status line configurations, fuzzy finder, LSP autocompletion, treesitter parsers, and custom keybindings for coding ergonomics.

### 3. Tmux Multiplexer (`.config/tmux`)
* Optimized status bar at the top to avoid overlap with Neovim status lines.
* Prefix bound to `Ctrl + a` for ergonomics.
* Supports visual indicator flags (Normal, Prefix, Visual modes).
* Read the detailed guide inside [tmux/README.md](file:///home/ngoducvuong/Documents/Projects/dotfiles/dotfile-global/.config/tmux/README.md).

### 4. Yazi File Manager (`.config/yazi`)
* Rust-based file manager featuring image, video, and PDF preview capabilities.
* Employs the `tokyonight` aesthetic flavor and `yatline-tokyo-night` theme bar.
* Includes custom plugins for displaying media info and file tags.

### 5. Terminal Configurations (`.config/terminal`)
* Config files for **Kitty**, **Alacritty**, and **Foot**.
* Employs custom font sizing, transparent/blurred background styles, and uniform Tokyo Night color schemes.

---

## 🧹 Custom Administrative Scripts

These custom scripts are saved in `.config/` to facilitate regular system maintenance:

### 1. Disk Space Cleaner ([clean.sh](file:///home/ngoducvuong/Documents/Projects/dotfiles/dotfile-global/.config/clean.sh))
An automated script to free up disk space on Arch Linux:
* Cleans old package downloads in `/var/cache/pacman/pkg/` using `paccache`.
* Automatically identifies and deletes orphaned packages (`pacman -Rns`).
* Reduces Systemd Journal log buffers to 50MB or last 2 days.
* Empties user thumbnails cache, trash files, and cached VS Code workspace caches.
* Removes broken symbolic links from `~/.local/bin/`.

### 2. System Snapshot Automator ([snapshot.sh](file:///home/ngoducvuong/Documents/Projects/dotfiles/dotfile-global/.config/snapshot.sh))
A system safety utility to handle system backups:
* Triggers **Timeshift** to create a manual system restore point.
* Automatically rebuilds the **GRUB** configuration (`grub-mkconfig`) so that the newly created snapshot is listed in the GRUB boot menu, allowing you to restore the system during boot if it fails to start.

---
*Maintained by **Vuong Ngo**.*
