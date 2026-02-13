{ pkgs, ... }:
pkgs.writeShellScriptBin "brightness-plus-five" ''
curr=$(brightnessctl get)
next=$(printf %.0f "$((200 * $curr / 256 + 10))e-1")
next=$(printf %.0f "$(($next*256*5))e-2")
brightnessctl set $next
''
