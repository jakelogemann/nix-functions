{ stdenv, pkgWithContext
, gitFetchLatest ? (pkgWithContext ./gitFetchLatest.nix {})
}:

{ name
, repoPath ? name
, ref ? "master"
, version ? "0.1.0"
, gitUser ? "git"
, gitHost ? "gitlab.com"
}: stdenv.mkDerivation {
  inherit version;
  name             = "fnctl-git${name}-${version}";
  installPhase     = "cp -a . $out";
  dontBuild        = true;
  preferLocalBuild = true;
  src   = gitFetchLatest {
    inherit ref;
    url = "${gitUser}@${gitHost}:fnctl/${repoPath}.git";
  };
}
