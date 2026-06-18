{ config, ... }:
{
  imports = [ ./map.nix ./tags.nix ];
  
  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;

    systemd = {
      enable = true;
      variables = [
        "DISPLAY"
        "WAYLAND_DISPLAY"
        "XDG_CURRENT_DESKTOP"
        "NIXOS_OZONE_WL"
        "XCURSOR_THEME"
        "XCURSOR_SIZE"
        "SSH_AUTH_SOCK"
      ];
      extraCommands = [
        "uwsm finalize"
        "systemctl --user stop river-session.target"
        "systemctl --user start river-session.target"
      ];
    };

    settings = {
      default-layout = "rivertile";
      #output-layout = "rivertile";
      default-attach-mode = "after 1";

      set-cursor-warp = "on-focus-change";
      xcursor-theme = "catppuccin-mocha-mauve-cursors 16";

      spawn = [
        "'rivertile -main-location bottom'"
        "'nix shell nixpkgs#way-displays -c bash -c \"(way-displays &) ; sleep 1 && way-displays -s scaling off && way-displays -s transform DP-1 90 && killall way-displays\"'"
        #"waybar"
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
      keyboard-layout-file = "${config.xdg.configHome}/home-manager/dotfiles/xkb/xkbmap.conf";
    };

    extraSessionVariables = {
    };

    extraConfig = ''
    '';
  };
}
