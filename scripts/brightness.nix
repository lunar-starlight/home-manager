{ pkgs, ... }:
pkgs.writeShellScriptBin "brightnessctl" ''
  echo $((16*$1)) | sudo tee /sys/class/backlight/amdgpu_bl1/brightness
''
