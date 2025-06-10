{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
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
          "pulseaudio"
          "cpu"
          "memory"
          "battery"
          "clock"
        ];
        "clock" = {
          interval = 60;
          tooltip = false;
          format = "{:%a, %Y-%m-%d | %R}";
        };
        "battery" = {
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
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
