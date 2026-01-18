{ pkgs, ... }:
let
  marginaltool = pkgs.stdenv.mkDerivation {
    name = "marginaltool";
    propagatedBuildInputs = [
      (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
        requests
      ]))
    ];
    dontUnpack = true;
    installPhase = "install -Dm755 ${./src/marginaltool.py} $out/bin/marginaltool";
  };
in {
  home.packages = with pkgs; [ marginaltool ];

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/bc-digsign" = "marginaltool.desktop";
      };
    };
    desktopEntries.marginaltool = {
      name = "MarginalTool";
      exec = "${marginaltool}/bin/marginaltool";
    };
  };
  
  home.file.".config/marginaltool".text = ''
    [https://gcsign.uni-lj.si/BCSign/]
    engine = file
    keyfile = .ssh/sigenca.key.pem
    certfile = .ssh/sigenca.crt.pem
  '';
}
