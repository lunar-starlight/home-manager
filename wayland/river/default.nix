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
      
      keyboard-layout-file = "/home/muf/.config/home-manager/dotfiles/xkb/xkbmap.conf";
    };

    extraSessionVariables = {
    };

    extraConfig = ''
    '';
  };
}
