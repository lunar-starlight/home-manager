{ config, pkgs-unstable, ... } :
{
  imports = [
    ./compose.nix
    (import ./kmonad.nix { inherit config pkgs-unstable; name = "kb"; })
  ];
}
