{ pkgs, ... }:

{
  imports = [
    ./seaweedfs-module.nix
  ];

  # references here: https://d.moonfire.us/blog/2024/03/21/switching-ceph-to-seaweedfs/
  services.seaweedfs.clusters.default = {
    package = pkgs.seaweedfs;

    volumes.flakyvm-qemu = {
      openFirewall = true;
      dataCenter = "flakyvm-qemu";
      ip = "0.0.0.0";
      dir = [ "/seaweedfs-data" ];
      max = [ 0 ];
      port = 9334;

      mserver = [{
        ip = "0.0.0.0";
        port = 9333;
      }];
    };
  };
}
