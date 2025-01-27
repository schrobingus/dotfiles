{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji-blob-bin
    cantarell-fonts
    liberation_ttf
    geist-font
  ];
}
