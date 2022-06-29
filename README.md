# My Simple Dotfiles
This includes a couple of pieces of software that are being used, including:
- My relatively packed Emacs config.
- A quick and simple ZSH config with some helpful features, avoiding what I don't need.
- A lean and catered Kitty config for my system.
- My small Vim config as a secondary editor alongside Emacs.
- Adapting to Mountain colorscheme.

Older dotfiles (including my Suckless forks) are stored in my own [dot-dump](https://github.com/BrentBoyMeBob/dot-dump) repository.

## Installation

**For those using Nix**

If you want to use my home-manager configuration, simply just symlink `nix/local` in my dotfiles to `~/.config/nixpkgs`, and edit the configuration to use your user rather than `brent`.

If you want to install all of my dotfiles for NixOS, symlink `nix/system.nix` to `/etc/nixos/system.nix`, and then import it in your `/etc/nixos/configuration.nix`.

**For those on other systems**

To install my local dotfiles, just execute `install`. Keep in mind that you will have to imperatively install all of the software listed above, which can vary between distro.
