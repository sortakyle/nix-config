{
  flake.modules.homeManager.base = {
    programs.fzf = {
      enable = true;
    };

    stylix.targets.fzf.enable = true;
  };
}
