{ pkgs, self, ... }:

{
  environment.systemPackages = with pkgs; [
    colmena deploy-rs morph nixos-rebuild 
    nix-output-monitor
    luajit luarocks
    neofetch ripgrep vim wget
    p7zip
  ];

  programs.zsh.enable = true;

  # TODO: this is commented because of determinate nix. make a conditional that adjusts as so
  /* nix = {
    enable = true;
    package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes";
      max-jobs = 4;
      cores = 2;
    };
  }; */
  nix.enable = false;
  
  # FIXME: this is specifically because of peazip. do a pr to nixpkgs. check home/default.nix
  nixpkgs.config.allowUnsupportedSystem = true;

  ids.gids.nixbld = 350;

  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.stateVersion = 4;

  # TODO: this is specifically because of the new darwin changes. make this argumentative
  system.primaryUser = "brent";

  nixpkgs.hostPlatform = "aarch64-darwin";
}
