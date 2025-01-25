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
    bat fd pandoc ripgrep shellcheck zoxide
    czkawka fzf zk
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

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    max-jobs = 4;
    cores = 4;
  };
}
