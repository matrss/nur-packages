# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

rec {
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  mss =
    let
      python3 =
        let
          packageOverrides = self: super: {
            fastkml = self.callPackage ./pkgs/fastkml { };
            fs_filepicker = self.callPackage ./pkgs/fs_filepicker { };
            fslib = self.callPackage ./pkgs/fslib { };
            metpy = self.callPackage ./pkgs/metpy { };
            nco = self.callPackage ./pkgs/nco { };
            pygeoif = self.callPackage ./pkgs/pygeoif { };
            skyfield-data = self.callPackage ./pkgs/skyfield-data { };
          };
        in
        pkgs.python3.override {
          inherit packageOverrides;
        };
    in
    pkgs.libsForQt5.callPackage ./pkgs/mss { inherit python3; };
}
