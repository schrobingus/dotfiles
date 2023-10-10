{ config, pkgs, ... }:

{
  imports = [];

  home.username = "brent";
  home.homeDirectory = "/Users/brent";
  home.stateVersion = "22.11";

  home.file.".config/iterm2/com.googlecode.iterm2.plist".source = config.lib.file.mkOutOfStoreSymlink ../iterm2.plist;
  home.file.".nixpkgs".source = config.lib.file.mkOutOfStoreSymlink ../nixpkgs;
  home.file.".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink ../kitty.conf;
  home.file.".ideavimrc".source = config.lib.file.mkOutOfStoreSymlink ../ideavimrc.vim;
  home.file.".vimrc".source = config.lib.file.mkOutOfStoreSymlink ../vimrc.vim;
  home.file."Library/Application Support/Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink ../vscode/settings.json;
  home.file.".config/zsh/".source = config.lib.file.mkOutOfStoreSymlink ../zsh;

  programs.zsh = {
    enable = true;
    # This mirrors what is in ~/.zshrc for stage configuration.
    # It also references the .profile at the start, since
    # it doesn't reference by default for some reason.
    initExtra = ''
      if [ -e "$HOME/.profile" ]; then                       
		    . $HOME/.profile         
	    fi
      
      . $HOME/.config/zsh/main.zsh

      if [ -e "$HOME/.config/zsh/personal.zsh" ]; then
        . $HOME/.config/zsh/personal.zsh
      fi
    '';
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.packages = with pkgs; [
    #dconf2nix
    pfetch
  ];

  programs.home-manager.enable = true;
}
