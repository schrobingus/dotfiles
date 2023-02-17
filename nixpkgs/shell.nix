{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  # Install some tools for compiling.
  nativeBuildInputs = with pkgs; [
    cmake meson ninja   # Build Systems / Generators
    gcc gnumake         # C Tools
    gettext             # Translation Tool
    sassc               # SASS Frontend
  ];

  # Set up an initial script for Nix Shell.
  #shellHook = ''
  #'';
}
