{ config, pkgs-unstable, ... } :
{
  imports = [
    (import ./kmonad.nix {inherit pkgs-unstable config; name = "kb";})
  ];

