{ pkgs, ... }:
{
  programs.eww = {
    enable = true;
    systemd.enable = true;
    yuckConfig = builtins.readFile ./src/eww/eww.yuck;
    scssConfig = builtins.readFile ./src/eww/eww.scss;
  };
  xdg.configFile."eww/jq".source = ./src/eww/jq;
  xdg.cacheFile."pavolctld".text = "";

  systemd.user.services = {
    "eww-bars" = {
      Unit = {
        Description = "Open the eww bars";
        After = "eww.service";
        PartOf = "graphical-session.target";
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStart = "${pkgs.eww}/bin/eww open-many bar:primary bar:secondary --arg primary:screen=1 --arg secondary:screen=0 --no-daemonize";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
