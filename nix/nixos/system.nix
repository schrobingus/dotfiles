{ config, pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
    };
  };

  networking.hostName = "thonk";
  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  security.polkit.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = false;

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd niri
      '';
    };
  };
  environment.etc."greetd/environment".text = ''
    niri
  '';

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  programs.zsh.enable = true;

  users.users.brent = {
    isNormalUser = true;
    description = "Brent";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    niri
    fuzzel
    swaylock
    wl-clipboard

    librewolf
    # ungoogled-chromium  # FIXME: 5gb download holy fuck
    vesktop
    pavucontrol
    wezterm

    brightnessctl
    btop
    cachix
    curl
    git
    vim
    wget
    zsh
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  system.stateVersion = "unstable";
}
