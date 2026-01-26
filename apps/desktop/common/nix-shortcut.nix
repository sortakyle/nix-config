{
  flake.modules.homeManager.desktop = {config, ...}: {
    xdg.desktopEntries.nix-config = {
      name = "Nix Config";
      exec = "code ${config.home.homeDirectory}/.nix-config/";
      icon = "nix-snowflake";
      comment = "Opens .nix-config in VS Code for modification";
    };
  };
}
