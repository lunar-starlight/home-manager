{ pkgs, ... }:
{
  imports = [
    ./eww.nix
    ./river
    #./waybar.nix
    ./cursor.nix
    ./fuzzel.nix
    ./gammastep.nix
  ];
}
