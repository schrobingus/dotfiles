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

  # Install some packages.
  environment.systemPackages = with pkgs; [
    apple-music-electron # Apple Music Client
    authy # 2FA Client
    bitwarden # Password Manager
    celluloid # MPV Frontend
    discord # Online Chat
    emacsPgtkNativeComp # Advanced Editor
    fondo # Wallpaper Fetcher
    gnome.geary # Email Client
    gnome.gnome-terminal # Terminal Emulator
    gnome.gnome-tweaks # Tweak Tool
    gnome.gnome-screenshot # Screenshot Tool
    gnome.nautilus # File Manager
    pavucontrol # Audio Mixer
    papirus-icon-theme # Icon Theme
    rhythmbox # Music Player
    shotwell # Image Viewer
    ungoogled-chromium # Internet Browser

    git # Universal VCS
    htop # System Monitor
    killall # Process Killer
    neofetch pfetch # System Info
    vim # Minimal Editor
    wget # Minimal File Fetcher

    meson ninja # Alternative Build Systems
    sassc # SASS Frontend
  ];

  # Install some font packages.
  fonts.fonts = with pkgs; [
    ibm-plex
    liberation_ttf
    liberation_ttf_v1
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji-blob-bin
    noto-fonts-extra
  ];
  
  # Allow some outdated packages.
  nixpkgs.config.permittedInsecurePackages = [
    "electron-9.4.4"
  ];
}
