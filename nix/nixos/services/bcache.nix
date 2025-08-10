{ ... }:

{
  boot = {
    bcache.enable = true;
    supportedFilesystems = [ "bcachefs" ];
    initrd = {
      services.bcache.enable = true;
      supportedFilesystems = [ "bcachefs" ];
    };
  };
}
