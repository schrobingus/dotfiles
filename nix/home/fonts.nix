{ pkgs, ... }:

{
  home.packages = with pkgs; [
    geist-font
    nerd-fonts.geist-mono
    font-awesome
    cozette
  ];

  fonts.fontconfig.enable = true;
}
