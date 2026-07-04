# === FASTFETCH ===
fastfetch -c ~/.config/fastfetch/config_lightweight_arch.jsonc

# === OMZ - PATH ===
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# === THEMES ===
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# === PLUGINS ===
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# === MANPATH ===
# User configuration
export MANPATH="/usr/local/man:$MANPATH"

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

# === FLAGS ===
# Compilation flags
export ARCHFLAGS="-arch $(uname -m)"

# === ENVIRONMENT ===
# Pyenv (manage python version)
# Java (manage java version)

# === ALIAS ===
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
