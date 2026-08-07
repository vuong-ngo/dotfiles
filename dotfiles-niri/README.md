# 🖥️ Niri Wayland Environment (`dotfiles-niri`)

This directory contains the desktop environment configurations for the **Niri Wayland Scrollable Window Manager** on Arch Linux.

---

## 📁 Included Component Configurations

| Component | Path | Description |
| :--- | :--- | :--- |
| **Niri Compositor** | `.config/niri/` | Modular `config.kdl`, window rules, keybindings, and system management scripts. |
| **Rofi Rasi Menus** | `.config/rofi/` | Custom Rofi scripts for Clipboard Manager, Power Menu, and Wallpaper Selector. |
| **SwayNC** | `.config/swaync/` | Sway Notification Center style definitions and control center layout. |
| **Hyprlock** | `.config/hypr/hyprlock.conf` | Fast, GPU-accelerated lock screen with current wallpaper background. |

---

## ⚡ Helper Scripts in `.config/niri/scripts/`

- `volume.sh`: Volume control with OSD notifications via `wireplumber` / `wpctl`.
- `brightness.sh`: Display brightness control with OSD via `brightnessctl`.
- `airplane_mode.sh`: Toggles Wi-Fi and Bluetooth radio interfaces via `nmcli` & `rfkill`.
- `night_light.sh`: Toggles blue light filter / color temperature via `wlsunset` or `gammastep`.
- `power_mode.sh`: Toggles CPU power profiles (`performance`, `balanced`, `power-saver`).
- `keep_awake.sh`: Inhibits system idle / sleep during long tasks.
- `rofi_nvidia.sh`: Displays GPU statistics in Rofi.
- `toggle_keybinds.sh`: Toggles Niri keybindings overlay.

---

## 🛠️ Usage & Setup

Link desktop environment configurations to your home directory:

```bash
# Link Wayland desktop configs into ~/.config/
cp -rs ~/dotfiles/dotfiles-niri/.config/* ~/.config/

# Reload Niri live configuration
niri msg action load-config-file
```
