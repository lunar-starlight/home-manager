{ pkgs, ... }:
pkgs.writeShellScriptBin "set-mouse-buttons" ''
DEV=ratbagctl list | grep "G502 X" | sed 's/:.*//'
ratbagctl $DEV profile set 1
ratbagctl $DEV button 3 action set key KEY_F13
ratbagctl $DEV button 5 action set key KEY_F14
ratbagctl $DEV button 4 action set key KEY_F15
ratbagctl $DEV button 10 action set key KEY_F16
ratbagctl $DEV button 9 action set key KEY_F17
''
