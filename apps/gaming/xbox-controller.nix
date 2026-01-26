{
  flake.modules.nixos.gaming = {
    config,
    pkgs,
    lib,
    ...
  }: {
    # defining the following instead of using hardware.xone.enable in order to pin versions
    # hardware.xone.enable = true;

    boot = {
      blacklistedKernelModules = [
        "xpad"
        "mt76x2u"
      ];
      extraModulePackages = with config.boot.kernelPackages; [
        # Pinning to version 0.4.8 as 0.5.0 seems to not work with my dongle
        (xone.overrideAttrs (prev: {
          version = "0.4.8";
          src = prev.src.override {
            hash = "sha256-EXJBqzO4e2SJGrPvB0VYzIQf09uo5OfNdBQw5UqskYg=";
          };
        }))
      ];
    };

    hardware.firmware = [pkgs.xow_dongle-firmware];
    hardware.xpad-noone.enable = lib.mkDefault true;
  };
}
