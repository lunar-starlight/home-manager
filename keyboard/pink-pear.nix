{ config, pkgs-unstable, ... } :
{
  imports = [
    ./compose.nix
    (import ./kmonad.nix { inherit config pkgs-unstable; name = "g815"; })
    (import ./kmonad.nix { inherit config pkgs-unstable; name = "g815-media"; })
    (import ./kmonad.nix { inherit config pkgs-unstable; name = "g502"; })
  ];
}
