{ config, self, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # gdal 
    luajit luarocks
    neofetch ripgrep vim wget
  ];

  # TODO: add brew formulae and casks

  programs.zsh.enable = true;

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nix.settings = {
    experimental-features = "nix-command flakes";
    max-jobs = 4;
    cores = 2;
  };

  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
