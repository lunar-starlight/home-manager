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
    };
  };

  programs.keychain = {
    enable = true;
    keys = [
      "id_github"
    ];
  };
}
