{ ... }:
{
  imports = [
    ./git.nix
    ./mpv.nix
    ./vim.nix
    ./fish.nix
    ./yazi.nix
    ./keychain.nix
    ./spacemacs.nix
    ./alacritty.nix
  ];

  services.copyq.enable = true;
}
