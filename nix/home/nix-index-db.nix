{ inputs, ... }:

{ # Comma and `nix-index-database` support.

  imports = [
    inputs.nix-index-database.homeModules.nix-index
  ];

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.nix-index-database.comma.enable = true;
}
