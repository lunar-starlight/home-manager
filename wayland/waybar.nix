{ pkgs, ... }:
let
  switch-audio-device = (pkgs.callPackage ../scripts/switch-audio-device.nix {});
in
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
    };
    settings = {
      mainBar = {
        reloadStyleOnChange = true;
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
          on-click = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.nix}/bin/nix run nixpkgs#pulsemixer";
          on-click-middle = "${switch-audio-device}/bin/switch-audio-device";
        };
        "custom/sleep" = {
          format = " 💤 ";
          on-click = "systemctl hybrid-sleep";
          tooltip = false;
        };
      };
    };
    style = (builtins.readFile ./src/waybar/default.css) + (builtins.readFile ./src/waybar/custom.css);
  };
}
