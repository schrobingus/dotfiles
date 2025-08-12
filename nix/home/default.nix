{ lib, pkgs, username, homeDir, dotDir, ... }: 

{
  home.username = username;
  home.homeDirectory = lib.mkForce homeDir;
  home.sessionVariables.DOTDIR = dotDir;

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    pfetch
    btop gh speedtest-cli
    devenv nurl
    bat fd pandoc ripgrep shellcheck tree zoxide
    czkawka fzf zk
    typst tinymist
    uv # gdal

    # TeX Packages
    (texliveSmall.withPackages (ps: with ps; [
      latexmk # Compiler
      changepage enumitem
      titlesec
      helvetic
    ]))

    # Haskell Packages
    haskell.compiler.ghc9102
    stack cabal-install zlib

    # TODO: move some of these packages over another nix import
  ] ++ (
    if pkgs.stdenv.isLinux then [
      # Linux Packages
      dconf2nix
      adw-gtk3 adwaita-icon-theme morewaita-icon-theme
      papirus-icon-theme qogir-icon-theme
      libnotify
    ] else [
      # macOS Packages
      macmon
    ]);

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    max-jobs = 4;
    cores = 4;
  };
}
