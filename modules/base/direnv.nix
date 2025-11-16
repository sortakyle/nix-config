{
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

  flake.modules.nixos.base = {
    hostConfig,
    lib,
    ...
  }: {
    preservation.preserveAt."/persist".users =
      lib.mapAttrs (_: _: {
        directories = [".local/share/direnv"];
      })
      hostConfig.users;
  };
}
