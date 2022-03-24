# Brent's Dynamic Window Manager
This fork of DWM tries to retain the simplicity of normal DWM, whilst making it look beautiful and more functional. The tiling is mostly vanilla, but has improvements such as the ability to move the window in the stack, and moving a new window off the stack initially.

## Installation
1. You'll need the dependencies for compiling DWM; you can fetch these in the `xorg` and `base-devel` groups on Arch Linux, and make sure that `dmenu`, `feh`, `xrdb`, `xsetroot`, `pulseaudio`, and `picom` are also installed.
2. Clone the GitHub repository to `~/.dotfiles`, a command for this is `git clone https://github.com/BrentBoyMeBob/dot-main ~/.dotfiles`.
3. Add the local dotfiles, I recommend linking them using GNU Stow, a simple command for this is `cd ~/.dotfiles && stow ~/.dotfiles/local`.
4. Go into `~/.dotfiles/dwm` and compile + install it using `make && sudo make install`, and feel free to revise the `config.h` to add your own modifications.

## Patches
- [Actual Fullscreen](https://dwm.suckless.org/patches/actualfullscreen/)
- [Attach Below](https://dwm.suckless.org/patches/attachbelow/)
- [Autostart](https://dwm.suckless.org/patches/autostart/)
- [Bar Height](https://dwm.suckless.org/patches/bar_height/)
- [Centered Window Name](https://dwm.suckless.org/patches/centeredwindowname/)
- [Drag MFACT](https://dwm.suckless.org/patches/dragmfact/)
- [Full Gaps](https://dwm.suckless.org/patches/fullgaps/)
- [Move Stack](https://dwm.suckless.org/patches/movestack/)
- [Self Restart](https://dwm.suckless.org/patches/selfrestart/)
- [XRDB (Xresources)](https://dwm.suckless.org/patches/xrdb/)