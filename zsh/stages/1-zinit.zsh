# Load zinit.
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if ! [ -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" > /dev/null 2>&1 || true
fi
source "${ZINIT_HOME}/zinit.zsh"

# Install OMZ's Git plugin.
zi snippet OMZP::git
zi cdclear > /dev/null 2>&1

# Install and configure syntax highlighting.
zinit light "zsh-users/zsh-syntax-highlighting"
## Below disables case sensitivity.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# Configure the tools for history substring searching.
zinit light "zsh-users/zsh-history-substring-search" 
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

