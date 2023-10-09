{ config, pkgs, ... }:

let
  pkgsPython = p: with p; [
    pip
    black       ## Formatter for Editors
    build
    setuptools
    virtualenv

    yt-dlp
  ];
  pkgsRuby = r: with r; [
    rails
  ];
in
{
  imports = [ 
    <home-manager/nix-darwin>
  ];

  environment.systemPackages = with pkgs; [
    asciidoc gawk
    p7zip ffmpeg pandoc
    btop neofetch speedtest-cli
    vim wget

    (hiPrio gcc) gnumake clang
    automake autoconf
    meson ninja samurai
    dotnet-sdk #dotnet-runtime
    kotlin clojure
    lua luarocks fennel
    sbcl guile racket-minimal
    nodejs yarn
    (hiPrio ruby) rbenv bundler cocoapods
    rustc cargo
    go nim zig
    sassc
    swig
    
    (pkgs.python3.withPackages pkgsPython)
    (pkgs.ruby.withPackages pkgsRuby)
  ];

  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  programs.bash.enable = true;
  programs.zsh.enable = true;

  environment.loginShellInit = ''
	  if [ -e $HOME/.profile ]
	  then                       
		  . $HOME/.profile         
	  fi'';   

  system.stateVersion = 4;
}
