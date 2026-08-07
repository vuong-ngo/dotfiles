# 🗺️ Tmux Configuration (Vim-Mode & Graphite Dark Arrow Theme)

A high-performance, minimalist Tmux configuration heavily optimized for **Neovim** integration and keyboard-driven workflows. It features a responsive dynamic status bar, seamless Vim navigation, and immediate keystroke execution.

---

## 🚀 Core Concept

To optimize ergonomics during long coding sessions, the default activation key (**Prefix**) has been remapped:
* **Default Prefix:** `Ctrl + b` ❌ (Disabled)
* **New Prefix:** `Ctrl + a`  (Much easier to reach, matches standard terminal layouts)

> 💡 **How to read shortcuts:** `Prefix, [Key]` means press `Ctrl + a`, release both keys, and then immediately press the next `[Key]`.

---

## ⌨️ Keybindings Manual (Comprehensive Guide)

### 1. Window & Session Management
Designed for large-scale workspace organization. Window indexing starts at `1` instead of `0` for direct layout alignment with your keyboard's number row.

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `Prefix, b` | Create New Window | Automatically opens the new window in the Current Working Directory (`cwd`). |
| `Prefix, B` | Create New Session | Instantly initializes a blank independent Tmux session. |
| `Prefix, (` | Previous Session | Switches to the previous active session. |
| `Prefix, )` | Next Session | Switches to the next active session. |

---

### 2. Pane Splitting, Navigation & Resizing
Divide and conquer your terminal real estate using standard Vim **H, J, K, L** layouts.

#### 🔸 Splitting Panes
* `Prefix, |` : Split pane **Vertically** (Side-by-side). Inherits current working directory.
* `Prefix, -` : Split pane **Horizontally** (Top-and-bottom). Inherits current working directory.
* `Prefix, c` : Close/Kill the currently focused pane.

#### 🔸 Pane Navigation
Navigate seamlessly between active panes using standard Vim keys (Prefix-driven to ensure zero interference when typing text):
* `Prefix, h` (or `Prefix, Ctrl+h`) : Move to the Left pane
* `Prefix, l` (or `Prefix, Ctrl+l`) : Move to the Right pane
* `Prefix, k` (or `Prefix, Ctrl+k`) : Move to the Upper pane
* `Prefix, j` (or `Prefix, Ctrl+j`) : Move to the Lower pane

#### 🔸 Window Switching
* `Prefix, H` : Switch to Previous Window
* `Prefix, L` : Switch to Next Window

#### 🔸 Pane Resizing
Press `Prefix` once, then press and hold **Shift + [H/J/K/L]**. The `-r` repeatable flag is enabled, allowing you to fine-tune sizes by tapping direction keys continuously without hitting the Prefix again.
* `Prefix, H` : Resize pane boundary to the Left (by 5 cells)
* `Prefix, L` : Resize pane boundary to the Right (by 5 cells)
* `Prefix, K` : Resize pane boundary Upward (by 5 cells)
* `Prefix, J` : Resize pane boundary Downward (by 5 cells)

---

### 3. Vim-Style Copy Mode & Clipboard
Full integration with system clipboards utilizing standard Vim navigation controls.

* **Enter Copy Mode:** Press `Prefix, v` (or `Prefix, [`).

Once the status bar at the top changes to the Purple **󰅍 Visual** banner, use the following keys to browse buffer history and copy data:

| Keybinding | Action |
| :--- | :--- |
| `h`, `j`, `k`, `l` | Standard character-by-character navigation (Left, Down, Up, Right). |
| `u` / `d` | Scroll Up / Scroll Down by half a page (Fast history review). |
| `w` / `b` | Skip Forward / Backward by a full word. |
| `e` | Jump directly to the end of the current word. |
| `v` | Begin text selection (Behaves exactly like `v` in Vim Visual Mode). |
| `V` | Begin line selection (Behaves exactly like `V` in Vim Visual Line Mode). |
| `Ctrl + v` | Toggle rectangular block selection (Visual Block Mode). |
| `y` | **Yank (Copy)** selected text to system clipboard and exit Copy Mode. |
| `Esc` | Cancel selection / Exit Copy Mode. |

---

### 4. System & Core Utilities
* `Prefix, r` : Hot-reload the `tmux.conf` configuration file without destroying active sessions. Triggers a transient `"Reloaded tmux config!"` notification message.
* **Full Mouse Support:** Enabled (`on`). You can natively scroll through log buffers, click to shift pane focus, or drag pane borders to resize layouts.
* **Instant Escape Response:** The key escape delay is bound directly to `0ms`, resolving lagging inputs when handling keystrokes in Neovim.

---

## 🎨 Dynamic Top Status Bar UI

The status bar is locked to the **Top** edge to avoid visual collision with Neovim's bottom statuslines. It actively switches colors based on your current input environment:

* ⬜ **Light Gray (Normal):** Standard idle/operational mode.
* 🟨 **Yellow (Prefix):** Triggered when `Ctrl + a` is pressed; indicating Tmux is awaiting a command.
* 🟪 **Purple (Visual):** Active when browsing terminal buffers or working inside Copy Mode.