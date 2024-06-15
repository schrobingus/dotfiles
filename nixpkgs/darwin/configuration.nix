{ config, pkgs, lib, ... }:

let
  pkgsPython = p: with p; [
    pip
    black       ## Formatter for Editors
    build
    ipykernel
    setuptools
    virtualenv
    wheel

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
    asciidoc aria2 gawk
    p7zip ffmpeg pandoc
    btop neofetch speedtest-cli
    vim wget ripgrep

    (hiPrio gcc) gnumake clang
    automake autoconf
    meson ninja samurai
    crystal
    dotnet-sdk #dotnet-runtime
    emscripten
    kotlin clojure
    lua luarocks fennel
    sbcl guile racket-minimal
    (hiPrio ruby) rbenv bundler cocoapods
    rustc cargo rust-analyzer rustfmt clippy
    go nim zig
    sassc
    scons
    swig
    typst-lsp
    
    (pkgs.python312.withPackages pkgsPython)
    (pkgs.ruby.withPackages pkgsRuby)
  ];

  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  ## UID SETTING FOR MACOS SEQUOIA
  #nix.configureBuildUsers = true;
  #ids.uids.nixbld = lib.mkForce 30000;

  nix.settings = {
    "extra-experimental-features" = [ "nix-command" "flakes" ];
    max-jobs = 4;
    cores = 2;
  };

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
