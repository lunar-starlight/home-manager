{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "marginaltool";
  propagatedBuildInputs = [
    (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
      requests
    ]))
  ];
  dontUnpack = true;
  installPhase = "install -Dm755 ${./marginaltool.py} $out/bin/marginaltool";
}
