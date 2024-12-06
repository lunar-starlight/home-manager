{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Luna Strah";
    userEmail = "45151812+lunar-starlight@users.noreply.github.com";
    extraConfig = {
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
    keys = [
      "id_github"
    ];
  };
}
