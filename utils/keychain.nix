{ ... }:
{
  programs.keychain = {
    enable = true;
    enableFishIntegration = true;
    keys = [
      "id_github"
    ];
    extraFlags = [ "--systemd" "--quiet" ];
  };
}
