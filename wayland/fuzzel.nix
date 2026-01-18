{ ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.alacritty}/bin/alacritty --class Alacritty,{cmd} -T {cmd} -e {cmd}";
        layer = "overlay";
        launch-prefix = "uwsm app --";
      };
    };
  };
}
