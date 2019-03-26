# Used to install this framework's pkgs, lib & custom NixOS modules.
# This is only useful in NixOS, Nix package users should instead use
# `default.nix` which is ONLY the overlay.
{ config, pkgs, lib, options, ... }:

{
  nixpkgs.overlays = lib.mkAfter [(import ./default.nix)];
  nix.nixPath = lib.mkAfter ["fnctlFunc=${./impure.nix}"];
}
