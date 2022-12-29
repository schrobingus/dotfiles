# Load the home-manager PATH.
if [ -x "$(command -v home-manager)" ]; then
    export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
    export PATH=$PATH:$NIX_PATH
fi

# Load the Nix integration plugins.
if [ -x "$(command -v nix-shell)" ]; then
    zplug "spwhitt/nix-zsh-completions"
    zinit light "chisui/zsh-nix-shell"
fi

