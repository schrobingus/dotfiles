{ config, pkgs, ... }:

{
  # Get some information about the user.
  home.username = "brent";
  home.homeDirectory = "/home/brent";

  # Release version.
  home.stateVersion = "22.05";

  # Set up ZSH.
  programs.zsh.enable = true;

  # Install some packages.
  home.packages = [
    pkgs.jdk
  ];

  # Start linking configs.
  home.file.".config/Code".source = ../../code;
  home.file.".config/VSCodium".source = ../../code;
  home.file.".emacs.d/assets".source = ../../emacs/assets;
  #home.file.".emacs.d/init.el".source = ../../emacs/init.el;
  home.file.".emacs.d/stages".source = ../../emacs/stages;
  home.file.".emacs.d/themes".source = ../../emacs/themes;
  home.file.".vimrc".source = ../../vimrc;
  home.file.".local/share/backgrounds/dotfiles".source = ../../wallpapers;
  home.file.".zshrc".source = ../../zsh/.zshrc;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
