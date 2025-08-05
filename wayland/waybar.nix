{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 24;
        spacing = 0;
        modules-left = [
          "river/mode"
          "river/window"
        ];
        modules-center = [
          "river/tags"
        ];
        modules-right = [
          "backlight"
          "pulseaudio"
          #"cpu"
          #"memory"
          "battery"
          "clock"
          "custom/sleep"
        ];
        "clock" = {
          interval = 60;
          tooltip = false;
          format = "{:%a, %Y-%m-%d | %R}";
        };
        "battery" = {
          format = "{icon} {capacity}%";
          format-icons = ["" "" "" "" ""];
        };
        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = ["󰃞" "󰃝" "󰃟" "󰃠"];
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰖁 {volume}%";
          format-icons = ["" "" ""];
        };
        "custom/sleep" = {
          format = " 💤 ";
          on-click = "systemctl sleep";
          tooltip = false;
        };
      };
    };
    #style = ''
    #  /*#workspaces button {
    #    color: #f3c;
    #  }*/
    #'';
  };
}
