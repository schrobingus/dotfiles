{ config, pkgs, ... }:

{
  # Get some information about the user.
  home.username = "brent";
  home.homeDirectory = "/home/brent";

  # Release version.
  home.stateVersion = "22.05";

  # Set up ZSH.
  programs.zsh.enable = true;

  # Start linking configs.
  home.file.".zshrc".source = /home/brent/Git/dotfiles/zsh/.zshrc;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
