{ config, pkgs, ... }: 

{
  home.username = "brent";
  home.homeDirectory = if pkgs.stdenv.isLinux then pkgs.lib.mkForce "/home/brent" else pkgs.lib.mkForce "/Users/brent";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    btop speedtest-cli
    devenv nurl
    bat fd zoxide
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
