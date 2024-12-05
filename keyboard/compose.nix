{ ... } :
{
  home.file = {
    "${config.xdg.configHome}/XCompose".source = ../dotfiles/XCompose;
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
  };
}
