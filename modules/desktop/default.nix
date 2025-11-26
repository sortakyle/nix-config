{config, ...}: {
  flake.modules.nixos.desktop = {hostConfig, ...}: {
    imports = [
      config.flake.modules.nixos."desktop-${hostConfig.compositor}"
      config.flake.modules.nixos."desktop-${hostConfig.environment}"
    ];
  };

  flake.modules.homeManager.desktop = {hostConfig, ...}: {
    imports = [
      config.flake.modules.homeManager."desktop-${hostConfig.compositor}"
      config.flake.modules.homeManager."desktop-${hostConfig.environment}"
    ];
  };
}
