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
  home.file.".config/Code".source = /home/brent/Git/dotfiles/code;
  home.file.".config/VSCodium".source = /home/brent/Git/dotfiles/code;
  home.file.".emacs.d/assets".source = /home/brent/Git/dotfiles/emacs/assets;
  #home.file.".emacs.d/init.el".source = /home/brent/Git/dotfiles/emacs/init.el;
  home.file.".emacs.d/stages".source = /home/brent/Git/dotfiles/emacs/stages;
  home.file.".emacs.d/themes".source = /home/brent/Git/dotfiles/emacs/themes;
  home.file.".vimrc".source = /home/brent/Git/dotfiles/vimrc;
  home.file.".local/share/backgrounds/dotfiles".source = /home/brent/Git/dotfiles/wallpapers;
  home.file.".Xresources".source = /home/brent/Git/dotfiles/Xresources;
  home.file.".zshrc".source = /home/brent/Git/dotfiles/zsh/.zshrc;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
