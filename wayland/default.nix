{ pkgs, ... }:
{
  imports = [
    ./river
    ./waybar.nix
    ./cursor.nix
    ./gammastep.nix
  ];
}
