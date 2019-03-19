{ pkgs, elem, lowerChars, upperChars, optionalString, stringAsChars, runCommand }:

# Prints the latest git commit for a given git repo at a given ref.
{ url, ref ? "HEAD" }:

let
  safeChars = (lowerChars ++ upperChars);
  mkSafe = stringAsChars (c: optionalString (elem c safeChars) c);
  storeName = "repo-${mkSafe ref}-${mkSafe url}";

  scriptContext = {
    /* Avoids caching. This is a cheap operation and needs to be up-to-date */
    version = toString builtins.currentTime;
    /* Required for SSL */
    GIT_SSL_CAINFO = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";

    buildInputs = with pkgs; [ git gnused ];
  };

  script = ''
    REV=$(git ls-remote "${url}" "${ref}") || exit 1

    printf '"%s"' $(echo "$REV" | head -n1 | sed -e 's/\s.*//g' ) \
    > "$out"
  '';

in runCommand storeName scriptContext script
