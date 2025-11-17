{
  flake.modules.nixos.base = {
    preserve.users.directories = [".local/share/direnv"];
  };

  flake.modules.homeManager.base = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        global = {
          hide_env_diff = true;
          warn_timeout = "100s";
        };
      };
    };
  };
}
