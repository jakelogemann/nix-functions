# Used to install this framework's pkgs, lib & custom NixOS modules.
# This is only useful in NixOS, Nix package users should instead use
# `default.nix` which is ONLY the overlay.
{ config, pkgs, lib, options, ... }: with lib;
{ config = {
  nixpkgs.overlays = [(import ./default.nix)];
  nix.nixPath = ["fnctlFunc=${./impure.nix}"];
}; }
