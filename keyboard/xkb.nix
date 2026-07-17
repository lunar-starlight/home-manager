{ config, ... } :
{
  home.file = {
    "${config.xdg.configHome}/xkb".source = ../dotfiles/xkb;
  };
}
