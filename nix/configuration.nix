# BrentBoyMeBob's NixOS Hardware Configuration
## This might not be what you're looking for; this is simply a file that
## configures my hardware in particular. Check the "bbmb-nixos" directory
## right next to this file for my NixOS setup. Note that it does not use
## Suckless anymore, I have switched to GNOME on Wayland. 

{ config, pkgs, ... }:

{
  imports =
    [ 
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix

      # Import my Nix system configuration.
      #./system/1-basis.nix
      #./system/2-services.nix
      #./system/3-software.nix
      ./system.nix
    ];

  # Use the latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use the GRUB-EFI boot loader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      version = 2;
    };
  };

  # Apply the kernel parameters. This AMD parameter is specific to my primary
  # laptop, the Dell G5 15 SE.
  boot.kernelParams = [ "amdgpu.runpm=0" ];

  networking.hostName = "reflections"; # Define your hostname.
  networking.wireless.enable = false; # Disable declarative networking.
  networking.networkmanager.enable = true; # Enable imperative networking.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp5s0.useDHCP = true;
  networking.interfaces.wlp6s0.useDHCP = true;

  # Utilize zsh as a shell.
  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = [ pkgs.zsh ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.brent = {
    isNormalUser = true;
    shell = pkgs.zsh; # Enable zsh.
    useDefaultShell = false;
    extraGroups = [ "wheel" "vboxusers" ]; # Enable ‘sudo’ for the user.
  };
}

