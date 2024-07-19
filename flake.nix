{
  description = "Personal Nix Configuration";

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
    mkDarwinConfig = { system, extraHomeModules, extraDarwinModules ? {} }:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in 
        nix-darwin.lib.darwinSystem {
          system = system;
          specialArgs = { inherit self; };
          modules = 
            [ ./nix/darwin/configuration.nix ]
            ++ extraDarwinModules
            ++ [
              home-manager.darwinModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.brent = {
                  imports = [
                    ./nix/home/home.nix
                  ] ++ extraHomeModules;
                };
              }
            ];
        };
      mkHomeConfig = { system, extraHomeModules ? [] }: 
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in 
          home-manager.lib.homeManagerConfiguration {
            pkgs = pkgs;
            extraSpecialArgs = { inherit self; };
            modules = [
              ./nix/home/home.nix
              {
                nix.package = pkgs.nix;
                home.packages = [
                  pkgs.home-manager
                ];
              }
            ] ++ extraHomeModules;
          };
  in {
    # Each configuration is segregated by hostname.
    darwinConfigurations = {
      "chaos" = mkDarwinConfig {  # "chaos" is an M1 Macbook Air from 2020.
        system = "aarch64-darwin";
        extraDarwinModules = [];
        extraHomeModules = [ 
          ./nix/home/zsh.nix
        ];
      };
    };
    homeConfigurations = {
      "floppa" = mkHomeConfig { # "floppa" is a Lenovo Chromebook Duet (krane) running postmarketOS.
        system = "aarch64-linux";
        extraHomeModules = [
          ./nix/home/zsh.nix
        ];
      };
    };
  };
}
