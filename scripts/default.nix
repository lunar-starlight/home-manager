{ pkgs, ... }:
let
  marginaltool = import ./marginaltool.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    (import ./getbib.nix { inherit pkgs; })
    marginaltool
  ];
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
}
