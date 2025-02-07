{ ... }:

{
  # NOTE: Mind the potential `config.lib.file.mkOutOfStoreSymlink` prefix if you want files to be linked directly.

  home.file = {
    ".vimrc".source = ../../config/vimrc;
    ".zshrc".source = ../../config/zshrc;
  };

  xdg.configFile = {
    "alacritty.toml".source = ../../config/alacritty.toml;
    "wezterm/wezterm.lua".source = ../../config/wezterm.lua;

    "wallpaper.jpg".source = ../../config/wallpaper.jpg;
    "dunst/dunstrc".source = ../../config/dunstrc;
    "i3/config".source = ../../config/i3-config;
    "i3status/config".source = ../../config/i3status-config;
    "picom.conf".source = ../../config/picom.conf;

    "tt-schemes" = {
      recursive = true;
      source = builtins.fetchGit {
        url = "https://github.com/tinted-theming/schemes";
        rev = "61058a8d2e2bd4482b53d57a68feb56cdb991f0b";
      };
    };
  };
}
