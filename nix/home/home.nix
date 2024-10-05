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
    colmena devenv nurl
    bat fd ripgrep shellcheck zoxide
    fzf nap zk
    ueberzugpp
    typst tinymist
  ] ++ (
    if pkgs.stdenv.isLinux then [
      # Linux Packages
      dconf2nix
    ] else [
      # MacOS Packages
      asitop
    ]);

  # NOTE: Mind the potential `config.lib.file.mkOutOfStoreSymlink` prefix.
  home.file = {
    ".vimrc".source = ../../rc.vim; # TODO: overhaul vim config as nvim
    ".config/wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink ../../wezterm.lua;
    # FIXME: for some reason, the mkOutOfStoreSymlink flag aint doing anything here
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink ../../rc.zsh;
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
