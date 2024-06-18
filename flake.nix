{
  description = "Personal Nix Darwin + Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin, nixpkgs, home-manager } @ inputs: let
    mkDarwin = { extraHomeManagerModules, extraDarwinModules ? {} }:
      nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit self; };
        modules = 
          [ ./nix/darwin/configuration.nix ]
          ++ extraDarwinModules
          ++ [
            home-manager.darwinModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.brent = {
                imports = extraHomeManagerModules;
              };
            }
          ];
      };
  in {
    darwinConfigurations = {
      # Each configuration is segregated by hostname.
      "chaos" = mkDarwin {  # "chaos" being my Macbook Air.
        extraDarwinModules = [];
        extraHomeManagerModules = [ 
          ./nix/home/home.nix
          ./nix/home/zsh.nix
        ];
      };
    };
  };
}
