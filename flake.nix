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
    nixvim-config.url = "github:schrobingus/nixvim-config";
  };

  outputs = { 
    self, 
    nixpkgs, 
    nix-darwin, 
    home-manager, 
    nixvim-config
  } @ inputs: let
    mkNixOSConfig = { 
      system, 
      extraHomeModules ? [], 
      extraNixOSModules ? [] 
    }: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in nixpkgs.lib.nixosSystem {
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
                {
                  home.packages = [
                    pkgs.home-manager
                    inputs.nixvim-config.packages.${system}.default
                  ];
                }
              ] ++ extraHomeModules;
            };
          }
        ];
      };

    mkDarwinConfig = { 
      system, 
      extraHomeModules ? [], 
      extraDarwinModules ? [] 
    }: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in nix-darwin.lib.darwinSystem {
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
                {
                  home.packages = [
                    pkgs.home-manager
                    inputs.nixvim-config.packages.${system}.default
                  ];
                }
              ] ++ extraHomeModules;
            };
          }
        ];
      };

    mkHomeConfig = { 
      system, 
      extraHomeModules ? [] 
    }: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        extraSpecialArgs = { inherit self; };
        modules = [
          ./nix/home/home.nix
          {
            nix.package = pkgs.nix;
            home.packages = [
              pkgs.home-manager
              inputs.nixvim-config.packages.${system}.default
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
