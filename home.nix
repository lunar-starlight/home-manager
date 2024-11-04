{ config, pkgs, pkgs-unstable, ... }:
{
  imports = [
    ./wayland
  ];

  home = {
    username = "muf";
    homeDirectory = "/home/muf";
    #keyboard = {
    #  layout = "us";
    #  model = "pc105";
    #};
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
    zsh
    pulsemixer
    pkgs-unstable.kmonad
    
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

    catppuccin-cursors.mochaMauve

    # programs
    discord
    pkgs-unstable.signal-desktop
    signalbackup-tools
  ];

  programs.git = {
    enable = true;
    userName = "Luna Strah";
    userEmail = "strah.luna@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.alacritty = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
  };




  # do NOT the version
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
