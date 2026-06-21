# === ZSH Configuration ===

# ===========================================
# Fastfetch
# ===========================================
fastfetch -c ~/.config/fastfetch/config_lightweight_arch.jsonc

# ===========================================
# Path to your Oh My Zsh installation.
# ===========================================
export ZSH="$HOME/.oh-my-zsh"

# ========== ZSH Options ==========

# ===========================================
# Themes
# ===========================================
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="avit"

# ===========================================
# Plugins
# ===========================================
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# ===========================================
# User configuration
# ===========================================
export PATH="$HOME/.local/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# ========== Set Editor Based on SSH Connection ==========
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch $(uname -m)"

# ===========================================
# Enable Vi mode for command line editing
# ===========================================
bindkey -v
export KEYTIMEOUT=1

# ===========================================
# Move char while holding "ALT"
# ===========================================
bindkey '^[[1;3D' backward-char
bindkey '^[h' backward-char

bindkey '^[[1;3C' forward-char
bindkey '^[l' forward-char

bindkey '^[[1;3A' up-line-or-history
bindkey '^[k' up-line-or-history

bindkey '^[[1;3B' down-line-or-history
bindkey '^[j' down-line-or-history

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

function zle-keymap-select() {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne "\e[1 q"
  else
    echo -ne "\e[5 q"
  fi
}
zle -N zle-keymap-select

echo -ne "\e[5 q"

# ===========================================
# Setup environment
# ===========================================

# Pyenv (manage python version)
# Java (manage java version)

# ===========================================
# Aliases
# ===========================================
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias performance="~/.config/niri/scripts/power_mode.sh"
alias clean-script="~/.config/clean.sh"
alias snapshot-script="~/.config/snapshot.sh"
