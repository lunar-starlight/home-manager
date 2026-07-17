{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
}:

rustPlatform.buildRustPackage {
  pname = "riverql";
  version = "0.2.4";

  src = fetchFromGitHub {
    owner = "typester";
    repo = "riverql";
    rev = "b9d0355b8bc7e4afa8f0f1b052795a25cf2fb0eb";
    hash = "sha256-Hm3FrCNUejwRUY8Ys6hMaIpY4lFPf4T5p1aOyvz7OVE=";
  };

  cargoHash = "sha256-5lMjMUJeauohhIAUHbefTKRe7nsjlidyWkhiF315n9A=";

  passthru.updateScript = nix-update-script { extraArgs = [ "--version=branch" ]; };

  meta = {
    description = "River-status client over GraphQL";
    homepage = "https://github.com/typester/riverql";
    license = lib.licenses.mit;
    maintainers = [ ];
    mainProgram = "riverql";
  };
}
