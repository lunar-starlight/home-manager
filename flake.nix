{
  description = "Home Manager config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
      laptop  = "rainbow-lemon";
      pkgs          = import nixpkgs          { inherit system; };
      pkgs-unstable = import nixpkgs-unstable { inherit system; };
      zen-browser   = zen-browser-flake.packages."${system}".default;
      machine = { hostname, extraSpecialArgs ? {}, modules ? []}: {
        homeConfigurations."muf@${hostname}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit pkgs-unstable;
            inherit zen-browser;
            hostname = hostname;
          } // extraSpecialArgs;
          modules = [
            ./home.nix
          ] ++ modules;
        };
      };
    in 
      lib.attrsets.foldAttrs (x: acc: x // acc) {} [
        (machine { hostname = desktop; })
        (machine { hostname = laptop; })
      ];
}
