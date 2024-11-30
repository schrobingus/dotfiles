{ config, pkgs, ... }: 

{
  home.username = "brent";
  home.homeDirectory = 
    if pkgs.stdenv.isLinux then 
      pkgs.lib.mkForce "/home/brent" 
    else 
      pkgs.lib.mkForce "/Users/brent";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    pfetch
    btop gh speedtest-cli
    devenv nurl
    bat fd pandoc ripgrep shellcheck zoxide
    czkawka fzf nap zk
    ueberzugpp
    typst tinymist

    # TeX Packages
    (texliveSmall.withPackages (ps: with ps; [
      latexmk # Compiler
      changepage enumitem
    ]))
    # TODO: move some of these packages over another nix import
  ] ++ (
    if pkgs.stdenv.isLinux then [
      # Linux Packages
      dconf2nix
    ] else [
      # MacOS Packages
      macmon
    ]);

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

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    max-jobs = 8;
    cores = 8;
  };

  programs.git = {
    enable = true;
    userName = "schrobingus";
    userEmail = "brent.monning.jr@gmail.com";
    delta.enable = true;
    extraConfig = {
      diff.tool = "nvimdiff";
      merge.tool = "nvimdiff1";
    };
  };
}
