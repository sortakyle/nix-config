{
  flake.modules.nixos.base = {
    services = {
      dbus.implementation = "broker";
      fwupd.enable = true;
    };

    hardware.enableRedistributableFirmware = true;
  };
}
