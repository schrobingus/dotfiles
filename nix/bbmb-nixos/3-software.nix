{ config, pkgs, lib, ... }:

{
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

  # Configure Ungoogled Chromium and Discord to use Wayland.
  nixpkgs.config.ungoogled-chromium.commandLineArgs = "--enable-features=WebRTCPipeWireCapturer,UseOzonePlatform --ozone-platform=wayland";
  nixpkgs.config.discord.commandLineArgs = "--enable-features=WebRTCPipeWireCapturer,UseOzonePlatform --ozone-platform=wayland
";

  # Enable Flatpak for additional applications.
  services.flatpak.enable = true;

  # Enable support for GNOME in Blink.
  services.gnome.chrome-gnome-shell.enable = true;

  # Install some packages.
  environment.systemPackages = with pkgs; [
    apple-music-electron # Apple Music Client
    authy # 2FA Client
    bitwarden # Password Manager
    celluloid # MPV Frontend
    dino # XMPP Client
    discord # Discord Client
    emacsPgtkNativeComp # Advanced Editor
    fondo # Wallpaper Fetcher
    fragments # BitTorrent Client
    gnome.file-roller # Archive Tool
    gnome.geary # Email Client
    gnome.gnome-disk-utility # Disk Checking Tool
    gnome.gnome-terminal # Terminal Emulator
    gnome.gnome-tweaks # Tweak Tool
    gnome.gnome-screenshot # Screenshot Tool
    gnome.nautilus # File Manager
    gnomeExtensions.tray-icons-reloaded # GNOME Systray
    gnome-menus # Menu Specification
    gparted # Disk Partitioner
    pavucontrol # Audio Mixer
    papirus-icon-theme # Icon Theme
    rhythmbox # Music Player
    shotwell # Image Viewer
    ungoogled-chromium # Internet Browser

    git # Universal VCS
    htop # System Monitor
    killall # Process Killer
    neofetch pfetch # System Info
    vimHugeX # Minimal Editor with Clipboard
    wget # Minimal File Fetcher

    gettext # Translation Tool
    gnumake gcc # C Tools
    cmake # Build System
    meson ninja # Alternative Build Systems
    sassc # SASS Frontend
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

  # Set the default emoji.
  fonts.fontconfig.defaultFonts.emoji = [ "Blobmoji" ];
  
  # Allow some outdated packages.
  nixpkgs.config.permittedInsecurePackages = [
    "electron-9.4.4"
  ];
}
