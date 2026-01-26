{lib, ...}: {
  hosts.options.zfs = lib.mkOption {
    type = lib.types.submodule {
      options = {
        enableRollback = lib.mkEnableOption "Enable impermanence rollback to blank zfs snapshot on boot";

        devices = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
          example = ["/dev/disk/by-id/ata-512GB_SSD_MQ08B81904931"];
          description = lib.mdDoc ''
            Names of the disks that back the rpool. These names will be converted
            into systemd units for use in the boot setup
          '';
        };
      };
    };
  };
}
