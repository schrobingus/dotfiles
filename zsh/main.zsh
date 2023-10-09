ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if ! [ -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" > /dev/null 2>&1 || true
fi
source "${ZINIT_HOME}/zinit.zsh"

zi snippet OMZP::git
zi cdclear > /dev/null 2>&1

zinit light "zsh-users/zsh-syntax-highlighting"
# Below disables case sensitivity.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

zinit light "zsh-users/zsh-history-substring-search" 
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt interactive_comments

autoload -U colors && colors

# Credit for most of the prompt to Apeiros (gh: Apeiros-46B).
PS1='%F{0}%B%(0?.%K{4} .%K{1} )%(1j.$ .)%K{0}%f %~ %k%b '  ## Main Prompt
PS2='%K{4} %K{0}%B + %b%k '  ## Multiline Prompt
PS3='%K{4} %K{0}%B select %b%k '  ## Select Prompt
gitprompt() {
    if git status 2>&- 1> /dev/null; then
		branch="$(git -P branch | awk '{ print $2 }')"
		if [ "$(git -P diff)" ]; then
	    	 print "%K{0}%B $branch %F{0}%K{5} ± %k%f%b"
		else print "%K{0}%B $branch %F{0}%K{2} %k%f%b"
		fi; exit 0
    else exit 1; fi
}
precmd() {
    RPROMPT="$(gitprompt)"
}

if [ -x "$(command -v nix-env)" ]; then
    export NIX_PATH=$HOME/.nix-channel/bin:$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
    export PATH=/run/current-system/sw/bin:NIX_PATH:$PATH
fi

if [ -x "$(command -v home-manager)" ]; then
  . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

if [ -x "$(command -v nix-shell)" ]; then
    zinit light "spwhitt/nix-zsh-completions"
    zinit light "chisui/zsh-nix-shell"
fi

alias ls="ls --color=auto"

if [ -x "$(command -v doas)" ]; then
    export SUDO="doas"
elif [ -x "$(command -v sudo)" ]; then
    export SUDO="sudo"
else
    export SUDO="su -c"
fi

alias mi="$SUDO port install"
alias mr="$SUDO port uninstall --follow-dependencies"
alias mu="$SUDO port selfupdate && $SUDO port upgrade outdated"
alias ms="$SUDO port select --set" # Default package, followed by package to be set.
alias mc="$SUDO port -f clean --all"
alias mfc="$SUDO port -f clean --all all && $SUDO port -f uninstall inactive"

alias x86_sh="$env /usr/bin/arch -x86_64 /bin/zsh" # Rosetta shell alias.

alias nu="nix-channel --update && $SUDO nix-channel --update || true"
alias nrs="$SUDO nixos-rebuild switch"
alias nrb="$SUDO nixos-rebuild --upgrade boot"
#alias ndrs="darwin-rebuild switch"
alias ndrs="darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix"
alias nhs="home-manager switch"
alias nsh="nix-shell ~/.config/nixpkgs/shell.nix"
alias nc="nix-collect-garbage -d && sudo nix-collect-garbage -d && nix-store --gc && sudo nix-store --gc"

update-openasar() {
  wget -O /tmp/app.asar https://github.com/GooseMod/OpenAsar/releases/download/nightly/app.asar
  rm /Applications/Discord.app/Contents/Resources/app.asar || true
  mv /tmp/app.asar /Applications/Discord.app/Contents/Resources/app.asar
}

alias py="python3"
alias pym="python3 -m"
alias pyb="python3 -m build"
alias pyi="python3 -m pip install"
alias pyr="python3 -m pip uninstall"
alias venv="python3 -m venv venv"
alias venv_sh="zsh -c 'source venv/bin/activate'"

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

if [ -x "$(command -v nala)" ]; then
    export DEBIANFRONTEND="$SUDO nala"
else
    export DEBIANFRONTEND="$SUDO apt"
fi
alias ai="$DEBIANFRONTEND --no-install-recommends install"
alias ar="$DEBIANFRONTEND purge --auto-remove"
alias au="$DEBIANFRONTEND update && $DEBIANFRONTEND upgrade"
alias ac="$DEBIANFRONTEND autoclean && $DEBIANFRONTEND clean"

alias di="$SUDO dnf install"
alias dr="$SUDO dnf remove"
alias du="$SUDO dnf update"
alias zi="$SUDO zypper in"
alias zr="$SUDO zypper rm"
alias zu="$SUDO zypper dup"
