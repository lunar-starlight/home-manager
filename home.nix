{ config, pkgs, pkgs-unstable, ... }:
{
  imports = [
    ./utils
    ./wayland
    ./keyboard
  ];

  home = {
    username = "muf";
    homeDirectory = "/home/muf";
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip

    # utils
    eza
    mtr
    htop
    alacritty
    pulsemixer
    kmonad
    gnumake

    # sys utils
    lm_sensors
    ethtool
    pciutils
    usbutils

    # browser
    firefox

    # editor
    emacs
    vscode

    # WM
    river
    waybar
    fuzzel
    mako
    swaybg
    wl-clipboard
    wl-screenrec
    sway-contrib.grimshot
    #wf-recorder
    gammastep

    catppuccin-cursors.mochaMauve

    # programs
    discord
    pkgs-unstable.signal-desktop
    signalbackup-tools

    # lean
    #lean4
    elan

    # fonts
    noto-fonts-color-emoji
    noto-fonts-monochrome-emoji
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      #emoji = [ "Noto Color Emoji" ];
    };
  };

  # do NOT the version
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
