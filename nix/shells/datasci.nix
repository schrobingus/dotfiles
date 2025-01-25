{ pkgs ? import <nixpkgs> {} }:

let
  jupyter = pkgs.python312.withPackages ( ps: with ps; [
    jupyter
    jupyter-server
    notebook
    jupyterlab-server
    ipython
    ipykernel
    numpy
    pandas
    matplotlib
    toolz
    build
    setuptools
    virtualenv

    gdal
    rasterio
    rioxarray
    scipy
    scikit-image
    pyosmium
  ]);
in
  pkgs.mkShell {
    nativeBuildInputs = [
      jupyter
      pkgs.gdal
    ];
  }
