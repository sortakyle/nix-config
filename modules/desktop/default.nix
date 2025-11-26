{config, ...}: {
  flake.modules.nixos.desktop = {host, ...}: {
    imports = [
      config.flake.modules.nixos."desktop-${host.compositor}"
      config.flake.modules.nixos."desktop-${host.environment}"
    ];
  };

  flake.modules.homeManager.desktop = {host, ...}: {
    imports = [
      config.flake.modules.homeManager."desktop-${host.compositor}"
      config.flake.modules.homeManager."desktop-${host.environment}"
    ];
  };
}
