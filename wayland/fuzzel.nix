{ pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.alacritty}/bin/alacritty --class Alacritty,{cmd} -T {cmd} -e {cmd}";
        layer = "overlay";
        launch-prefix = "${pkgs.uwsm}/bin/uwsm app --";
      };
    };
  };
}
