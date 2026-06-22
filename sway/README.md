# 🎋 Sway Window Manager Environment (`sway/`)

This directory contains configuration files for **Sway**, a high-performance tiling Wayland compositor designed as a drop-in replacement for the `i3` window manager. It provides clean, efficient workspace management with lower resource usage.

---

## 📂 Configuration Structure

Sway's configurations are split modularly under `.config/sway/`:

```text
sway/.config/
├── sway/
│   ├── config                 # Main configuration file (sources modular configs)
│   ├── config.d/              # Configuration segments folder
│   │   ├── 50-systemd-user.conf# Systemd user services integration
│   │   ├── appearance         # Gaps, border sizes, colors, and styling rules
│   │   ├── autostart          # Background daemons (wallpaper, notification, panels)
│   │   ├── environments       # Environment variables (Wayland compatibility, GTK theme)
│   │   ├── input              # Keyboard layouts, mouse acceleration, touchpad Gestures
│   │   ├── keybinds           # Shortcuts for application launchers, sizing, and workspaces
│   │   ├── monitor            # Screen resolution, scaling, and display positions
│   │   └── rules              # Custom rules (floating, layout behavior) for specific apps
│   └── scripts/               # Custom desktop utility scripts
│       └── screenshot-focused.sh # Grab screenshot of the focused window
├── xdg-desktop-portal/
│   └── wlr.conf               # XDG Desktop Portal fallback config
└── xdg-desktop-portal-wlr/
    └── config                 # Portal configuration optimized for wlroots
```

---

## 🚀 Key Configurations

### 1. Modular Config Design
The main [config](file:///home/ngoducvuong/Documents/Projects/dotfiles/sway/.config/sway/config) imports components from the `config.d/` directory:
* **`appearance`**: Configures window borders, gaps between adjacent windows, window shadows, and title bar fonts.
* **`keybinds`**: Standard `i3` keybindings (using `Mod4` / Super key) for layout switching, workspace navigation, window splitting, resizing, and killing active tasks.
* **`rules`**: Configures window properties (e.g. opens application controls, media players, or file dialogues in floating window layouts).

### 2. Desktop Portal Support (`xdg-desktop-portal-wlr/`)
Wayland needs a desktop portal to broker system-wide integrations like screensharing:
* **`xdg-desktop-portal-wlr`**: Specifically tailored for `wlroots`-based compositors (like Sway).
* Configuration allows modern applications (such as Discord, OBS Studio, and WebRTC-based browsers) to capture screen outputs and share individual windows securely on Wayland.

### 3. Focused Window Screenshot Utility (`sway/scripts/`)
Includes [screenshot-focused.sh](file:///home/ngoducvuong/Documents/Projects/dotfiles/sway/.config/sway/scripts/screenshot-focused.sh):
* Uses tools like `grim` (grab image) and `slurp` (select region) to dynamically locate the coordinates of the currently active focused window, capture it, and copy it directly to your system clipboard or save it to your Pictures directory.

---
*Maintained by **Vuong Ngo**.*
