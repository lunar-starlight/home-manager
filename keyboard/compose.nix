{ config, ... } :
{
  home.file = {
    "/home/muf/.XCompose".source = ../dotfiles/XCompose;
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
  };
}
