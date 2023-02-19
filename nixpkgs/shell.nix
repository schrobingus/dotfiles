{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  # Install some tools for compiling.
  /* NOTE: These should be only used for tools that aren't very
     heavy or demand high configuration. */
  # TODO: Handle LSP later.
  nativeBuildInputs = with pkgs; [
    automake autoconf            # Build File Generators
    cargo rustc                  # Rust Compiler + Cargo
    clojure                      # Clojure Compiler
    gcc gnumake clang            # C Compilers / Tools
    gettext                      # Localization Tool
    go                           # Go Language
    meson ninja                  # Meson + Ninja
    sassc                        # SASS Frontend
    sbcl                         # Common Lisp
  ];

  # Set up an initial script for Nix Shell.
  #shellHook = ''
  #'';
}
