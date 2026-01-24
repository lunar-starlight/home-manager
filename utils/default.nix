{ ... }:
{
  imports = [
    ./git.nix
    ./vim.nix
    ./fish.nix
    ./spacemacs.nix
    ./alacritty.nix
  ];

  services.copyq.enable = true;
}
