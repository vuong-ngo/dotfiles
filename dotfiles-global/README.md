# 🌐 Global Dotfiles Configuration (`dotfiles-global`)

This directory contains portable, system-agnostic CLI and GUI application configurations used across all desktop environments and terminal sessions.

---

## 📁 Included Component Configurations

| Component | Path | Description |
| :--- | :--- | :--- |
| **Zsh Shell** | `.zshrc` | Zsh profile with Autosuggestions, Syntax Highlighting, Starship prompt, and aliases. |
| **Foot Terminal** | `.config/foot/foot.ini` | Lightweight Wayland terminal emulator with Catppuccin Mocha theme & JetBrainsMono font. |
| **Tmux** | `.config/tmux/tmux.conf` | Multiplexer with `Ctrl+a` Prefix, Vim navigation, and top status bar. |
| **VS Code** | `.config/Code/User/` | User `settings.json` and `keybindings.json` with absolute line numbers & Vim mode. |
| **Starship** | `.config/starship.toml` | Fast, customizable prompt theme for Zsh/Bash. |
| **Btop** | `.config/btop/btop.conf` | Modern terminal resource monitor config. |
| **Ranger** | `.config/ranger/` | Console file manager with image previews and custom Rofi integration scripts. |
| **Fastfetch** | `.config/fastfetch/` | Lightweight system information fetch styling. |

---

## 🛠️ Usage & Setup

Link these configuration files to your home directory:

```bash
# Link config folders into ~/.config/
cp -rs ~/dotfiles/dotfiles-global/.config/* ~/.config/

# Link .zshrc profile
cp -s ~/dotfiles/dotfiles-global/.zshrc ~/.zshrc

# Clone Neovim & Vim Stack configuration repository
git clone https://github.com/vuong-ngo/vim-stack.git ~/.config/nvim
```
