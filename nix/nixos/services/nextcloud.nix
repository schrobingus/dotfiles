{ pkgs, ... }:

{
  environment.etc."nextcloud-admin-pass".text = "PWD";
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    hostName = "order";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "sqlite";
  };

  # services.nginx.virtualHosts."flakyvm-qemu.local".listen = [ 
  #   { addr = "flakyvm-qemu.local"; port = 8585; } 
  # ];
  # networking.firewall.allowedTCPPorts = [ 80 ];
}
