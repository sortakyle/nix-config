{
  flake.modules.nixos.base = {
    preserve.users.files = [".config/gh/hosts.yml"];
  };

  flake.modules.homeManager.base = {
    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };
  };
}
