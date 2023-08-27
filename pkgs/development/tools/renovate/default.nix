{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  python3,
}: let
  version = "36.67.1";
in
  buildNpmPackage {
    pname = "renovate";
    inherit version;

    src = fetchFromGitHub {
      owner = "renovatebot";
      repo = "renovate";
      rev = version;
      hash = "sha256-eSaMnSzJVB96VAraLz8qNWQPoJerIK/vSdqPxlEgnlU=";
    };

    # nix-shell -p nodejs-17_x; npm i --package-lock-only
    postPatch = ''
      cp ${./package-lock.json} ./package-lock.json
      sed -i -e '/prepare:re2/d' package.json
    '';

    npmDepsHash = "sha256-CaSD8P7VeW7nEv+wFx+WdcblKsoJaAOC13WjLQrWoPc=";
    npmPackFlags = ["--omit=optional"];

    buildInputs = [python3];
    nativeBuildInputs = [python3];

    meta = {
      description = "Universal dependency update tool that fits into your workflows";
      homepage = "https://github.com/renovatebot/renovate/";
      license = lib.licenses.agpl3Only;
      maintainers = with lib.maintainers; [kidanger];
    };
  }
