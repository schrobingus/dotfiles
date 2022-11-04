# Load zplug.
#git clone https://github.com/zplug/zplug ~/.zplug > /dev/null 2>&1 || true
#source ~/.zplug/init.zsh

# Load zinit.
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if ! [ -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" > /dev/null 2>&1 || true
fi
source "${ZINIT_HOME}/zinit.zsh"

# Load the home-manager PATH.
if [ -x "$(command -v home-manager)" ]; then
	export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
	export PATH=$PATH:$NIX_PATH
fi

# Load the MacPorts binaries, as well as what's required for Android Studio.
export PATH=/opt/local/bin:/Users/brent/Library/Android/sdk/cmdline-tools/latest/bin:/Users/brent/Library/Android/sdk/platform-tools:/Users/brent/Sources/flutter/bin:/Users/brent/Library/Python/3.9/bin:$PATH

# Load the Nix integration plugins.
if [ -x "$(command -v nix-shell)" ]; then
	zplug "spwhitt/nix-zsh-completions"
	zinit light "chisui/zsh-nix-shell"
fi

# Configure the ZSH history.
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Allow interactive comments.
setopt interactive_comments

# Disable case sensitivity in autocompletion.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# Load colors.
autoload -U colors && colors

# Enable syntax highlighting and checking.
zinit light "zsh-users/zsh-syntax-highlighting"

# Add Git completion and aliases.
zi snippet OMZP::git
zi cdclear > /dev/null 2>&1

# Configure the tools for history substring searching.
zinit light "zsh-users/zsh-history-substring-search" 
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Load the Typewritten prompt.
git clone https://github.com/reobin/typewritten.git "$HOME/.zsh/typewritten" > /dev/null 2>&1 || true
fpath+=$HOME/.zsh/typewritten
autoload -U promptinit; promptinit
if [ "$IN_NIX_SHELL" = "" ]; then
	TYPEWRITTEN_SYMBOL="#"
else
	TYPEWRITTEN_SYMBOL=">"
fi
prompt typewritten

# Set the aliases for existing binutils.
alias ls="ls --color=auto"

# Find the Sudo or Sudo-like command.
if [ -x "$(command -v doas)" ]; then
     export SUDO="doas"
elif [ -x "$(command -v sudo)" ]; then
     export SUDO="sudo"
else
     export SUDO="su -c"
fi

# Alias specific shortcuts for MacPorts.
alias mi="$SUDO port install"
alias mr="$SUDO port uninstall --follow-dependencies"
alias mu="$SUDO port selfupdate && $SUDO port upgrade outdated"
alias mc="$SUDO port -f clean --all"
alias mfc="$SUDO port -f clean --all all && $SUDO port -f uninstall inactive"

alias x86_sh="$env /usr/bin/arch -x86_64 /bin/zsh" # Rosetta shell alias.

# Alias shortcuts for Nix and Home Manager.
alias nu="nix-channel --update && $SUDO nix-channel --update || true"
alias nrs="$SUDO nixos-rebuild switch"
alias nrb="$SUDO nixos-rebuild --upgrade boot"
alias nhs="home-manager switch"
alias nsh="nix-shell ~/.config/nixpkgs/shell.nix"
alias nc="nix-collect-garbage -d && nix-store --gc"

# Alias shortcuts for Python modules and Pip.
alias py="python3"
alias pym="python3 -m"
alias pyb="python3 -m build"
alias pyi="python3 -m pip install --user"
alias pyr="python3 -m pip uninstall"

# Alias specific shortcuts for Arch.
if [ -x "$(command -v paru)" ]; then
    export ARCHFRONTEND="paru"
elif [ -x "$(command -v yay)" ]; then
    export ARCHFRONTEND="yay"
else
    export ARCHFRONTEND="$SUDO pacman"
fi
alias pi="$ARCHFRONTEND -S"
alias pr="$ARCHFRONTEND -Rcns"
alias pu="$ARCHFRONTEND -Syu"
alias pc="$ARCHFRONTEND -Sc"
alias prfm="sudo reflector -f 5 --country 'United States' --protocol https --sort rate --save /etc/pacman.d/mirrorlist"

# Alias specific shortcuts for the worst distro.
if [ -x "$(command -v nala)" ]; then
    export DEBIANFRONTEND="$SUDO nala"
else
    export DEBIANFRONTEND="$SUDO apt"
fi
alias ai="$DEBIANFRONTEND --no-install-recommends install"
alias ar="$DEBIANFRONTEND purge --auto-remove"
alias au="$DEBIANFRONTEND update && $DEBIANFRONTEND upgrade"
alias ac="$DEBIANFRONTEND autoclean && $DEBIANFRONTEND clean"

# Alias specific shortcuts for DNF and Zypper.
alias di="$SUDO dnf install"
alias dr="$SUDO dnf remove"
alias du="$SUDO dnf update"
alias zi="$SUDO zypper in"
alias zr="$SUDO zypper rm"
alias zu="$SUDO zypper dup"

# Install PNPM.
export PNPM_HOME="/Users/brent/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
