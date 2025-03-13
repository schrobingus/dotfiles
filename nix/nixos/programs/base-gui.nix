{ pkgs, ... }:

{
  # NOTE: when you start porting to sway, you may want to split this into two files (xorg, wayland)
  environment.systemPackages = with pkgs; [
    librewolf
    wezterm rxvt-unicode # alacritty
    vesktop
    mpv celluloid amberol # TODO: narrow
    zathura sioyek evince papers # TODO: narrow
    xfce.thunar nautilus # TODO: narrow
    gnome-font-viewer pavucontrol
    feh xsel lxappearance scrot
    xorg.xrandr xorg.xgamma
    maim xclip
  ];
}
