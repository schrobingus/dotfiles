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
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config.url = "github:schrobingus/nixvim-config";
  };

  outputs = { 
    self, 
    nixpkgs, 
    nix-darwin, 
    home-manager, 
    colmena,
    nixvim-config
    } @ inputs: let
      homeManagerConfig = { pkgs, system, extraHomeModules ? [] }: {
        home.packages = [
          pkgs.home-manager
          inputs.nixvim-config.packages.${system}.default
        ];
        home.sessionVariables = {
          EDITOR = "nvim";
        };
        imports = [
          ./nix/home/default.nix
          ./nix/home/files.nix
        ] ++ extraHomeModules;
      };

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
              [ ./nix/nixos/default.nix ]
              ++ extraNixOSModules
              ++ [
                home-manager.nixosModules.home-manager {
                  home-manager.extraSpecialArgs = { inherit inputs; };
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.brent = homeManagerConfig {
                    inherit pkgs system extraHomeModules;
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
              [ ./nix/darwin/default.nix ]
              ++ extraDarwinModules
              ++ [
                home-manager.darwinModules.home-manager {
                  home-manager.extraSpecialArgs = { inherit inputs; };
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.brent = homeManagerConfig {
                    inherit pkgs system extraHomeModules;
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
              homeManagerConfig {
                inherit pkgs system extraHomeModules;
              }
            ];
          };

    in {
      # Specify target deployments in the below configuration.
      darwinConfigurations = {
        "chaos" = mkDarwinConfig {  # "chaos" is an M1 Macbook Air from 2020.
          system = "aarch64-darwin";
          extraDarwinModules = [
            ./nix/darwin/homebrew.nix
            ./nix/darwin/settings.nix
          ];
          extraHomeModules = [
            ./nix/home/git.nix
            ./nix/home/zsh.nix
          ];
        };
      };
      nixosConfigurations = {
        "thonk" = mkNixOSConfig {
          system = "x86_64-linux";
          extraNixOSModules = [
            {
              networking.hostName = "thonk";
            }
            ./nix/nixos/bootloaders/grub-efi.nix
            ./nix/nixos/hardware-configuration/x131e-chromebook.nix
            ./nix/nixos/interfaces/i3.nix
            ./nix/nixos/programs/base-cli.nix
            ./nix/nixos/programs/base-gui.nix
            ./nix/nixos/programs/portable-cli.nix
            ./nix/nixos/fonts.nix
          ];
          extraHomeModules = [
            ./nix/home/git.nix
            ./nix/home/zsh.nix
            ./nix/home/fonts.nix
            ./nix/home/xresources.nix
            ./nix/home/dunst.nix
          ];
        };
        "flakyvm-qemu" = mkNixOSConfig {
          system = "aarch64-linux";
          extraNixOSModules = [ 
            {
              networking.hostName = "flakyvm-qemu";
            }
            ./nix/nixos/bootloaders/systemd-boot-efi.nix
            ./nix/nixos/hardware-configuration/qemu.nix
            ./nix/nixos/interfaces/i3.nix
            ./nix/nixos/programs/base-cli.nix
            ./nix/nixos/programs/base-gui.nix
            ./nix/nixos/programs/portable-cli.nix
            ./nix/nixos/services/avahi.nix
            ./nix/nixos/services/seaweedfs.nix
            ./nix/nixos/services/spice-qemu.nix
            ./nix/nixos/fonts.nix
          ];
          extraHomeModules = [
            ./nix/home/git.nix
            ./nix/home/zsh.nix
            ./nix/home/fonts.nix
            ./nix/home/xresources.nix
            ./nix/home/dunst.nix
          ];
        };
        "tendollarhaircut" = mkNixOSConfig {
          system = "x86_64-linux";
          extraNixOSModules = [
            {
              networking.hostName = "tendollarhaircut";
            }
            ./nix/nixos/bootloaders/grub-efi.nix
            ./nix/nixos/hardware-configuration/tendollarhaircut.nix
            ./nix/nixos/interfaces/i3.nix
            ./nix/nixos/programs/base-cli.nix
            ./nix/nixos/programs/base-gui.nix
            ./nix/nixos/programs/portable-cli.nix
            ./nix/nixos/fonts.nix
          ];
          extraHomeModules = [
            ./nix/home/git.nix
            ./nix/home/zsh.nix
            ./nix/home/fonts.nix
            ./nix/home/xresources.nix
            ./nix/home/dunst.nix
          ];
        };
      };
    };
}
