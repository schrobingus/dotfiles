{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  # Add some packages to install.
  environment.systemPackages = with pkgs; [
    btop            # System Monitor
    neofetch        # System Information
    vim             # Simple Text Editor
    speedtest-cli   # Internet Speedtest
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
