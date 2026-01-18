{ pkgs, ... }:
{
  imports = [
    ./river
    ./waybar.nix
    ./cursor.nix
    ./fuzzel.nix
    ./gammastep.nix
  ];
}
