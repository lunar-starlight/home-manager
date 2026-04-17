{ config, pkgs, pkgs-unstable, zen-browser, ... }@inputs:
let
in {
  imports = [
    ./utils
    ./scripts
    ./wayland
    ./keyboard
    ./fonts.nix
  ];

  home = {
    username = "muf";
    homeDirectory = "/home/muf";
  };

  #nixpkgs.config.permittedInsecurePackages = [
  #  "qtwebengine-5.15.19"
  #];
  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.allowInsecurePredicate = pkg:
  #  builtins.elem (pkgs.lib.getName pkg) [
  #    "qtwebengine"
  #  ];

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
    wtype

    # sys utils
    lm_sensors
    ethtool
    pciutils
    usbutils

    # browser
    #firefox
    zen-browser

    # editor
    #emacs
    vscode
    (aspellWithDicts (dicts: with dicts; [en sl]))

    # WM
    river-classic
    #fuzzel
    mako
    swaybg
    wl-clipboard
    wl-screenrec
    sway-contrib.grimshot
    #wf-recorder
    gammastep
    #xdg-desktop-portal-wlr
    brightnessctl
    wayprompt

    catppuccin-cursors.mochaMauve

    # programs
    #vesktop
    discord
    pkgs-unstable.signal-desktop
    signalbackup-tools
    zulip
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
    stremio-linux-shell
    prismlauncher
    vintagestory

    # languages
    (agda.withPackages (p: [ p.standard-library ]))
    texliveFull
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
      "x-scheme-handler/vintagestorymodinstall" = "vintagestory.desktop";
    };
  };

  # do NOT the version
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
