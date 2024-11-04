{
  description = "Home Manager config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs          = import nixpkgs          { inherit system; };
      pkgs-unstable = import nixpkgs-unstable { inherit system; };
    in {
      homeConfigurations.muf = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit pkgs-unstable;
        };
        modules = [ ./home.nix ];
      };
    };
}
