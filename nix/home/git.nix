{ ... }:

{
  programs.git = {
    enable = true;
    userName = "schrobingus";
    userEmail = "brent.monning.jr@gmail.com";
    delta.enable = true;
    extraConfig = {
      diff.tool = "nvimdiff";
      merge.tool = "nvimdiff1";
    };
  };
}
