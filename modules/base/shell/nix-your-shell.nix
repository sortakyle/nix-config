{
  flake.modules.homeManager.base = {
    programs.nix-your-shell = {
      enable = true;
    };
  };
}
