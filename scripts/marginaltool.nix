{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "marginaltool";
  propagatedBuildInputs = [
    (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
      requests
    ]))
  ];
  dontUnpack = true;
  installPhase = "install -Dm755 ${./src/marginaltool.py} $out/bin/marginaltool";
}
