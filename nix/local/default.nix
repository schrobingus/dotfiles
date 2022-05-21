{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  # Install some tools for compiling.
  nativeBuildInputs = with pkgs; [
    cmake meson ninja # Build Systems
    gcc gnumake # C Tools
    gettext # Translation Tool
    sassc # SASS Frontend
  ];

  # Set up an initial script for nix-shell.
  #shellHook = ''
  #'';
}
