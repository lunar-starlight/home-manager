{ config, pkgs-unstable, ... } :
{
  imports = [
    ./compose.nix
    (import ./kmonad.nix {inherit pkgs-unstable config; name = "kb";})
  ];

