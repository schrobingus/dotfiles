{ config, pkgs, ... }:

{
  # Get some information about the user.
  home.username = "brent";
  home.homeDirectory = "/home/brent";

  # Release version.
  home.stateVersion = "22.05";

  # Set up ZSH.
  programs.zsh.enable = true;

  # Set up some environment variables for the session.
  home.sessionVariables = {
    EDITOR = "emacs";
    TERM = "kitty";
  };

  # Install some packages.
  home.packages = with pkgs; [
    # emacs # Advanced Editor
    fet-sh pfetch # Minimal System Info
    # vimHugeX # Minimal Editor
    # vscodium code # Universal Editor
    # zsh # Minimal Shell

    # Python + Tools
    (python39.withPackages
      (pkgs: with pkgs; [
        build # Build System
        pip # Imperative Module Manager
      ])
    )
  ];

  # Start linking configs.
  home.file = {
    ".config/Code".source = ../../code; # VSCode Config
    ".config/VSCodium".source = ../../code; # ^ For OSS
    ".emacs.d/assets".source = ../../emacs/assets; # Emacs Assets
    #.".emacs.d/init.el".source = ../../emacs/init.el; # Emacs Init Script
    ".emacs.d/stages".source = ../../emacs/stages; # Emacs Staged Config
    ".emacs.d/themes".source = ../../emacs/themes; # Emacs Extra Themes
    ".config/kitty/kitty.conf".source = ../../kitty; # Kitty Config
    ".vimrc".source = ../../vimrc; # Vim Config
    ".zshrc".source = ../../zshrc; # ZSH Config
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
