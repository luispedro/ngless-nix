{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc801" }:
nixpkgs.pkgs.haskell.packages.${compiler}.callPackage ./ngless.nix { }
