{ config, pkgs-unstable, name, src, dev, ... } :
{
  home.file = {
    #"${config.xdg.configHome}/kmonad/${name}.kbd".source = ../dotfiles/kmonad/${name}.kbd;
    "${config.xdg.configHome}/kmonad/${name}.kbd".text 
      = (import ../dotfiles/kmonad/${src}.nix {inherit dev name;});
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
