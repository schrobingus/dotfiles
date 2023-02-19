# Color ls.
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
alias ms="$SUDO port select --set" # Default package, followed by package to be set.
alias mc="$SUDO port -f clean --all"
alias mfc="$SUDO port -f clean --all all && $SUDO port -f uninstall inactive"

alias x86_sh="$env /usr/bin/arch -x86_64 /bin/zsh" # Rosetta shell alias.

# Alias shortcuts for Nix and Home Manager.
alias nu="nix-channel --update && $SUDO nix-channel --update || true"
alias nrs="$SUDO nixos-rebuild switch"
alias nrb="$SUDO nixos-rebuild --upgrade boot"
#alias ndrs="darwin-rebuild switch"
alias ndrs="darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix"
alias nhs="home-manager switch"
alias nsh="nix-shell ~/.config/nixpkgs/shell.nix"
alias nc="nix-collect-garbage -d && nix-store --gc"

# Shortcut for updating OpenAsar (currently Mac only).
update-openasar() {
  wget -O /tmp/app.asar https://github.com/GooseMod/OpenAsar/releases/download/nightly/app.asar
  rm /Applications/Discord.app/Contents/Resources/app.asar || true
  mv /tmp/app.asar /Applications/Discord.app/Contents/Resources/app.asar
}

# Alias shortcuts for Python modules, Pip and Virtualenv.
alias py="python3"
alias pym="python3 -m"
alias pyb="python3 -m build"
alias pyi="python3 -m pip install"
alias pyr="python3 -m pip uninstall"
alias venv="python3 -m venv venv"
alias venv_sh="zsh -c 'source venv/bin/activate'"

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
## Also includes Reflector binding for mirrors.
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

