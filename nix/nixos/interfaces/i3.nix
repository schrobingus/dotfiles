{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager = {
      startx.enable = true;
      defaultSession = "none+i3";
    };
    desktopManager.xterm.enable = false;
    windowManager.i3.enable = true;
  };

  environment.systemPackages = with pkgs; [
    picom dunst i3lock i3status dmenu autotiling
  ];
}
