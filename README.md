Nix Functions
=============

> _"Just add `<nixpkgs>`."_

Collection of custom Nix/NixOS functions that may be useful. Each file
in `./src/` corresponds to a function exported by this module (with the
exception of `default.nix` which serves as the bootstrap for the rest
of the functions).

**Can be used as NixPkgs Overlay**:
```nix
with (import <nixpkgs> {
  # config = []; 
  overlays = [
    /path/to/functions/
  ];
});
```

**Can be used in NixOS Overlays**:
```nix
{ config, pkgs, lib, options, ... }:
{
  nixpkgs.overlays = lib.mkBefore [
    /path/to/functions/
  ];
}
```

**Can be used in NixOS Imports**:
```nix
{ config, pkgs, lib, options, ... }:
{ imports = lib.mkBefore [ /path/to/functions/nixos.nix ]; }
```


**Can be used almost anywhere**:
Loads all functions into current scope. This is the most general way to
use these functions in `release.nix`, `shell.nix`, or similar.
```nix
{ pkgs, lib, ... }:
with (import ./path/to/functions/impure.nix { inherit lib pkgs; });

```

**Easy to add new functions**:
create a new file in the repo, this will be the functions name when called. 
For example, the function `.pickleRick <dir>` exists in the file
`./src/pickleRick.nix` and might contain:
```nix

# -- Specify Dependencies
# dependencies can come from `lib.*`, a handful of pkgs/builtins. The
# main change is the definition of a function named `pkgWithContext`.
# This function behaves like `callPackage` and provides the same scope to
# the imported package.
{ mapAttrs, pkgWithContext, readDir
, withNix ? (pkgWithContext ./withNix.nix {})
}:  

# -- Specify Function Argument(s)
# These can be anything you want. They should have comments and strive for clarity.
dir:

# -- (Optional) Setup some local context for the function
let  
  # its common to define a few private helper functions/variables 
  # inside a 'let' block such as this one.

  mapFunc = n: v:
    if v == "regular" || v == "symlink" then dir + "/${n}"
    else dirToAttrs (dir + "/${n}");

  foo = "bar";
in

# -- Define the function's behavior.
mapAttrs mapFunc (readDir dir)
```

Contributing
------------

**Functions MUST** (_at least strive for, kinda?_):
- Serve as well as documentation as they do code.
- Be documented extensively. Seriously, get that?
- Use verbose variable names for clarity where ever its reasonable.
- Strive to keep functions as generic as possible.

The functions should be documented extensively and these functions
should be kept simple, minimal and verifiable. Variable names should
strive to be clear for external users' consumption. This repo can serve
as a reference, or a cheatsheet.

**There are not tests yet, but we should obviously add them.**
