{ config, pkgs, ... } :
{
  programs.emacs = {
    enable = true;
  };
  services.emacs.client.enable = false;

  home.file = {
    "${config.xdg.configHome}/spacemacs/".source = ../dotfiles/spacemacs;
    #".emacs.d" = {
    #  recursive = true;
    #  source = ../dotfiles/emacs;
    #};
  }; 

  systemd.user.sessionVariables = {
    SPACEMACSDIR = "${config.xdg.configHome}/spacemacs";
  };
}
