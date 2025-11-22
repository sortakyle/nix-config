{
  flake.modules.homeManager.base = {pkgs, ...}: {
    programs.starship = {
      enable = true;
      package = pkgs.stable.starship;
      settings = {};
    };

    stylix.targets.starship.enable = true;
  };
}
