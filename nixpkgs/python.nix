{ config, pkgs, ... }:

let
  homePythonPackages = p: with p; [
    pip
    build
    pandas
  ];
in
{
  home.packages = [
    (pkgs.python311.withPackages homePythonPackages)
  ];
}
