{ pkgs, ... }:
{
  home.packages = with pkgs; [
    #(import ./brightness.nix { inherit pkgs; })
  ];
}
