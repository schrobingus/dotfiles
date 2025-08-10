{ ... }:

{
  services.guacamole-server = {
    enable = true;
    host = "flakyvm-qemu.local";
    # userMappingXml = ./user-mapping.xml;
  };

  services.guacamole-client = {
    enable = true;
    enableWebserver = true;
    settings = {
      guacd-port = 4822;
      guacd-hostname = "127.0.0.1";
    };
  };

  networking.firewall.allowedTCPPorts = [ 4822 ];

  # NOTE: not labelled for aarch64?
  nixpkgs.config.allowUnsupportedSystem = true;
}
