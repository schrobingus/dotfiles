{ config, pkgs, lib, ... }:

{

  ## BASIS

  # Allow the usage of proprietary packages.
  nixpkgs.config.allowUnfree = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Define the NixOS version.
  #system.stateVersion = "22.05";
  system.stateVersion = "unstable";



  ## SERVICES

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true; # Allow the usage of proprietary packages.

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;



  ## SOFTWARE

  # Enable the GNOME Desktop Environment, but exclude any default extras.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-utilities.enable = false;

  # Configure external overlays and packages.
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

  # Configure Ungoogled Chromium to use Wayland.
  nixpkgs.config.ungoogled-chromium.commandLineArgs = "--enable-features=WebRTCPipeWireCapturer,UseOzonePlatform --ozone-platform=wayland";

  # Enable Flatpak for additional applications.
  services.flatpak.enable = true;

  # Enable support for GNOME in Blink.
  services.gnome.chrome-gnome-shell.enable = true;

  # Enable Virtualbox.
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  # Install some packages.
  environment.systemPackages = with pkgs; [
    authy # 2FA Client
    bitwarden # Password Manager
    celluloid # MPV Frontend
    cider # Apple Music Client
    emacsPgtkNativeComp # Advanced Editor
    fondo # Wallpaper Fetcher
    gnome.file-roller # Archive Tool
    gnome.gnome-disk-utility # Disk Checking Tool
    gnome.gnome-tweaks # Tweak Tool
    gnome.gnome-screenshot # Screenshot Tool
    gnome.nautilus # File Manager
    gnomeExtensions.caffeine # Keep GNOME from Suspending
    gnomeExtensions.dash-to-panel # Customizable Panel for GNOME
    gnomeExtensions.openweather # Weather on Top Bar
    gnomeExtensions.pop-shell # Tiling WM and Launcher
    gnomeExtensions.tray-icons-reloaded # GNOME Systray
    gnome-menus # Menu Specification
    gparted # Disk Partitioner
    kitty # Advanced Terminal Emulator
    lxappearance # Theme Manager
    pavucontrol # Audio Mixer
    papirus-icon-theme # Icon Theme
    phinger-cursors # Cursor Theme
    rhythmbox # Music Player
    shotwell # Image Viewer
    ungoogled-chromium # Internet Browser

    git # Universal VCS
    htop # System Monitor
    killall # Process Killer
    neofetch pfetch # System Info
    vimHugeX # Minimal Editor with Clipboard
    wget # Minimal File Fetcher
    xdg-utils xdgmenumaker # XDG Utilities
    zip unzip # ZIP Archive Tools
  ];

  # Install some font packages.
  fonts.fonts = with pkgs; [
    ibm-plex
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji-blob-bin
    noto-fonts-extra
  ];

  # Set the default fonts.
  fonts.fontconfig.defaultFonts = {
    serif = [ "IBM Plex Sans" ];
    sansSerif = [ "IBM Plex Sans" ];
    monospace = [ "IBM Plex Mono" ];
    emoji = [ "Blobmoji" ];
  };

  # Allow some outdated packages.
  nixpkgs.config.permittedInsecurePackages = [
    "electron-9.4.4"
  ];
  
}
