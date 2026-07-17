{ pkgs, name, src, dev, ... } :
{
  xdg.configFile."kmonad/${name}.kbd".text = (import ../dotfiles/kmonad/${src}.nix {inherit dev name;});

  systemd.user.services = {
    "kmonad-${name}" = {
      Unit = {
        Description = "kmonad ${name} config";
      };

      Service = {
        ExecStart = "-${pkgs.kmonad}/bin/kmonad /home/muf/.config/kmonad/${name}.kbd";
      };

      Install.WantedBy = [ "default.target" ];
    };
  };
}
