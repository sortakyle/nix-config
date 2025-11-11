{
  flake.modules.homeManager.base = {
    lib,
    ...
  }: {
    home = {
      stateVersion = lib.mkDefault "25.05";
      sessionPath = ["$HOME/.local/bin"];
    };

    programs.home-manager.enable = true;
  };
}