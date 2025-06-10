{ config, pkgs, ... } :
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  home.file = {
    "${config.xdg.configHome}/spacemacs/init.el".source = ../dotfiles/spacemacs/init.el;
    ".emacs.d" = {
      recursive = true;
      source = ../dotfiles/emacs;
    };
  }; 

  home.sessionVariables = {
    SPACEMACSDIR = "${config.xdg.configHome}/spacemacs";
  };
}
