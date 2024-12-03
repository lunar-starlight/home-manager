{ config, pkgs-unstable, name, ... } :
{
  home.file = {
    "${config.xdg.configHome}/kmonad/${name}.kbd".source = ../dotfiles/kmonad/${name}.kbd;
  };

  systemd.user.services = {
    "kmonad-${name}" = {
      Unit = {
        Description = "kmonad ${name} config";
      };

      Service = {
        ExecStart = "${pkgs-unstable.kmonad}/bin/kmonad /home/muf/.config/kmonad/${name}.kbd";
      };

      Install.WantedBy = [ "default.target" ];
    };
  };
}
