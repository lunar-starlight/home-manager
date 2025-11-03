{ ... }:
{
  imports = [ ./map.nix ./tags.nix ];
  
  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;

    systemd = {
      enable = true;
    };

    settings = {
      default-layout = "rivertile";
      output-layout = "rivertile";

      set-cursor-warp = "on-focus-change";
      xcursor-theme = "catppuccin-mocha-mauve-cursors 16";

      spawn = [
        "rivertile"
        "waybar"
      ];

      set-repeat = "40 200";

      input."pointer-2-7-SynPS/2_Synaptics_TouchPad" = {
        tap = true;
        natural-scroll = false;
        tap-button-map = "left-middle-right";
        scroll-method = "two-finger";
      };
      input."pointer-1133-49291-Logitech_G502_HERO_Gaming_Mouse" = {
        accel-profile = "flat";
      };
      input."usb-Logitech_USB_Optical_Mouse-mouse" = {
        accel-profile = "flat";
      };
      keyboard-layout-file = "/home/muf/.config/home-manager/dotfiles/xkb/xkbmap.conf";
    };

    extraSessionVariables = {
    };

    extraConfig = ''
    '';
  };
}
