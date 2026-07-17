{ pkgs, ... }:
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
    preferXdgDirectories = true;
  };

  xdg.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.allowInsecurePredicate = pkg:
  #  builtins.elem (pkgs.lib.getName pkg) [
  #    "qtwebengine"
  #  ];

  # do NOT the version
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
