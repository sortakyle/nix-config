{
  flake.modules.nixos.zfs = _: {
    services.sanoid = {
      enable = true;
      templates.backup = {
        hourly = 36;
        daily = 30;
        monthly = 3;
        autosnap = true;
        autoprune = true;
      };
    };
  };
}
