{ config, pkgs, ... }:

let
  # Minimal Packages for Python
  pkgsPython = p: with p; [
    pip           # PyPi Package Manager
    build         # Build System
    setuptools    # Project Setuptools
    virtualenv    # Virtualenv Environment
  ];
in
{
  imports = [ 
    <home-manager/nix-darwin>
  ];

  # Add some packages to install.
  environment.systemPackages = with pkgs; [
    ## General Packages
    p7zip           # 7zip CLI Tool
    gawk            # GNU AWK
    btop            # System Monitor
    ffmpeg          # Video Conversion 
    neofetch        # System Information
    speedtest-cli   # Internet Speedtest
    vim             # Simple Text Editor
    youtube-dl      # YouTube Downloader

    ## Development Packages
    dotnet-sdk      # .NET SDK
    #dotnet-runtime # .NET Runtime
    lua luarocks    # Lua and Luarocks Package Manager
    fennel          # Fennel
    nodejs yarn     # JS Package Manager
    ruby cocoapods  # Ruby, RubyGems + Cocoapods
    
    ## Python Packages
    (pkgs.python3.withPackages pkgsPython)
  ];

  # Pair the Nix Darwin config with the rest of the Nix config.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.zsh.enable = true;

  environment.loginShellInit = ''
	  if [ -e $HOME/.profile ]
	  then                       
		  . $HOME/.profile         
	  fi'';   

  # Set Nix Dawin version.
  system.stateVersion = 4;
}
