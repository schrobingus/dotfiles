{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    btop neofetch git vim wget
  ];
}
