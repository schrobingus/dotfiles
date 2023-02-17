{ config, pkgs, ... }:

{
  # Some information that Home Manager needs.
  home.username = "brent";
  home.homeDirectory = "/Users/brent";

  # Home Manager version.
  home.stateVersion = "22.11";

  # Import some scripts for Home Manager.
  imports = [
    ./python.nix
  ];

  # Set up ZSH in Home Manager.
  programs.zsh = {
    enable = true;
    # This mirrors what is in ~/.zshrc for stage configuration.
    initExtra = ''
      if [ -e $HOME/.profile ]
	    then                       
		    . $HOME/.profile         
	    fi
      for file in ~/.config/zsh/stages/*.zsh; do
        source $file
      done
    '';
    # loginShellInit = ''
      # if [ -e $HOME/.profile ]
	    # then                       
		    # . $HOME/.profile         
	    # fi
    # '';   
  };

  home.sessionVariables = {
    EDITOR = "emacs"; # Set default editor to Emacs. 
    # TERM = "kitty"; # Set default terminal to Kitty.
    # Comment out or adjust if not installed, preferred, or has issues.
  };

  # Install some packages.
  home.packages = with pkgs; [
    # dconf2nix # DConf to Nix Converter for Home Manager
    # emacs # Advanced Editor
    pfetch # Minimal System Info
    # vim # Minimal Editor
    # zsh # Minimal Shell
    youtube-dl # Video Downloader
    
    # General Development Tools
    nodejs-19_x
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
