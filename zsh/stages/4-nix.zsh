# Load the Nix PATH.
if [ -x "$(command -v nix-env)" ]; then
    export NIX_PATH=$HOME/.nix-channel/bin:$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
    export PATH=/run/current-system/sw/bin:NIX_PATH:$PATH
fi

if [ -x "$(command -v home-manager)" ]; then
  . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

# Load the Nix Shell plugins.
if [ -x "$(command -v nix-shell)" ]; then
    zinit light "spwhitt/nix-zsh-completions"
    zinit light "chisui/zsh-nix-shell"
fi

