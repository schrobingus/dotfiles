{ config, pkgs, ... }:

{
  # Get some information about the user.
  home.username = "brent";
  home.homeDirectory = "/home/brent";

  # Release version.
  home.stateVersion = "22.05";

  # Load some imports.
  imports = [
    ./dconf.nix # DConf settings for GNOME. Disable if unused.
  ];

  # Set up ZSH.
  programs.zsh.enable = true;

  # Set up some environment variables for the session.
  home.sessionVariables = {
    EDITOR = "emacs"; # Set default editor to Emacs. 
    TERM = "kitty"; # Set default terminal to Kitty.
    # Comment out or adjust if not installed or preferred.
  };

  # Install some packages.
  home.packages = with pkgs; [
    dconf2nix # DConf to Nix Converter for Home Manager
    # emacs # Advanced Editor
    fet-sh pfetch # Minimal System Info
    # vimHugeX # Minimal Editor
    # vscodium code # Universal Editor
    # zsh # Minimal Shell

    # Python + Tools
    python39Full
    python39Packages.build
    python39Packages.pip
  ];

  # Start linking configs.
  home.file = {
    ".emacs.d/assets".source = ../../emacs/assets; # Emacs Assets
    #.".emacs.d/init.el".source = ../../emacs/init.el; # Emacs Init Script
    #".local/share/backgrounds/Marauder.jpg" = ../../wallpapers/Marauder.jpg;
    #".local/share/backgrounds/PaperlikeXCanoopsyRecolor.png" = ../../wallpapers/PaperlikeXCanoopsyRecolor.png;
    ".emacs.d/stages".source = ../../emacs/stages; # Emacs Staged Config
    ".emacs.d/themes".source = ../../emacs/themes; # Emacs Extra Themes
    ".config/gtk-3.0/gtk.css".source = ../../gtk.css; # GTK3 Configuration
    ".config/gtk-4.0/gtk.css".source = ../../gtk.css; # ^ Relinked for GTK4
    ".config/kitty/kitty.conf".source = ../../kitty; # Kitty Config
    ".vimrc".source = ../../vimrc; # Vim Config
    ".zshrc".source = ../../zshrc; # ZSH Config
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
