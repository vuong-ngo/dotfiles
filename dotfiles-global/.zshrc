# === FASTFETCH ===
fastfetch -c ~/.config/fastfetch/config_lightweight_arch.jsonc

# === CONFIGURE ===
autoload -Uz compinit
compinit
eval "$(starship init zsh)"

# === KEYBIND (VIM MODE & JK TO ESCAPE) ===
bindkey -v
export KEYTIMEOUT=15

# Map 'jk' and 'kj' in insert mode to switch to vicmd (Vim Normal Mode)
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode

bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char

# === FLAGS ===
# Compilation flags
export ARCHFLAGS="-arch $(uname -m)"

# === LANG ENVIRONMENT ===
# You may need to manually set your language environment
export LANG=en_US.UTF-8

# === DEFAULT EDITOR ===
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi
export VISUAL=nvim

# === PLUGINS ===
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# === ENVIRONMENT ===
# Added by Antigravity CLI installer
export PATH="/home/ngoducvuong/.local/bin:$PATH"
# Pyenv (manage python version)
# Java (manage java version)

# === ALIAS ===
alias zshconfig="nvim ~/.zshrc"
source ~/.config/niri/scripts/aliases.sh
