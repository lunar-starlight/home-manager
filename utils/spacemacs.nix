{ config, pkgs, ... } :
{
  programs.emacs = {
    enable = true;
  };
  services.emacs.client.enable = false;

  #home.file = {
    #"${config.xdg.configHome}/spacemacs/init.el".source = ../dotfiles/spacemacs/init.el;
    #".emacs.d" = {
    #  recursive = true;
    #  source = ../dotfiles/emacs;
    #};
  #}; 

  systemd.user.sessionVariables = {
    SPACEMACSDIR = "${config.xdg.configHome}/home-manager/dotfiles/spacemacs";
  };
}
