{ pkgs, ... }:
pkgs.writeShellScriptBin "brightness-plus-five" ''
curr=$(brightnessctl get)
next=$(printf %.2f "$((10**3 * $curr / 256 + 50))e-3")
brightnessctl set $(($next*256))
''
