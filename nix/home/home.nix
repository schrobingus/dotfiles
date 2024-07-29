{ config, pkgs, ... }: 

{
  home.username = "brent";
  home.homeDirectory = if pkgs.stdenv.isLinux then pkgs.lib.mkForce "/home/brent" else "/Users/brent";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    btop fd nurl speedtest-cli
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
    # ".config/iterm2/com.googlecode.iterm2.plist".source = config.lib.file.mkOutOfStoreSymlink ../../iterm2.plist;
    ".vimrc".source = ../../rc.vim; # TODO: overhaul vim config as nvim
    ".config/wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink ../../wezterm.lua;
    # FIXME: for some reason, the mkOutOfStoreSymlink flag aint doing anything here
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink ../../rc.zsh;

    # "Library/Application Support/Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink ../../vscode-settings.json; 
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    max-jobs = 1;
    cores = 1;
  };

  programs.git = {
    enable = true;
    userName = "schrobingus";
    userEmail = "brent.monning.jr@gmail.com";
    delta = {
      enable = true;
    };
  };
}
