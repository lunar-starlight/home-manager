{ config, pkgs-unstable, ... } :
{
  imports = [
    ./compose.nix
    (import ./kmonad.nix { inherit config pkgs-unstable; name = "rainbow"; })
    (import ./kmonad.nix { inherit config pkgs-unstable; name = "g915"; })
    (import ./kmonad.nix { inherit config pkgs-unstable; name = "g915-media"; })
  ];

  #home.file = {
  #  "${config.xdg.configHome}/xkb".source = ../dotfiles/xkb;
  #};
}
