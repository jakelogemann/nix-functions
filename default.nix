# NixOS Overlay containing the defined functions.
self: super: {
  fnctlFunc = import ./impure.nix {
    pkgs = super;
    lib = super.lib;
  };
}
