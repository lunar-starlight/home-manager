{ pkgs, ... }:
let
  marginaltool = import ./marginaltool.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    (import ./getbib.nix { inherit pkgs; })
    (import ./switch-audio-device.nix { inherit pkgs; })
    (import ./brightness-plus-five.nix { inherit pkgs; })
    (import ./brightness-minus-five.nix { inherit pkgs; })
    marginaltool
  ];

  # MarginalTool
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
