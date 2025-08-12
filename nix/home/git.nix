{ ... }:

{
  # TODO: figure out how to integrate this with users? or just scrap
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
