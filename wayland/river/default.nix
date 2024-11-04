{ ... }:
{
  imports = [ ./map.nix ];
  
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
      xcursor-theme = "Catppuccin-Mocha-Mauve-Cursors 16";

      spawn = [
        "rivertile"
        "waybar"
      ];

      set-repeat = "40 200";
    };

    extraSessionVariables = {
    };

    extraConfig = ''
      riverctl keyboard-layout-file /home/muf/.config/xkb/xkbmap.conf
    '';
  };
}
