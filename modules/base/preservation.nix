{
  flake.modules.nixos.base = {
    hostConfig,
    pkgs,
    inputs,
    ...
  }: {
    imports = [
      inputs.preservation.nixosModules.default
    ];

    preservation.enable = hostConfig.preservation.enable;
    # pverservation required initrd using systemd.
    boot.initrd.systemd.enable = true;

    environment.systemPackages = with pkgs; [
      # `sudo ncdu -x /`
      ncdu
    ];
  };

  flake.modules.homeManager.base = {
    hostConfig,
    ...
  }: {
    preservation.preserveAt."/persist".users.${hostConfig.primaryUser} = {
      commonMountOptions = [
        "x-gvfs-hide"
      ];
    };
  };
}