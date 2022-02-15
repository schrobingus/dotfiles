
# Brent's Suckless Forks

These are forks of DWM and ST catered to my liking with different kinds of patches. Both forks are aimed at simplicity; the Simple Terminal fork is a plain and simple terminal emulator with your typical features you'd expect along with qualities such as ligatures, and the DWM fork improvises on vanilla's rudimentary tiling drastically for productivity, whilst also keeping it just as simplistic as vanilla, if not, more simple.


## Installation

For DWM:
1. You'll need the dependencies for compiling DWM; you can fetch these in the `xorg` and `base-devel` groups on Arch Linux, and make sure that `dmenu`, `feh`, `xrdb`, `xsetroot`, `pulseaudio`, and `picom` are also installed.
2. Clone the GitHub repository to `~/.suckless`, a command for this is `git clone https://github.com/BrentBoyMeBob/dot-suckless ~/.suckless`.
3. Add the local dotfiles, I recommend linking them using GNU Stow, a simple command for this is `cd ~/.suckless && stow ~/.suckless/local`.
4. Go into `~/.suckless/dwm` and compile + install it using `make && sudo make install`, and feel free to revise the config.h to add your own modifications; that being said, if you are using ST, use the instructions below next.

For ST:
1. There are no extra dependencies; you just need the typical ST dependencies, which are also in the `xorg` and `base-devel` groups on Arch Linux. 
2. (Skip if you've done the DWM instructions beforehand.) Clone the GitHub repository to anywhere you'd like, and enter the `st` directory.
3. Compile and install it using `make && sudo make install`, and once again, feel free to change config.h to your liking.


## Credits

- The Cascadia Code Nerd Font (Caskaydia Cove) is used in these dotfiles.
- Credit to Lewis for the ZSH configuration, you can find it in his dotfiles [here](https://github.com/smartsyncing/dotfiles).
