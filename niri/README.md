# 🌌 Niri Window Manager Environment (`niri/`)

This directory contains configuration files for **Niri**, a next-generation scrollable-tiling window manager for Wayland. It utilizes a modular structure, separating visual styles, inputs, monitor setups, and startup processes into dedicated sub-configs.

![Niri Window Manager Preview](../preview/preview-wm-niri-2026-06-20%2012-05-05.png)

---

## 📂 Configuration Structure

The configuration is modularized under `.config/niri/` to ensure ease of customization:

```text
niri/.config/
├── hypr/
│   ├── hypridle.conf        # Idle daemon (turns screen off, locks desktop)
│   └── hyprlock.conf        # Lockscreen configuration
├── niri/
│   ├── config.kdl           # Main entry point (includes other KDL configs)
│   ├── config.d/            # Config segments folder
│   │   ├── appearance.kdl   # Window borders, spacing, and styling
│   │   ├── animations.kdl   # Physics-based spring animations
│   │   ├── environments.kdl # Wayland, Qt/GTK, NVIDIA environment variables
│   │   ├── input.kdl        # Keyboard layout, mouse, and trackpad gestures
│   │   ├── keybinds-on.kdl  # Normal keybindings definition
│   │   ├── keybinds-off.kdl # Empty keybindings (used for passthrough mode)
│   │   ├── keybinds.kdl     # Active keybindings (symlinked dynamically)
│   │   └── monitor.kdl      # Monitor scaling, resolution, and refresh rate
│   └── scripts/             # Shell scripts for hardware and status bar integration
├── rofi/                    # Rofi app launcher, clipboard, and power menu
├── swaync/                  # Sway Notification Center configuration
└── waybar/                  # Waybar status bar configuration
```

---

## ⚡ Main Features

### 1. Modular Configurations (`config.d/`)
Instead of a single monolithic KDL file, configurations are loaded via the `include` directive in [config.kdl](file:///home/ngoducvuong/Documents/Projects/dotfiles/niri/.config/niri/config.kdl):
* **[environments.kdl](file:///niri/.config/niri/config.d/environments.kdl)**: Sets up variables for Electron apps to run natively on Wayland, sets theme cursors, and registers Fcitx5 for Vietnamese input.
* **[appearance.kdl](file:///niri/.config/niri/config.d/appearance.kdl)**: Configures layout parameters, gaps (active/inactive), and inactive/active border styling.
* **[animations.kdl](file:///niri/.config/niri/config.d/animations.kdl)**: Tailors smooth physics-based spring animations for window transitions and workspace scrolling.
* **[keybinds.kdl](file:///niri/.config/niri/config.d/keybinds.kdl)**: Maps keybindings for opening terminal emulator, launchers, layout modifications, and workspace switching.

### 2. Lock & Idle Manager (`hypr/`)
Uses the Hyprland security ecosystem for locking and power saving:
* **`hyprlock`**: A beautiful lockscreen that displays current time, password prompts, and is highly customized to load quickly.
* **`hypridle`**: Set up to automatically dim the screen, trigger lockscreen via `hyprlock` after inactivity, and turn off display outputs to conserve energy on laptop battery.

### 3. Dynamic Keybindings Toggler (VM & Gaming Mode)
Includes a custom script [toggle_keybinds.sh](file:///niri/.config/niri/scripts/toggle_keybinds.sh) bound to `Mod + Ctrl + Alt + K`. 
* **Normal Mode**: Active keybindings configuration symlinked to `keybinds-on.kdl`.
* **Passthrough Mode**: Symlinked to the empty `keybinds-off.kdl`, disabling all Niri hotkeys (except the toggle itself). Excellent when running virtual machines, playing keyboard-heavy video games, or using nested remote desktop connections.

---

## 🛠️ Hardware & Desktop Utility Scripts (`niri/scripts/`)

The following utilities manage hardware features directly via keyboard shortcuts or custom buttons:

| Script | Purpose | Command / Behavior |
| :--- | :--- | :--- |
| `airplane_mode.sh` | Network Toggle | Quickly toggles WiFi and Bluetooth RF-kill switches. |
| `brightness.sh` | Backlight Adjustment | Increases or decreases screen brightness via `brightnessctl` and sends system notification overlays. |
| `night_light.sh` | Night Light Toggle | Toggles blue light filtering using `wlsunset` for eye comfort. |
| `volume.sh` | Audio Management | Controls volume levels (Raise/Lower/Mute) with `pavucontrol` and CLI tools. |
| `keep_awake.sh` | Anti-idle Controller | Prevents system sleep and screen lock during long presentation tasks. |
| `rofi_nvidia.sh` | Prime GPU Launcher | Launches specific applications using the discrete NVIDIA graphics card. |

---

## 🎨 Accompanying Desktop Tools
* **Waybar**: Displays time, battery status, network connectivity, system temperature, CPU load, and active window name.
* **Sway Notification Center (SwayNC)**: A modern notification daemon with an interactive control center sidebar.
* **Rofi-Wayland**: Configured as a minimal, fast application list, clipboard monitor, and power menu.

---
*Maintained by **Vuong Ngo**.*
