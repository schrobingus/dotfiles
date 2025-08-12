{ config, dotDir, ... }:

{
  home.file = {
    ".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${dotDir}/config/vimrc";
    # ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${dotDir}/config/zshrc";
  };

  xdg.configFile = {
    # "alacritty.toml".source = config.lib.file.mkOutOfStoreSymlink "${dotDir}/config/alacritty.toml";
    "wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink "${dotDir}/config/wezterm.lua";
    "ghostty".source = config.lib.file.mkOutOfStoreSymlink "${dotDir}/config/ghostty";

    "wallpaper.jpg".source = config.lib.file.mkOutOfStoreSymlink "${dotDir}/config/wallpaper.jpg";
    "dunst/dunstrc".source = config.lib.file.mkOutOfStoreSymlink "${dotDir}/config/dunstrc";
    "i3/config".source = config.lib.file.mkOutOfStoreSymlink "${dotDir}/config/i3-config";
    "i3status/config".source = config.lib.file.mkOutOfStoreSymlink "${dotDir}/config/i3status-config";
    "picom.conf".source = config.lib.file.mkOutOfStoreSymlink "${dotDir}/config/picom.conf";
    "zsh/rc.zsh".source = config.lib.file.mkOutOfStoreSymlink "${dotDir}/config/zshrc";

    "tt-schemes" = {
      recursive = true;
      source = builtins.fetchGit {
        url = "https://github.com/tinted-theming/schemes";
        rev = "61058a8d2e2bd4482b53d57a68feb56cdb991f0b";
      };
    };
  };
}
