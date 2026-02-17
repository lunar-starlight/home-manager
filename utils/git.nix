{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Luna Strah";
      user.email = "45151812+lunar-starlight@users.noreply.github.com";
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
    };
  };

  programs.keychain = {
    enable = true;
    #enableFishIntegration = true;
    keys = [
      "id_github"
    ];
    extraFlags = [ "--systemd" "--ssh-agent-socket '/home/muf/.ssh/agent/keychain'" "--quiet" ];
  };

  systemd.user.sessionVariables.SSH_AUTH_SOCK = "/home/muf/.ssh/agent/keychain";
}
