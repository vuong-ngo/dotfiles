# === FASTFETCH ===
fastfetch -c ~/.config/fastfetch/config_lightweight_arch.jsonc

# === CONFIGURE ===
autoload -Uz compinit
compinit

eval "$(starship init zsh)"

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
alias zshconfig="mate ~/.zshrc"
source ~/.config/niri/scripts/aliases.sh



