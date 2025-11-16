{
  flake.modules.nixos.zfs = {
    boot = {
      supportedFilesystems.zfs = true;

      zfs = {
        allowHibernation = false;
        forceImportRoot = false;
      };
    };

    services.zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };
  };
}
