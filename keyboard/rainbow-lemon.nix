{ config, pkgs-unstable, lib, ... } :
let
  keyboards = [
    { name = "G915-wired"; src = "GX15"; dev = "/dev/input/by-id/usb-Logitech_G915_X_LS_BB8E30E8-event-kbd"; }
    { name = "G915-dongle"; src = "GX15"; dev = "/dev/input/by-id/usb-Logitech_USB_Receiver-if01-event-kbd"; }
    { name = "Rainbow"; src = "rainbow"; dev = "/dev/input/by-path/platform-i8042-serio-0-event-kbd"; }
  ];
in
{
  imports = [
    ./compose.nix
  ] ++ lib.map ({name, src, dev}: import ./kmonad.nix {inherit config pkgs-unstable name src dev;}) keyboards;
  #  (import ./kmonad.nix { inherit config pkgs-unstable; name = "rainbow"; })
  #  (import ./kmonad.nix { inherit config pkgs-unstable; name = "g915"; })
  #  (import ./kmonad.nix { inherit config pkgs-unstable; name = "g915-media"; })
  #];

  #home.file = {
  #  "${config.xdg.configHome}/xkb".source = ../dotfiles/xkb;
  #};
}
