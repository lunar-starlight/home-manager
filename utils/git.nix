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
    keys = [
      "id_github"
    ];
  };
}
