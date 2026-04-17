{ config, pkgs, pkgs-unstable, zen-browser, ... }@inputs:
let
in {
  imports = [
    ./utils
    ./scripts
    ./wayland
    ./keyboard
    ./mime.nix
    ./fonts.nix
    ./programs.nix
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
