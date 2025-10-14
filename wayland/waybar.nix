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
          on-click = "alacritty -e nix run nixpkgs#pulsemixer";
        };
        "custom/sleep" = {
          format = " 💤 ";
          on-click = "systemctl sleep";
          tooltip = false;
        };
      };
    };
    style = ''
      /*#tags button {
        color: rgba(100, 114, 125, 0.5);
      }*/
#tags button {
    padding: 0 5px;
    background-color: transparent;
    color: #ffffff;
}

#tags button:hover {
    background: rgba(0, 0, 0, 0.2);
}

#tags button.focused, #tags button.active {
    background-color: #64727D;
    box-shadow: inset 0 -3px #ffffff;
}

#tags button.urgent {
    background-color: #eb4d4b;
}
    '';
  };
}
