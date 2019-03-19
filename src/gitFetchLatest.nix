{ stdenv, pkgWithContext
, gitFetchHashless ? (pkgWithContext ./gitFetchHashless.nix {})
, gitCommitLatest ? (pkgWithContext ./gitCommitLatest.nix {})
}:

{ url, ref ? "HEAD" }@args:

let
  gitArgs = (builtins.removeAttrs (args // {
    rev = import (gitCommitLatest { inherit url ref; });
  }) ["ref"]);

in gitFetchHashless gitArgs


