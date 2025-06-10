{ config, pkgs-unstable, ... } :
{
  imports = [
    ./compose.nix
    (import ./kmonad.nix { inherit config pkgs-unstable; name = "kb"; })
  ];

  home.file = {
    "${config.xdg.configHome}/xkb".source = ../dotfiles/xkb;
  };
}
