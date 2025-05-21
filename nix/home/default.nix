{ pkgs, ... }: 

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
    bat fd pandoc ripgrep shellcheck tree zoxide
    czkawka fzf zk
    typst tinymist
    p7zip # peazip
    # gdal

    # TeX Packages
    (texliveSmall.withPackages (ps: with ps; [
      latexmk # Compiler
      changepage enumitem
      helvetic
    ]))
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
