{ config, pkgs-unstable, ... } :
{
  imports = [
    ./compose.nix
    (import ./kmonad.nix { inherit config pkgs-unstable; name = "g815"; })
    (import ./kmonad.nix { inherit config pkgs-unstable; name = "g815-media"; })
    (import ./kmonad.nix { inherit config pkgs-unstable; name = "g502"; })
  ];

  home.file = {
    "${config.xdg.configHome}/xkb".source = ../dotfiles/xkb;
  };
}
