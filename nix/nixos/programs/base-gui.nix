{ pkgs, ... }:

{
  # TODO: when you start porting to sway, you may want to split this into two files (xorg, wayland)
  environment.systemPackages = with pkgs; [
    librewolf
    wezterm # ghostty
    mpv celluloid amberol # TODO: narrow
    zathura evince papers # TODO: narrow
    xfce.thunar nautilus  # TODO: narrow
    gnome-font-viewer pavucontrol
    feh xsel lxappearance scrot
    maim xclip
  ];
}
