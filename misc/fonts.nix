{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    noto-fonts-color-emoji
    noto-fonts-monochrome-emoji
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.symbols-only
    fira-code
    fira-code-symbols
  ];

  home.file."${config.xdg.dataHome}/fonts".source = ../fonts;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [
        "Noto Color Emoji"
        "Noto Emoji"
      ];
    };
  };
}
