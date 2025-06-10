{ pkgs, ... }:
{
  home.pointerCursor = {
    name = "catppuccin-mocha-mauve-cursors";
    package = pkgs.catppuccin-cursors.mochaMauve;
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk.cursorTheme = {
    name = "catppuccin-mocha-mauve-cursors";
    package = pkgs.catppuccin-cursors.mochaMauve;
    size = 16;
  };
}
