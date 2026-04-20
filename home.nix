{ ... }:
{
  imports = [
    ./misc
    ./utils
    ./scripts
    ./wayland
    ./keyboard
  ];

  home = {
    username = "muf";
    homeDirectory = "/home/muf";
  };

  #nixpkgs.config.permittedInsecurePackages = [
  #  "qtwebengine-5.15.19"
  #];
  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.allowInsecurePredicate = pkg:
  #  builtins.elem (pkgs.lib.getName pkg) [
  #    "qtwebengine"
  #  ];

  # do NOT the version
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
