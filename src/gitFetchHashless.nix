{ fetchgitPrivate, stdenv }:

args:

stdenv.lib.overrideDerivation
  /* Use a dummy hash, to appease fetchgit's assertions */
  (fetchgitPrivate (args // { 
    sha256 = builtins.hashString "sha256" args.url; 
  }))
  (old: { /* Remove the hash-checking */
    outputHash     = null;
    outputHashAlgo = null;
    outputHashMode = null;
    sha256         = null;
  })
