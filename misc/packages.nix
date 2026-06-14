{ pkgs, pkgs-unstable, zen-browser, ...}:
let
  stremio-linux-shell = (pkgs.callPackage ../packages/stremio-linux-shell/package.nix {});
in
{
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
    gparted

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
    (deadbeef-with-plugins.override {
      plugins = with deadbeefPlugins; [
        headerbar-gtk3
        mpris2
        musical-spectrum
        playlist-manager
      ];
    })
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
}
