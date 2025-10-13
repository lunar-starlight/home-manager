{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (import ./getbib.nix { inherit pkgs; })
    (import ./marginaltool.nix { inherit pkgs; })
  ];
}
