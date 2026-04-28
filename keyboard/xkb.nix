{ config, ... } :
{
  home.file = {
    "${config.xkb.configHome}".source = ../dotfiles/xkb;
  };
}
