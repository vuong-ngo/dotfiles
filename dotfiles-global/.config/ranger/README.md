# Ranger File Manager Configuration & Manual (Plugin-Free & Conflict-Free)

A modern, robust, conflict-free, and completely **plugin-free** configuration for **Ranger File Manager** on Linux. Optimized for terminal users, Wayland/X11 environments, providing clean navigation, rich previews, full multi-selection operations, archiving, file exporting, clipboard synchronization, fuzzy search (`fzf`), content search (`ripgrep`), tab management, and extensive sorting modes.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Directory Structure](#directory-structure)
- [Installation & Dependency Setup](#installation--dependency-setup)
- [Keybindings Guide](#keybindings-guide)
  - [Directory Navigation (`g` Namespace)](#directory-navigation-g-namespace)
  - [Tab Management](#tab-management)
  - [Multi-Selection & Marking](#multi-selection--marking)
  - [Archive Compression](#archive-compression)
  - [Archive Extraction](#archive-extraction)
  - [File Export & Clipboard](#file-export--clipboard)
  - [Fuzzy Search & Native Extensions](#fuzzy-search--native-extensions)
  - [Sorting Controls](#sorting-controls)
  - [File Management & Actions](#file-management--actions)
  - [File Viewers & Applications](#file-viewers--applications)
- [Custom Native Python Commands](#custom-native-python-commands)
- [File Previews (`scope.sh`)](#file-previews-scopesh)
- [File Handlers (`rifle.conf`)](#file-handlers-rifleconf)

---

## 🔍 Overview

This configuration resolves all key conflicts in Ranger while keeping it **100% plugin-free**:
- **Clean `g` Namespace**: Dedicated exclusively to `cd` directory navigation and top of file list (`gg`).
- **Dedicated Tab Shortcuts**: Tab operations isolated to `<C-n>`, `<C-w>`, `<TAB>`, and `<S-TAB>`, avoiding `gc` (`cd ~/.config`) collisions.
- **Full Multi-Selection**: Visual marking (`V`), select all (`va`/`<C-a>`), deselect all (`uv`/`<C-d>`), invert selection (`vt`/`vi`), and regex pattern matching (`vm`).
- **Integrated Archiving**: One-key compression into `.zip`, `.tar.gz`, `.tar.xz`, `.tar`, `.7z`, and extraction.
- **File Exporting & Clipboard Sync**: Export files/folders to target directories and sync file paths directly with Wayland (`wl-copy`) or X11 (`xclip`).
- **Fuzzy & Content Search**: Native `fzf` file finder (`zf`) and `ripgrep` text content search (`zg`) built directly into Ranger.

---

## 📁 Directory Structure

```
~/.config/ranger/
├── rc.conf                # Main configuration & keybindings
├── rifle.conf             # File association execution matrix
├── commands.py            # Native Python extensions (compress, extract, export, fzf, mkcd, chmod)
├── README.md              # Documentation manual
├── scripts/               # Executable helper scripts
│   ├── install_deps.sh    # Dependency installer script (Arch, Debian/Ubuntu, Fedora)
│   └── scope.sh           # File preview script
├── plugins/               # Custom Python plugins directory
└── colorschemes/          # Custom color themes directory
```

---

## 🛠️ Installation & Dependency Setup

Run the automated installer [`scripts/install_deps.sh`](file:///home/ngoducvuong/.config/ranger/scripts/install_deps.sh) to install archive handlers, syntax highlighters, and search tools:

```bash
chmod +x ~/.config/ranger/scripts/install_deps.sh
~/.config/ranger/scripts/install_deps.sh
```

---

## ⌨️ Keybindings Guide

### Directory Navigation (`g` Namespace)

The `g` prefix is strictly isolated for navigation and movement:

| Keybinding | Target Destination / Action |
| :--- | :--- |
| `gg` | Move cursor to **Top of File List** |
| `G` | Move cursor to **Bottom of File List** |
| `gh` | Home directory (`~`) |
| `gc` | Configuration directory (`~/.config`) |
| `gd` | Downloads directory (`~/Downloads`) |
| `gp` | Projects directory (`~/Projects`) |
| `gw` / `gW` | Wallpapers directory (`~/.config/wallpapers`) |
| `gr` / `g/` | Root directory (`/`) |
| `ge` | System config directory (`/etc`) |
| `gm` | Media directory (`/media`) |
| `gM` | Mount point directory (`/mnt`) |
| `gi` | User removable media (`/run/media/$USER`) |
| `go` | Optional directory (`/opt`) |
| `gs` | Service data directory (`/srv`) |
| `gu` | User binaries directory (`/usr`) |
| `gv` | Variable data directory (`/var`) |

---

### Tab Management

Isolated to standard Ctrl and Tab controls to eliminate key conflicts:

| Keybinding | Action |
| :--- | :--- |
| `<C-n>` | Open **New Tab** |
| `<C-w>` | **Close** Current Tab |
| `<TAB>` | Move to **Next Tab** |
| `<S-TAB>` | Move to **Previous Tab** |

---

### Multi-Selection & Marking

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `<Space>` | **Toggle Mark Single** | Marks/unmarks current file and advances cursor |
| `V` | **Visual Mode** | Enters continuous visual selection mode |
| `uV` | **Visual Deselect Mode** | Enters visual mode to unmark items |
| `va` / `<C-a>` | **Select All** | Marks all files and directories in current folder |
| `uv` / `<C-d>` | **Deselect All** | Unmarks all files and directories |
| `vt` / `vi` | **Invert Selection** | Toggles selection state of all items |
| `vm` / `vs` | **Mark by Pattern** | Console prompt to mark matching items (e.g. `mark *.py`) |
| `um` | **Unmark by Pattern** | Console prompt to unmark matching items |
| `t` | **Tag Toggle** | Toggles tag on highlighted file |
| `ut` | **Untag All** | Removes tags from all files |

---

### Archive Compression

| Keybinding | Target Format | Executed Command |
| :--- | :--- | :--- |
| `cz` | `.zip` | `:compress %s.zip` |
| `cg` | `.tar.gz` | `:compress %s.tar.gz` |
| `cx` | `.tar.xz` | `:compress %s.tar.xz` |
| `ct` | `.tar` | `:compress %s.tar` |
| `c7` | `.7z` | `:compress %s.7z` |
| `cc` | Custom Prompt | Opens console prompt `:compress ` |

---

### Archive Extraction

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `ex` / `ax` | **Extract Here** | Extracts selected archive(s) into current directory |
| `eE` / `aE` | **Extract To...** | Opens prompt to extract archive(s) to a target folder |

---

### File Export & Clipboard

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `ep` / `ee` | **Export Items** | Prompt to copy selected items to target path (`:export <path>`) |
| `ey` / `yp` | **Copy Full Path(s)** | Copies absolute path(s) of marked items to clipboard |
| `yn` | **Copy File Name(s)** | Copies base name(s) of marked items to clipboard |
| `yd` | **Copy Directory Path** | Copies current folder path to clipboard |

---

### Fuzzy Search & Native Extensions

| Keybinding | Feature | Description |
| :--- | :--- | :--- |
| `zf` / `F` | **Fuzzy Find File** | Interactive file & directory finder using `fzf` |
| `zg` | **Fuzzy Ripgrep** | Search text content inside files using `ripgrep` + `fzf` |
| `mkd` | **Make Dir & CD** | Creates directory and automatically `cd` into it (`:mkcd`) |
| `cM` | **Chmod** | Change file permissions (`:chmod 755`, `:chmod +x`) |
| `zF` | **Toggle Flat View** | View subdirectories in flattened tree mode |

---

### Sorting Controls

| Keybinding | Sorting Criteria |
| :--- | :--- |
| `on` | Sort by **Natural Name** |
| `os` | Sort by **File Size** |
| `om` | Sort by **Modification Time (mtime)** |
| `oc` | Sort by **Creation Time (ctime)** |
| `oe` | Sort by **File Extension** |
| `ot` | Sort by **File Type** |
| `or` | **Reverse Sorting Direction** |

---

### File Management & Actions

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `dd` | **Cut** | Cuts marked files for moving |
| `yy` | **Copy** | Copies marked files for pasting |
| `pp` | **Paste** | Pastes copied/cut files |
| `po` | **Paste Overwrite** | Pastes files and overwrites existing files |
| `pL` | **Absolute Symlink** | Pastes absolute symbolic link |
| `pl` | **Relative Symlink** | Pastes relative symbolic link |
| `delete` | **Delete** | Opens console delete command |
| `cw` | **Bulk Rename** | Renames marked files using `$EDITOR` |
| `a` | **Rename** | Opens console to rename current file |
| `A` | **Append Name** | Appends text at end of file name |
| `I` | **Prepend Name** | Inserts text at start of file name |
| `zh` / `<C-h>` | **Toggle Hidden** | Shows or hides hidden files (`.dotfiles`) |

---

### File Viewers & Applications

| Keybinding | Handler / Action |
| :--- | :--- |
| `r` / `o` / `O` | Terminal native "Open With" menu |
| `e` / `E` | Edit file in default `$EDITOR` (Neovim/Vim) |
| `View` | Open image with `swayimg` / `mpv` |
| `M` | Open media file with `mpv` |
| `X` | Open with system default application (`xdg-open`) |

---

## 🐍 Custom Native Python Commands

Implemented in [`commands.py`](file:///home/ngoducvuong/.config/ranger/commands.py):

- **`:compress <name.zip>`**: Compresses selected files/folders.
- **`:extract [destination]`**: Unpacks archives.
- **`:export <destination>`**: Exports selected items to target path.
- **`:export_to_clipboard [paths|names]`**: Copies file paths or names to clipboard.
- **`:fzf_select`**: Fuzzy searches files and directories.
- **`:fzf_ripgrep`**: Searches text content inside files.
- **`:mkcd <dir>`**: Creates directory and enters it.
- **`:chmod <mode>`**: Changes file permissions.
