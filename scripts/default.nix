{ pkgs, ... }:
{
  imports = [
    ./marginaltool.nix
  ];

  home.packages = with pkgs; [
    (import ./getbib.nix { inherit pkgs; })
    (import ./switch-audio-device.nix { inherit pkgs; })
    (import ./brightness-plus-five.nix { inherit pkgs; })
    (import ./brightness-minus-five.nix { inherit pkgs; })
  ];
}
