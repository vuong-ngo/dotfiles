# ⚡ Hyprland Window Manager Environment (`hyprland/`)

This directory houses configuration files for **Hyprland**, a highly customizable dynamic tiling Wayland compositor that does not sacrifice on aesthetics. It features fluent physics-based animations, clean window borders, layouts, and a modular architecture.

![Hyprland Window Manager Preview](preview/preview_01.png)

---

## 📂 Configuration Structure

The environment configurations are divided into modular sections under `.config/`:

```text
hyprland/.config/
├── hypr/
│   ├── hyprland.conf        # Main configuration file (sources modular configs)
│   ├── hypridle.conf        # Idle listener (dim, screen-lock, sleep)
│   ├── hyprlock.conf        # Custom graphical lockscreen
│   ├── config.d/            # Configuration blocks
│   │   ├── environments.conf# Wayland, driver, and application environments
│   │   ├── appearance.conf  # Active/inactive borders, gaps, shadows, active colors
│   │   ├── animations.conf  # Custom bezier curves and physics transitions
│   │   ├── autostart.conf   # Initial daemons and background tasks
│   │   ├── input.conf       # Keyboard layout, mouse acceleration, touchpad gestures
│   │   ├── monitors.conf    # Display resolutions, scaling, and layout positioning
│   │   ├── keybinds.conf    # Shortcuts for apps, workspaces, window control
│   │   └── rules.conf       # Window rules (floating, opacity, workspace placement)
│   └── scripts/             # System control bash scripts
├── rofi/                    # Rofi app launcher, clipboard, and control menus
├── swaync/                  # Sway Notification Center configuration
└── waybar/                  # Waybar status bar configuration (with themes)
```

---

## 🚀 Key Configurations

### 1. Modular Architecture (`config.d/`)
The [hyprland.conf](file:///hyprland/.config/hypr/hyprland.conf) imports configs from the `config.d/` folder using the `source` command:
* **[appearance.conf](file:///hyprland/.config/hypr/config.d/appearance.conf)**: Sets beautiful thin borders, active borders color gradients (Tokyo Night theme style), margins, and window roundings.
* **[animations.conf](file:///hyprland/.config/hypr/config.d/animations.conf)**: Declares custom `bezier` curves and controls transition speeds for workspaces, window spawning, scaling, and slide transitions.
* **[rules.conf](file:///hyprland/.config/hypr/config.d/rules.conf)**: Automates rules like floating for calculator and audio controllers, pinning dialog boxes, and assigning specific workspaces for heavy applications like web browsers or Discord.

### 2. Hardware and Environment Helpers (`hypr/scripts/`)
These custom helper scripts run in the background or are triggered by hardware keys:
* **`brightness.sh`**: Handles screen brightness adjustments and triggers notification bubbles.
* **`volume.sh`**: Controls sound volume (raise, lower, toggle mute) via `wpctl` or `pactl`.
* **`night_light.sh`**: Adjusts screen temperature based on time/triggers (uses `wlsunset` or similar).
* **`power_save_toggle.sh`**: Instantly toggles animations and low-power options to save laptop battery when unplugged.
* **`zoom.sh`**: Screen magnifier script.

---

## 🎨 System Bars & Graphical Menus

### 1. Waybar Status Bar (`waybar/`)
Waybar is heavily customized with selectable style profiles:
* **Themes**: Comes pre-configured with multiple themes (e.g. `catppuccin_mocha.css`, `neon.css`, `base.css`).
* **Modules**: Includes hardware indicators (CPU, memory, temperature, disk space), network strength, battery percentages, keyboard layout, workspace identifiers, and system clock.

### 2. Rofi Menus & Scripts (`rofi/`)
The launcher is customized with scripts for extended desktop interactivity:
* **`clipboard-manager`**: Keeps clipboard history via `cliphist` and lets you paste historical inputs via a fuzzy menu.
* **`power-menu`**: Graphical shutdown, reboot, lock screen, and log out helper.
* **`screenshot-menu`**: Quick trigger for capturing active monitors, selected regions, or focused windows.
* **`wallpaper-picker`**: Dynamic script to browse wallpapers and apply them via wallpaper daemons (`swaybg` / `hyprpaper`).

---
*Maintained by **Vuong Ngo**.*
