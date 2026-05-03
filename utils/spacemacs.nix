{ config, pkgs, ... } :
{
  programs.emacs = {
    enable = true;
  };
  services.emacs.client.enable = false;

  #home.file = {
    #"${config.xdg.configHome}/spacemacs/".source = ../dotfiles/spacemacs;
    #".emacs.d" = {
    #  recursive = true;
    #  source = ../dotfiles/emacs;
    #};
  #}; 

  systemd.user.sessionVariables = {
    # This is so that SPC f e d gives you the editable dotfile
    SPACEMACSDIR = "${config.xdg.configHome}/home-manager/dotfiles/spacemacs";
  };
}
