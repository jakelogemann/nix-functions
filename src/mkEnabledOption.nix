{ mkOption, types }:
# Creates an enabled NixOS Option.

description: 

mkOption {
  type = types.bool;
  default = true;
  inherit description;
}

