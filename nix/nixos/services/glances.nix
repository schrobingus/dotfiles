{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ glances ];

  services.glances.enable = true;

  # networking.firewall.allowedTCPPorts = [ 61208 ];
}
