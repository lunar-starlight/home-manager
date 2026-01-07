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
    river-classic
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
    thunderbird
    #deadbeef
    #deadbeefPlugins.headerbar-gtk3
    (lutris.override {
      extraLibraries = pkgs: [
      ];
      extraPkgs = pkgs: [
      ];
    })
    steam
    #stremio
    #stremio-custom
    prismlauncher
    vintagestory
    
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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "x-scheme-handler/chrome" = "zen-beta.desktop";
      "text/html" = "zen-beta.desktop";
      "application/x-extension-htm" = "zen-beta.desktop";
      "application/x-extension-html" = "zen-beta.desktop";
      "application/x-extension-shtml" = "zen-beta.desktop";
      "application/xhtml+xml" = "zen-beta.desktop";
      "application/x-extension-xhtml" = "zen-beta.desktop";
      "application/x-extension-xht" = "zen-beta.desktop";
      "x-scheme-handler/sgnl" = "signal.desktop";
      "x-scheme-handler/signalcaptcha" = "signal.desktop";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      #xdg-desktop-portal-gtk
    ];
    configPackages = [ pkgs.river-classic ];
    #config.common.default = [ "wlr" ];
    #config.river = {
    #  default = [ "wlr" ];
    #};
  };

  home.file."${config.xdg.dataHome}/fonts".source = ./fonts;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [
        "Noto Color Emoji" 
        "Noto Emoji"
      ];
    };
  };

  # do NOT the version
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
