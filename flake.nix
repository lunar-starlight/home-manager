{
  description = "Home Manager config flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-25.11/nixexprs.tar.xz";
    nixpkgs-unstable.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";

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
    pkgs          = import nixpkgs          { inherit system; };
    pkgs-unstable = import nixpkgs-unstable { inherit system; };
    zen-browser   = zen-browser-flake.packages."${system}".default;
    machine = { hostname, extraSpecialArgs ? {}, modules ? []}: {
      homeConfigurations."muf@${hostname}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit hostname pkgs-unstable zen-browser;
        } // extraSpecialArgs;
        modules = [
          ./home.nix
        ] ++ modules;
      };
    };
    hosts = [
      { hostname = "pink-pear"; }
      { hostname = "rainbow-lemon"; }
    ];
  in
    lib.foldAttrs lib.mergeAttrs {} (
      lib.map machine hosts
    );
}
