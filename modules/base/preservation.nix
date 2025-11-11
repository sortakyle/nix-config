{
  flake.modules.nixos.base = {
    hostConfig,
    pkgs,
    inputs,
    lib,
    ...
  }: {
    imports = [
      inputs.preservation.nixosModules.default
    ];

    preservation.enable = hostConfig.preservation.enable;

    environment.systemPackages = with pkgs; [
      # `sudo ncdu -x /`
      ncdu
    ];

    preservation.preserveAt."/persist".users = lib.mapAttrs (_: _: {
      commonMountOptions = [
        "x-gvfs-hide"
      ];
    }) hostConfig.users;
  };
}