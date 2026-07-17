{ hostname, ... } :
{
  imports = [
    ./xkb.nix
    ./compose.nix
    ./${hostname}.nix
  ];
}
