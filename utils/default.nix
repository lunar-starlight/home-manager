{ ... }:
{
  imports = [
    ./git.nix
    ./mpv.nix
    ./vim.nix
    ./fish.nix
    ./yazi.nix
    ./kanshi.nix
    ./keychain.nix
    ./spacemacs.nix
    ./alacritty.nix
  ];

  services.copyq.enable = true;
  services.polkit-gnome.enable = true;
}
