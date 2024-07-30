{
  description = "Personal Nix Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nix-darwin, home-manager, nixvim } @ inputs: let
    mkNixOSConfig = { system, extraHomeModules, extraNixOSModules ? {} }:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
        nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = { inherit self; };
          modules = 
            [
              ./nix/nixos/system.nix
            ]
            ++ extraNixOSModules
            ++ [
              home-manager.nixosModules.home-manager {
                home-manager.extraSpecialArgs = { inherit inputs; };
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
                home-manager.extraSpecialArgs = { inherit inputs; };
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
        extraDarwinModules = [
          ./nix/darwin/homebrew.nix
          ./nix/darwin/settings.nix
        ];
        extraHomeModules = [ 
          ./nix/home/zsh.nix
          ./nix/home/nvim.nix
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
    nixosConfigurations = {
      "thonk" = mkNixOSConfig { # "thonk" is a Thinkpad X131e Chromebook running NixOS on Coreboot. It also cost only 45 dollars, what a bargain!
        system = "x86_64-linux";
        extraNixOSModules = [
          # TODO: figure out a way to handle cachix
          # /etc/nixos/cachix.nix
          ./nix/nixos/hardware-configuration.nix
        ];
        extraHomeModules = [
          ./nix/home/fonts.nix
          ./nix/home/zsh.nix
          ./nix/home/nvim.nix
        ];
      };
    };
  };
}
