{
  flake.modules.homeManager.base = {
    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        alias = {
          last = "log -1 HEAD --stat";
        };
        init.defaultBranch = "main";
        user = {
          name = "Kyle Bartz";
          email = "mail@kyle.fail";
        };
      };
      ignores = [
        ".direnv"
      ];
    };
  };
}
