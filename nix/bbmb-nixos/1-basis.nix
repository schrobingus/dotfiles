{ config, pkgs, lib, ... }:

{
  # Allow the usage of proprietary packages.
  nixpkgs.config.allowUnfree = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Define the NixOS version.
  system.stateVersion = "unstable";
}
