# 💻 Arch Linux Dotfiles Suite (Niri + Hyprland + Sway)

This is a personal repository containing configuration files (dotfiles) for **Arch Linux**, optimized for high performance, smooth window transitions, and terminal productivity on Wayland. It features configurations for **Niri WM**, **Hyprland**, and **Sway WM**, alongside pre-configured Neovim, Tmux, Zsh, and system maintenance utilities.

---

## 📸 Desktop Previews

### 🌌 Niri Window Manager (Main)
![Niri Window Manager Preview](preview/preview-wm-niri-2026-06-20%2012-05-05.png)

### ⚡ Hyprland Window Manager
![Hyprland Window Manager Preview](preview/preview-wm-hyprland-2026-03-09%2019-48-10.png)

---

## 🌟 Key Features

* **Multiple Compositors**: Modular dotfiles for next-generation Wayland window managers:
  * **[Niri WM](file:///niri/README.md)**: A scrollable-tiling compositor with physics-based spring animations.
  * **[Hyprland](file:///hyprland/README.md)**: A highly-stylized dynamic tiling manager with smooth bezier transitions.
  * **[Sway WM](file:///sway/README.md)**: A robust, low-overhead tiling compositor behaving as an `i3` replacement.
* **NVIDIA & Wayland Optimizations**: Tailored settings ensuring Electron-based apps (VS Code, Discord, Obsidian) run with full hardware acceleration on hybrid Intel/NVIDIA laptop displays.
* **LazyVim Editor**: Pre-configured Neovim IDE setup with LSP completion, custom keymaps, and quick launch speeds.
* **Global CLI Productivity**: Zsh shell configs (Oh My Zsh, auto-suggestions, syntax-highlighting), **Tmux** terminal multiplexer, and **Yazi** file manager.
* **Automated Admin Scripts**: System cleanup (disk space reclaiming) and automated system snapshots (via Timeshift + GRUB update).

---

## 📂 Repository Structure

Click on the links below to access the dedicated README documentation for each environment:

```text
.
├── 🌌 niri/                  # Niri WM environment-specific configurations
│   └── 📄 README.md          -> Guide to Niri layout, gestures, and toggle scripts
├── ⚡ hyprland/              # Hyprland specific environment and waybar styling
│   └── 📄 README.md          -> Guide to Hyprland animations, rules, and Waybar themes
├── 🎋 sway/                  # Sway WM minimal environment configs
│   └── 📄 README.md          -> Guide to Sway keyboard shortcuts and portal setup
├── 🌍 dotfile-global/        # System-wide global configurations (Zsh, Neovim, Yazi, Tmux)
│   └── 📄 README.md          -> Guide to LazyVim, Yazi theme plugins, and maintenance scripts
├── 🛠️ install-arch/          # Automated post-install setup bash scripts
│   └── 📄 README.md          -> Step-by-step instructions for scripts deployment
└── 🖼️ preview/               # Screen captures directory
```

---

## 🚀 Quick Start Guide

### Prerequisites
* Operating System: **Arch Linux**
* Recommended AUR Helper: **`yay`** (can be installed using [install_yay_AUR.sh](file:///home/ngoducvuong/Documents/Projects/dotfiles/install-arch/install_yay_AUR.sh))
* Common Utilities: `kitty`, `neovim`, `tmux`, `yazi`, `rofi-wayland`, `swaync`, `hyprlock`, `hypridle`, `timeshift`.

### Installation & Symbolic Links Setup

To deploy these dotfiles, clone the repository and run symlink commands:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/vuong-ngo/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Deploy Global Configurations**:
   ```bash
   mkdir -p ~/.config
   
   # Symlink shells & system-wide configs
   ln -sf ~/dotfiles/dotfile-global/.zshrc ~/.zshrc
   ln -s ~/dotfiles/dotfile-global/.config/nvim ~/.config/nvim
   ln -s ~/dotfiles/dotfile-global/.config/tmux ~/.config/tmux
   ln -s ~/dotfiles/dotfile-global/.config/yazi ~/.config/yazi
   ln -s ~/dotfiles/dotfile-global/.config/btop ~/.config/btop
   ln -s ~/dotfiles/dotfile-global/.config/MangoHud ~/.config/MangoHud
   ln -sf ~/dotfiles/dotfile-global/.config/clean.sh ~/.config/clean.sh
   ln -sf ~/dotfiles/dotfile-global/.config/snapshot.sh ~/.config/snapshot.sh
   ```

3. **Deploy Window Manager of Choice**:
   * **For Niri**:
     ```bash
     ln -s ~/dotfiles/niri/.config/niri ~/.config/niri
     ln -s ~/dotfiles/niri/.config/hypr ~/.config/hypr
     ln -s ~/dotfiles/niri/.config/rofi ~/.config/rofi
     ln -s ~/dotfiles/niri/.config/swaync ~/.config/swaync
     ln -s ~/dotfiles/niri/.config/waybar ~/.config/waybar
     ```
   * **For Hyprland**:
     ```bash
     ln -s ~/dotfiles/hyprland/.config/hypr ~/.config/hypr
     ln -s ~/dotfiles/hyprland/.config/rofi ~/.config/rofi
     ln -s ~/dotfiles/hyprland/.config/swaync ~/.config/swaync
     ln -s ~/dotfiles/hyprland/.config/waybar ~/.config/waybar
     ```
   * **For Sway**:
     ```bash
     ln -s ~/dotfiles/sway/.config/sway ~/.config/sway
     ln -s ~/dotfiles/sway/.config/xdg-desktop-portal ~/.config/xdg-desktop-portal
     ln -s ~/dotfiles/sway/.config/xdg-desktop-portal-wlr ~/.config/xdg-desktop-portal-wlr
     ```

---

## 📄 License

This project is licensed under the **MIT License**. For details, please see the [LICENSE](file:///LICENSE) file.

---
*Maintained and customized by **Vuong Ngo** © 2026.*

