{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (import ./getbib.nix { inherit pkgs; })
  ];
}
