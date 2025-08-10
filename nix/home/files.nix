{ config, ... }:

{
  # TODO: Mind the below. Make a helper that does an out of store symlink, and automatically assigns the full path.
  # NOTE: Mind the potential `config.lib.file.mkOutOfStoreSymlink` prefix if you want files to be linked directly. In order for this to work, the path must be both a string AND absolute.

  home.file = {
    ".vimrc".source = config.lib.file.mkOutOfStoreSymlink "/Users/brent/Sources/dotfiles/config/vimrc";
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/Users/brent/Sources/dotfiles/config/zshrc";
  };

  xdg.configFile = {
    # "alacritty.toml".source = config.lib.file.mkOutOfStoreSymlink "/Users/brent/Sources/dotfiles/config/alacritty.toml";
    "wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink "/Users/brent/Sources/dotfiles/config/wezterm.lua";
    "ghostty".source = config.lib.file.mkOutOfStoreSymlink "/Users/brent/Sources/dotfiles/config/ghostty";

    "wallpaper.jpg".source = config.lib.file.mkOutOfStoreSymlink "/Users/brent/Sources/dotfiles/config/wallpaper.jpg";
    "dunst/dunstrc".source = config.lib.file.mkOutOfStoreSymlink "/Users/brent/Sources/dotfiles/config/dunstrc";
    "i3/config".source = config.lib.file.mkOutOfStoreSymlink "/Users/brent/Sources/dotfiles/config/i3-config";
    "i3status/config".source = config.lib.file.mkOutOfStoreSymlink "/Users/brent/Sources/dotfiles/config/i3status-config";
    "picom.conf".source = config.lib.file.mkOutOfStoreSymlink "/Users/brent/Sources/dotfiles/config/picom.conf";

    "tt-schemes" = {
      recursive = true;
      source = builtins.fetchGit {
        url = "https://github.com/tinted-theming/schemes";
        rev = "61058a8d2e2bd4482b53d57a68feb56cdb991f0b";
      };
    };
  };
}
