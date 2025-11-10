{
  description = "Home Manager config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser-flake.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = inputs@{
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    zen-browser-flake,
    ...
  }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      desktop = "pink-pear";
      laptop = "rainbow-lemon";
      pkgs          = import nixpkgs          { inherit system; };
      pkgs-unstable = import nixpkgs-unstable { inherit system; };
      zen-browser   = zen-browser-flake.packages."${system}".default;
    in {
      homeConfigurations.muf = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit pkgs-unstable;
          inherit zen-browser;
          hostname = desktop;
        };
        modules = [
          ./home.nix
        ];
      };
    };
}
