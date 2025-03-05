{ pkgs, self, ... }:

{
  environment.systemPackages = with pkgs; [
    # gdal 
    colmena deploy-rs nix-output-monitor
    luajit luarocks
    neofetch ripgrep vim wget
    # xmrig p2pool # TODO: fix p2pool nixpkg for darwin. it's broken atm. xmrig is fine but you're using the brew formulae atm
  ];

  programs.zsh.enable = true;

  nix = {
    enable = true;
    package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes";
      max-jobs = 4;
      cores = 2;
    };
  };

  ids.gids.nixbld = 350;

  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
