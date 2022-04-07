
# Brent's Suckless Forks

This repository includes forks of DWM and ST, as well as configuration files for several programs (including Vim, Emacs, VSCode, etc).


## Installation

You can check the READMEs of each subdirectory for installation, but here are some commands for reference.
- To install the Stowed Dotfiles, run `git clone https://github.com/BrentBoyMeBob/dot-main ~/.dotfiles && cd ~/.dotfiles && stow ~/.dotfiles/local`.
- To install the Suckless forks afterwards, install the dependencies (command on Arch is `sudo pacman -S base-devel xorg dmenu feh xorg-xrdb xorg-xsetroot ttf-symbola pulseaudio picom`), and then run `cd ~/.dotfiles/dwm && make && sudo make install && cd ~/.dotfiles/st && make && sudo make install`.


## Credits

- The Cascadia Code Nerd Font (Caskaydia Cove) is used in these dotfiles.
- Credit to Lewis for the ZSH configuration, you can find it in his dotfiles [here](https://github.com/smartsyncing/dotfiles).
- All wallpapers were sourced from [Nord Theme Wallpapers](https://nordthemewallpapers.com/All/).
