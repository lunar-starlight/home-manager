{ ... }:
{
  programs.keychain = {
    enable = true;
    enableFishIntegration = true;
    keys = [
      "id_github"
    ];
    extraFlags = [ "--systemd" "--ssh-agent-socket '/home/muf/.ssh/agent/keychain'" "--quiet" "--clear" ];
  };

  systemd.user.sessionVariables.SSH_AUTH_SOCK = "/home/muf/.ssh/agent/keychain";
}
