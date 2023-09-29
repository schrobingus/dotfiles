{ config, pkgs, ... }:

{
  home.username = "brent";
  home.homeDirectory = "/Users/brent";
  home.stateVersion = "22.11";

  imports = [];

  programs.zsh = {
    enable = true;
    # This mirrors what is in ~/.zshrc for stage configuration.
    # It also references the .profile at the start, since
    # it doesn't reference by default for some reason.
    initExtra = ''
      if [ -e $HOME/.profile ]
	    then                       
		    . $HOME/.profile         
	    fi
      for file in ~/.config/zsh/stages/*.zsh; do
        source $file
      done
    '';
  };

  home.sessionVariables = {
    EDITOR = "vim";
    #TERM = "kitty";
  };

  home.packages = with pkgs; [
    #dconf2nix
    pfetch
  ];

  programs.home-manager.enable = true;
}
