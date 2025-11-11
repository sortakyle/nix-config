{
  flake.modules.nixos.base = {
    hostConfig,
    lib,
    ...
  }: {
    config = {
      preservation.preserveAt = lib.mkIf (hostConfig.preservation.enable == false) (lib.mkForce {});
    };
  };

  flake.modules.homeManager.base = {
    hostConfig,
    lib,
    ...
  }: {
    config = {
      preservation.preserveAt = lib.mkIf (hostConfig.preservation.enable == false) (lib.mkForce {});
    };
  };
}