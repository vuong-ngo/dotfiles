# 🛠️ Arch Linux Installation & Setup Scripts (`install-arch/`)

This directory contains automated installation shell scripts designed to set up desktop environments, window managers, shell frameworks, graphics drivers, hardware optimizations, and package toolkits on **Arch Linux**.

---

## 📂 Scripts Directory

These scripts allow you to build your system in a modular fashion, choosing what to install:

| Script Name | Purpose | Key Packages Installed / Configured |
| :--- | :--- | :--- |
| **`install_yay_AUR.sh`** | AUR Helper | Bootstraps `yay` AUR helper from source. |
| **`install_WM_niri.sh`** | Niri Environment | Installs `niri`, `xwayland-satellite`, `waybar`, `rofi-wayland`, `swaync`, `hyprlock`, `hypridle`, `cliphist`, `brightnessctl`, `pavucontrol`. |
| **`install_WM_hyprland.sh`** | Hyprland Environment | Installs `hyprland`, `waybar`, `rofi-wayland`, `swaync`, `hyprlock`, `hypridle`, `xdg-desktop-portal-hyprland`. |
| **`install_DE_gnome.sh`** | Minimal GNOME | Installs a minimal GNOME environment (`gnome-shell`, `nautilus`, `gdm`). |
| **`install_DE_KDE.sh`** | Minimal KDE | Installs a basic KDE Plasma desktop environment (`plasma-desktop`, `sddm`). |
| **`install_driver_acer_nitro_AN515-57_intel_nvidia.sh`** | Laptop Graphics Drivers | Installs Intel and NVIDIA hybrid graphics drivers, configured specifically for the Acer Nitro 5 laptop (`nvidia-open`, `lib32-nvidia-utils`, `optimus-manager`). |
| **`install_fcitx5_bamboo.sh`** | Vietnamese Input | Sets up Fcitx5 typing framework with `fcitx5-bamboo` layout and system-wide environment variables. |
| **`install_package_neovim.sh`** | Neovim Setup | Installs `neovim` (Neovim text editor) and core dependencies for LazyVim (compiler tools, `fzf`, `ripgrep`, language servers). |
| **`install_package_yazi.sh`** | Yazi File Manager | Installs `yazi` with preview tools like `ffmpegthumbnailer`, `poppler`, `fd`, `rg`, `imagemagick`, `zoxide`. |
| **`install_package_gtk.sh`** | Theme & GTK styling | Downloads and sets up unified GTK themes, Tokyo Night icons, cursor packs, and `nwg-look` style tools. |
| **`install_shell_zsh.sh`** | Zsh Terminal | Installs `zsh`, `oh-my-zsh`, and productivity plugins (`zsh-autosuggestions`, `zsh-syntax-highlighting`). |
| **`install_zram.sh`** | Memory Optimizer | Installs and configures ZRAM swap kernel module to improve multi-tasking performance. |

---

## 🚀 How to Use

> [!WARNING]
> Before running any system script, it is highly recommended to read through its contents to ensure compatibility with your specific hardware.

### Step 1: Install `yay` (First dependency)
To install packages from the Arch User Repository (AUR), you must have an AUR helper like `yay`. Run this script first:
```bash
chmod +x install_yay_AUR.sh
./install_yay_AUR.sh
```

### Step 2: Make the target script executable
By default, newly cloned scripts may not have execute permissions. Enable execution using `chmod`:
```bash
chmod +x install_WM_niri.sh
```

### Step 3: Run the script
Run the script. If the script requires root access, it will prompt for your user password via `sudo`:
```bash
./install_WM_niri.sh
```

---
*Maintained by **Vuong Ngo**.*
