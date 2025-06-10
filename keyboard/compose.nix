{ config, ... } :
{
  home.file = {
    "/home/muf/.XCompose".source = ../dotfiles/XCompose;
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
  };
}
