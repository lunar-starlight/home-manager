{ config, pkgs-unstable, lib, ... } :
let
  keyboards = [
    { name = "G815"; src = "GX15"; dev = "/dev/input/by-id/usb-Logitech_G815_RGB_MECHANICAL_GAMING_KEYBOARD_079031593737-event-kbd"; }
    { name = "G815-media"; src = "GX15-media"; dev = "/dev/input/by-id/usb-Logitech_G815_RGB_MECHANICAL_GAMING_KEYBOARD_079031593737-if01-event-kbd"; }
    { name = "G502"; src = "G502"; dev = "/dev/input/by-id/usb-Logitech_G502_HERO_Gaming_Mouse_067A38753836-if01-event-kbd"; }
  ];
in
{
  imports = [
    ./compose.nix
  ] ++ lib.map ({name, src, dev}: import ./kmonad.nix {inherit config pkgs-unstable name src dev;}) keyboards;
  #  (import ./kmonad.nix { inherit config pkgs-unstable; name = "g815"; })
  #  (import ./kmonad.nix { inherit config pkgs-unstable; name = "g815-media"; })
  #  (import ./kmonad.nix { inherit config pkgs-unstable; name = "g502"; })
  #];
}
