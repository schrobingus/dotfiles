
{ config, lib, dotDir, ... }:

let

  # FIXME: this function works well, but because it symlinks directories, it often catches junk files in the crossfire. for now, just throw the junk files in gitignore, but consider linking the individual files

  mkLinks = paths:
    lib.attrsets.mergeAttrsList (map (relPath: {
      "${relPath}".source =
        config.lib.file.mkOutOfStoreSymlink "${dotDir}/togohome/${relPath}";
    }) paths);

  topLevel = builtins.attrNames (builtins.readDir "${dotDir}/togohome");
  configLevel = builtins.attrNames (builtins.readDir "${dotDir}/togohome/.config");

  homeFiles = builtins.filter (name: name != ".config") topLevel;
  configFiles = map (name: ".config/${name}") configLevel;

in {
  home.file = mkLinks (homeFiles ++ configFiles);
}

