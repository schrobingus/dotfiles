{ ... }:

{
  # NOTE: Mind the potential `config.lib.file.mkOutOfStoreSymlink` prefix.
  home.file = {
    ".vimrc".source = ../../rc.vim;
    ".zshrc".source = ../../rc.zsh;

    ".config/wezterm/wezterm.lua".source = ../../wezterm.lua;

    ".config/tt-schemes".source = builtins.fetchGit {
      url = "https://github.com/tinted-theming/schemes";
      rev = "61058a8d2e2bd4482b53d57a68feb56cdb991f0b";
    };
  };
}
