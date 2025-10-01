{ config, pkgs, pkgs-unstable, zen-browser, ... }@inputs:
let
  stremio-custom =
    (import ./pkgs/stremio.nix {
      lib = inputs.lib;
      stdenv = pkgs.stdenv;
      fetchFromGitHub = pkgs.fetchFromGitHub;
      fetchurl = pkgs.fetchurl;
      libsForQt5 = pkgs.libsForQt5;
      ffmpeg = pkgs.ffmpeg;
      mpv = pkgs.mpv;
      nodejs = pkgs.nodejs;
    });
in {
  imports = [
    ./utils
    ./scripts
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
    killall

    # sys utils
    lm_sensors
    ethtool
    pciutils
    usbutils

    # browser
    firefox
    zen-browser

    # editor
    #emacs
    vscode
    (aspellWithDicts (dicts: with dicts; [en sl]))

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
    gammastep # ne dela
    #xdg-desktop-portal-wlr
    brightnessctl
    wayprompt
    

    catppuccin-cursors.mochaMauve

    # programs
    discord
    pkgs-unstable.signal-desktop
    signalbackup-tools
    xournalpp
    kdePackages.okular
    deadbeef
    deadbeefPlugins.headerbar-gtk3
    (lutris.override {
      extraLibraries = pkgs: [
      ];
      extraPkgs = pkgs: [
      ];
    })
    steam
    stremio
    #stremio-custom
    prismlauncher
    minecraft
    
    # fonts
    noto-fonts-color-emoji
    noto-fonts-monochrome-emoji
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.symbols-only

    # languages
    (agda.withPackages (p: [ p.standard-library ]))
    texliveFull
    #lean4
    elan

  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      #xdg-desktop-portal-gtk
    ];
    configPackages = [ pkgs.river ];
    #config.common.default = [ "wlr" ];
    #config.river = {
    #  default = [ "wlr" ];
    #};
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" "Noto Monochrome Emoji" ];
    };
  };

  # do NOT the version
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
