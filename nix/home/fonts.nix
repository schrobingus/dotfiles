{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cozette
  ];

  fonts.fontconfig.enable = true;
}
