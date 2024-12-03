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
      riverctl input pointer-2-7-SynPS/2_Synaptics_TouchPad tap enabled
      riverctl input pointer-2-7-SynPS/2_Synaptics_TouchPad natural-scroll disabled
      riverctl input pointer-2-7-SynPS/2_Synaptics_TouchPad tap-button-map left-middle-right
      riverctl input pointer-2-7-SynPS/2_Synaptics_TouchPad scroll-method two-finger
      keys=(minus 7 5 3 1 9 0 2 4 6)
      for i in "$${!keys[@]}"
      do
        tagmask=$((1 << $i))
        riverctl map normal Mod4               $${keys[$i]} set-focused-tags    $tagmask
        riverctl map normal Mod4+Shift         $${keys[$i]} set-view-tags       $tagmask
        riverctl map normal Mod4+Control       $${keys[$i]} toggle-focused-tags $tagmask
        riverctl map normal Mod4+Shift+Control $${keys[$i]} toggle-view-tags    $tagmask
      done
      all_tags_mask=$(((1 << 32) - 1))
      riverctl map normal Mod4       8 set-focused-tags $all_tags_mask
      riverctl map normal Mod4+Shift 8 set-view-tags    $all_tags_mask
    '';
  };
}
