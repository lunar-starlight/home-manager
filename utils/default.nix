{ ... }:
{
  imports = [
    ./git.nix
    ./vim.nix
    ./fish.nix
    ./yazi.nix
    ./spacemacs.nix
    ./alacritty.nix
  ];

  services.copyq.enable = true;
}
