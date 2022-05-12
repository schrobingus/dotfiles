# My Simple Dotfiles
This includes a couple of pieces of software that are being used, including:
- My relatively packed Emacs config.
- A quick and simple ZSH config with some helpful features, avoiding what I don't need
- My Emacs-binded VSCodium / VSCode configuration for my Duet.
- Some local files for my GNOME setup (including settings for GNOME Terminal).
- My small Vim config as a secondary editor alongside Emacs.
- Some wallpapers from [Nord Theme Wallpapers](https://nordthemewallpapers.com/), as well as some fitting Mountain themed photos taken by `marauder#1639` on Discord.

Older dotfiles (including my Suckless forks) are stored in my own [dot-dump](https://github.com/BrentBoyMeBob/dot-dump) repository.

## Installation

**For those using Nix**

If you want to use my home-manager configuration, simply just symlink `nix/local` in my dotfiles to `~/.config/nixpkgs`, and edit the configuration to use your user rather than `brent`.

If you want to install all of my dotfiles for NixOS, symlink `nix/system` to `/etc/nixos/system`, and then put this in your `/etc/nixos/configuration.nix` in the `imports` section.

```
    ./system/1-basis.nix
    ./system/2-services.nix
    ./system/3-software.nix
```

**For those on other systems**

To install my local dotfiles, just execute `install`. Keep in mind that you will have to imperatively install all of the software listed above, which can vary between distro.
